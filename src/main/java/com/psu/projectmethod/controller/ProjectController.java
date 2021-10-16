package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.service.ProjectService;
import com.psu.projectmethod.service.StageService;
import com.psu.projectmethod.service.TeamService;
import com.psu.projectmethod.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/projects")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private StageService stageService;

    @Autowired
    private TeamService teamService;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping
    public String viewProjects(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(required = false, defaultValue = "0") Integer page,
            @RequestParam(required = false, defaultValue = "6") Integer size,
            @RequestParam(required = false, defaultValue = "") String search,
            Model model) {
        Page<Project> projects = projectService.projectPage(page, size, search);
        List<Boolean> teacherInProjects = projectService.teacherInProjects(projects, currentUser);
        List<Boolean> studentInProjects = projectService.studentInProjects(projects, currentUser);
        model.addAttribute("url", "/projects");
        model.addAttribute("projects", projects);
        model.addAttribute("search", search);
        model.addAttribute("teacherInProjects", teacherInProjects);
        model.addAttribute("studentInProjects", studentInProjects);
        return "projects";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/user/{userId}")
    public String viewMyProjects(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            @RequestParam(required = false, defaultValue = "0") Integer page,
            @RequestParam(required = false, defaultValue = "6") Integer size,
            @RequestParam(required = false, defaultValue = "") String search,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        Page<Project> projects = projectService.myProjectPage(currentUser, page, size, search);
        model.addAttribute("url", "/projects/user/" + user.getUserId());
        model.addAttribute("projects", projects);
        model.addAttribute("search", search);
        return "myProjects";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/statistics-history/user/{userId}")
    public String viewStatHistoryMyProjects(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        List<Project> projects = projectService.myProjectList(currentUser);
        model.addAttribute("projects", projects);
        model.addAttribute("user", user);
        model.addAttribute("projectsCount", projects.size());
        model.addAttribute("projectsRating", projectService.myProjectsRating(projects));
        model.addAttribute("projectSuccess", projectService.mySuccessfulProjects(projects));
        return "projectsStatHistory";
    }

    @PreAuthorize("hasAuthority('_1_ADMIN') or hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}")
    public String viewProject(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            Model model) {
        boolean studentInProject = projectService.studentInProject(project, currentUser);
        if (!currentUser.isAdmin() && !project.getProjectLead().equals(currentUser) && !studentInProject)
            return "redirect:/projects";
        List<Stage> projectStages = stageService.findAllByStageProject(project);
        List<Team> projectTeams = teamService.findAllByTeamProject(project);
        List<User> findAllByRolesEquals = userService.findByRolesEquals(Sort.by("username"), Role._3_STUDENT);
        Boolean userInProjectTeam = projectService.userInProjectTeam(project, currentUser);
        Long userTeam = projectService.userTeam(project, currentUser);
        Boolean teamsWithCaptains = projectService.teamsWithCaptains(project);
        model.addAttribute("project", project);
        model.addAttribute("stages", projectStages);
        model.addAttribute("teams", projectTeams);
        model.addAttribute("users", findAllByRolesEquals);
        model.addAttribute("userInProjectTeam", userInProjectTeam);
        model.addAttribute("userTeam", userTeam);
        model.addAttribute("teamsWithCaptains", teamsWithCaptains);
        return "project";
    }

    @PreAuthorize("hasAuthority('_1_ADMIN') or hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/statistics")
    public String viewProjectStat(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            Model model) {
        boolean studentInProject = projectService.studentInProject(project, currentUser);
        if ((!currentUser.isAdmin() || !project.getProjectLead().equals(currentUser) || !studentInProject) && !project.getProjectFinished())
            return "redirect:/projects";
        List<Stage> projectStages = stageService.findAllByStageProject(project);
        List<Team> projectTeams = teamService.findAllByTeamProject(project);
        List<User> findAllByRolesEquals = userService.findByRolesEquals(Sort.by("username"), Role._3_STUDENT);
        Boolean userInProjectTeam = projectService.userInProjectTeam(project, currentUser);
        Long userTeam = projectService.userTeam(project, currentUser);
        model.addAttribute("project", project);
        model.addAttribute("stages", projectStages);
        model.addAttribute("teams", projectTeams);
        model.addAttribute("users", findAllByRolesEquals);
        model.addAttribute("userInProjectTeam", userInProjectTeam);
        model.addAttribute("userTeam", userTeam);
        return "projectStat";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/create")
    public String viewCreateProject(
            @AuthenticationPrincipal User currentUser,
            @ModelAttribute("project") Project project) {
        if (!currentUser.isTeacher())
            return "redirect:/projects";
        return "teacherProjectCreate";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @PostMapping("/project/create")
    public String processCreateProject(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("file") MultipartFile file,
            @RequestParam("files") MultipartFile[] files,
            @ModelAttribute("project") @Valid Project project,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.isTeacher())
            return "redirect:/projects";
        boolean isProjectTimeInFuture = projectService.isProjectTimeInFuture(project);
        if (!isProjectTimeInFuture) {
            model.addAttribute("projectTheoreticalLeadTimeError", "Введен неверный срок сдачи. Срок сдачи должнен быть в будущем времени.");
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "teacherProjectCreate";
        } else {
            projectService.uploadFile(project, file);
            projectService.uploadFiles(project, files);
            Long projectId = projectService.createProject(project, currentUser);
            return "redirect:/projects/project/" + projectId;
        }
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/start")
    public String startProject(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project) {
        if (!project.getProjectLead().equals(currentUser))
            return "redirect:/projects";
        projectService.startProject(project);
        return "redirect:/projects/project/" + project.getProjectId();
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/finish")
    public String finishProject(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project) {
        if (!project.getProjectLead().equals(currentUser))
            return "redirect:/projects";
        projectService.finishProject(project);
        return "redirect:/projects/project/" + project.getProjectId();
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/status/update")
    public String processUpdateProjectStatus(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @ModelAttribute("status") String status) {
        if (!project.getProjectLead().equals(currentUser))
            return "redirect:/projects";
        projectService.updateProjectStatus(project, status);
        return "redirect:/projects/project/" + project.getProjectId();
    }

}
