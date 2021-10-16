package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.repo.ProjectRepo;
import com.psu.projectmethod.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import javax.validation.Valid;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private FileService fileService;

    public Project findProjectById(Long projectId) {
        return projectRepo.findByProjectId(projectId);
    }

    public List<Project> projectList() {
        return projectRepo.findAll();
    }

    public List<Integer> countProjectStatuses() {
        List<Project> projectList = projectList();
        List<Integer> countProjectStatuses = new ArrayList<>(List.of(Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0)));
        for (Project project :
                projectList) {
            if (project.getProjectStatus().equals(Status._1_BACKLOG)) {
                countProjectStatuses.set(0, countProjectStatuses.get(0) + 1);
            } else if (project.getProjectStatus().equals(Status._2_TO_DO))
                countProjectStatuses.set(1, countProjectStatuses.get(1) + 1);
            else if (project.getProjectStatus().equals(Status._3_IN_PROGRESS))
                countProjectStatuses.set(2, countProjectStatuses.get(2) + 1);
            else if (project.getProjectStatus().equals(Status._4_DONE))
                countProjectStatuses.set(3, countProjectStatuses.get(3) + 1);
            else if (project.getProjectStatus().equals(Status._5_ON_CHECK))
                countProjectStatuses.set(4, countProjectStatuses.get(4) + 1);
            else if (project.getProjectStatus().equals(Status._6_VERIFIED))
                countProjectStatuses.set(5, countProjectStatuses.get(5) + 1);
            else if (project.getProjectStatus().equals(Status._7_COMPLETED))
                countProjectStatuses.set(6, countProjectStatuses.get(6) + 1);
        }
        return countProjectStatuses;
    }

    public List<Double> percentageProjectStatuses() {
        Integer size = projectRepo.findAll().size();
        List<Double> percentageProjectStatuses = new ArrayList<>(List.of(Double.valueOf(0), Double.valueOf(0), Double.valueOf(0), Double.valueOf(0), Double.valueOf(0), Double.valueOf(0), Double.valueOf(0)));
        List<Integer> countProjectStatuses = countProjectStatuses();
        for (int i = 0; i < countProjectStatuses.size(); i++) {
            percentageProjectStatuses.set(i, Math.round(Double.valueOf(countProjectStatuses.get(i)) / size * 10000) / Double.valueOf(100));
        }
        return percentageProjectStatuses;
    }

    public Page<Project> projectPage(Integer pageNo, Integer pageSize, String search) {
        Pageable paging;
        paging = PageRequest.of(pageNo, pageSize, Sort.by("projectCreatedTime").descending());
        if (search != null && !search.isEmpty()) {
            return projectRepo.findByProjectNameContains(search, paging);
        } else {
            return projectRepo.findAll(paging);
        }
    }

    public Page<Project> myProjectPage(User user, Integer pageNo, Integer pageSize, String search) {
        Pageable paging;
            paging = PageRequest.of(pageNo, pageSize, Sort.by("projectCreatedTime").descending());
        if (user.isTeacher()) {
            if (search != null && !search.isEmpty()) {
                return projectRepo.findByProjectLeadAndProjectNameContains(user, search, paging);
            } else {
                return projectRepo.findByProjectLead(paging, user);
            }
        } else {
            if (search != null && !search.isEmpty()) {
                return projectRepo.findByPStudentAndProjectNameContains(user, search, paging);
            } else {
                return projectRepo.findByStudent(paging, user);
            }
        }
    }

    public List<Project> myProjectList(User user) {
        if (user.isTeacher()) {
            return projectRepo.findByProjectLead(user);
        } else {
            return projectRepo.findByStudent(user);
        }
    }

    public Long createProject(Project project, User user) {
        project.setProjectRating(Double.valueOf(0));
        project.addProjectLead(user);
        project.setProjectStatus(Status._1_BACKLOG);
        project.setProjectStarted(false);
        project.setProjectFinished(false);
        project.setProjectCreatedTime(LocalDateTime.now());
        projectRepo.save(project);
        return project.getProjectId();
    }

    public void startProject(Project project) {
        if (!project.getProjectStarted() && !project.getProjectStages().isEmpty() && !project.getProjectTeams().isEmpty() &&
                teamsWithCaptains(project)) {
            for (Stage stage :
                    project.getProjectStages()) {
                for (Team team :
                        stage.getStageProject().getProjectTeams()) {
                    Answer answer = new Answer();
                    answer.addStageAndTeamAndCaptain(stage, team, team.getTeamCaptain());
                    answer.setAnswerRating((double) 0);
                    answer.setAnswerStatus(Status._2_TO_DO);
                }
            }
            project.setProjectStarted(true);
            project.setProjectStartTime(LocalDateTime.now());
            projectRepo.save(project);
        }
    }

    public void finishProject(Project project) {
        if (!project.getProjectFinished()) {
            for (Stage stage :
                    project.getProjectStages()) {
                stage.setStageRating();
            }
            for (Team team :
                    project.getProjectTeams()) {
                team.setTeamRating();
                for (User user :
                        team.getTeamUsers()) {
                    user.setUserRating();
                    userRepo.save(user);
                }
            }
            User projectLead = project.getProjectLead();
            projectLead.setUserRating();
            userRepo.save(projectLead);
            project.setProjectRating();
            project.setProjectFinished(true);
            project.setProjectEndTime(LocalDateTime.now());
            projectRepo.save(project);
        }
    }

    public void updateProjectStatus(Project project, String status) {
        List<String> statusList = Arrays.stream(Status.values())
                .map(Status::name)
                .collect(Collectors.toList());
        if (statusList.contains(status)) {
            if (project.getProjectStatus().equals(Status._2_TO_DO) && status.equals("_1_BACKLOG")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            } else if ((project.getProjectStatus().equals(Status._1_BACKLOG) || project.getProjectStatus().equals(Status._3_IN_PROGRESS)) && status.equals("_2_TO_DO")) {
                project.setProjectStatus(Status.valueOf(status));
                project.setProjectStartTime(LocalDateTime.now());
                projectRepo.save(project);
            } else if ((project.getProjectStatus().equals(Status._2_TO_DO) || project.getProjectStatus().equals(Status._4_DONE)) && status.equals("_3_IN_PROGRESS")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            } else if ((project.getProjectStatus().equals(Status._3_IN_PROGRESS) || project.getProjectStatus().equals(Status._5_ON_CHECK)) && status.equals("_4_DONE")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            } else if ((project.getProjectStatus().equals(Status._4_DONE) || project.getProjectStatus().equals(Status._6_VERIFIED)) && status.equals("_5_ON_CHECK")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            } else if ((project.getProjectStatus().equals(Status._5_ON_CHECK) || project.getProjectStatus().equals(Status._7_COMPLETED)) && status.equals("_6_VERIFIED")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            } else if (project.getProjectStatus().equals(Status._6_VERIFIED) && status.equals("_7_COMPLETED")) {
                project.setProjectStatus(Status.valueOf(status));
                projectRepo.save(project);
            }
        }

    }

    public Double myProjectsRating(List<Project> myProjectPage) {
        if (myProjectPage.size() != 0) {
            Double myProjectsRating = Double.valueOf(0);
            Double size = Double.valueOf(0);
            for (Project project :
                    myProjectPage) {
                if (project.getProjectStatus().equals(Status._7_COMPLETED)) {
                    size++;
                    myProjectsRating += project.getProjectRating();
                }
            }
            if (size != 0)
                myProjectsRating /= size;
            return myProjectsRating;

        } else return Double.valueOf(0);
    }

    public Double mySuccessfulProjects(List<Project> myProjectPage) {
        if (myProjectPage.size() != 0) {
            Double mySuccessfulProjects = Double.valueOf(0);
            Double size = Double.valueOf(myProjectPage.size());
            for (Project project :
                    myProjectPage) {
                if (project.getProjectStatus().equals(Status._7_COMPLETED)) {
                    mySuccessfulProjects++;
                }
            }
            mySuccessfulProjects /= size;
            return mySuccessfulProjects * 100;
        } else return Double.valueOf(0);
    }

    public Boolean userInProjectTeam(Project project, User user) {
        for (Team team :
                project.getProjectTeams()) {
            if (team.getTeamUsers().contains(user))
                return true;
        }
        return false;
    }

    public Long userTeam(Project project, User user) {
        Long userTeam = null;
        for (Team team :
                project.getProjectTeams()) {
            if (team.getTeamUsers().contains(user))
                userTeam = team.getTeamId();
        }
        return userTeam;
    }

    public List<Boolean> teacherInProjects(Page<Project> projects, User user) {
        List<Boolean> teacherInProjects = new ArrayList<>();
        for (Project project :
                projects) {
            if (project.getProjectLead().equals(user)) {
                teacherInProjects.add(true);
            } else {
                teacherInProjects.add(false);
            }
        }
        return teacherInProjects;
    }

    public List<Boolean> studentInProjects(Page<Project> projects, User user) {
        List<User> usersInProject = new ArrayList<>();
        List<Boolean> userInProjects = new ArrayList<>();
        for (Project project :
                projects) {
            for (Team team :
                    project.getProjectTeams()) {
                usersInProject.addAll(team.getTeamUsers());
            }
            if (usersInProject.contains(user)) {
                userInProjects.add(true);
            } else {
                userInProjects.add(false);
            }
            usersInProject.clear();
        }
        return userInProjects;
    }


    public Boolean teamsWithCaptains(Project project) {
        for (Team team :
                project.getProjectTeams()) {
            if (team.getTeamCaptain() == null)
                return false;
        }
        return true;
    }

    public Boolean projectStagesInStatus(Project project, Status status) {
        for (Stage stage :
                project.getProjectStages()) {
            if (!stage.getStageStatus().equals(status))
                return false;
        }
        return true;
    }

    public List<Boolean> stagesAnswersStatusIs(Project project, Status status) {
        List<Boolean> stagesAnswersStatusIsBooleans = new ArrayList<>();
        for (Stage stage :
                project.getProjectStages()) {
            for (Answer answer :
                    stage.getStageAnswers()) {
                if (!answer.getAnswerStatus().equals(status))
                    stagesAnswersStatusIsBooleans.add(false);
                else stagesAnswersStatusIsBooleans.add(true);
            }
        }
        return stagesAnswersStatusIsBooleans;
    }

    public void uploadFile(@Valid Project project, @RequestParam("file") MultipartFile file) {
        if (file.getSize() > 0 && !file.getOriginalFilename().isBlank()) {
            java.io.File uploadDir = new java.io.File(fileService.getUploadPath());
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();
            try {
                file.transferTo(new java.io.File(fileService.getUploadPath() + "/" + resultFilename));
            } catch (IOException e) {
                e.printStackTrace();
            }
            project.setProjectImage(resultFilename);
        }
    }

    public void uploadFiles(@Valid Project project, @RequestParam("files") MultipartFile[] files) {
        List<MultipartFile> multipartFiles = Arrays.asList(files);
        if (files != null && multipartFiles.size() > 0) {
            java.io.File uploadDir = new java.io.File(fileService.getUploadPath());
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            for (MultipartFile multipartFile : files) {
                if (multipartFile.getSize() > 0 && !multipartFile.getOriginalFilename().isBlank()) {
                    com.psu.projectmethod.domain.File file = fileService.getFile(multipartFile);
                    fileService.saveFile(file);
                    project.addFile(file);
                }
            }
        }
    }

    public boolean studentInProject(Project project, User user) {
        for (Team team :
                project.getProjectTeams()) {
            if (team.getTeamUsers().contains(user)) {
                return true;
            }
        }
        return false;
    }

    public List<User> studentsDontAddedInProject(Project project) {
        List<User> studentsDontAddedInProject = userRepo.findByRolesEquals(Role._3_STUDENT);
        for (Team team :
                project.getProjectTeams()) {
            for (User user :
                    team.getTeamUsers()) {
                studentsDontAddedInProject.remove(user);
            }
        }
        return studentsDontAddedInProject;
    }

    public List<User> studentsInProject(Project project) {
        List<User> studentsInProject = new ArrayList<>();
        for (Team team :
                project.getProjectTeams()) {
            for (User user :
                    team.getTeamUsers()) {
                studentsInProject.add(user);
            }
        }
        return studentsInProject;
    }

    public boolean isProjectTimeInFuture(Project project) {
        if (project.getProjectTheoreticalLeadTime().isAfter(LocalDateTime.now())) {
            return true;
        }
        return false;
    }
}
