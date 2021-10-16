package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.repo.StageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class StageService {
    @Autowired
    private StageRepo stageRepo;

    @Autowired
    private FileService fileService;

    public Stage findByStageId(Long stageId) {
        return stageRepo.findByStageId(stageId);
    }

    public List<Stage> findAllByStageProject(Project project) {
        return stageRepo.findAllByStageProject(project);
    }

    public Long createProjectStage(Project project, Stage stage) {
        stage.setStageStatus(Status._1_BACKLOG);
        project.addStage(stage);
        stageRepo.save(stage);
        return stage.getStageId();
    }

    public void updateStageStatus(Stage stage, String status) {
        List<String> statusList = Arrays.stream(Status.values())
                .map(Status::name)
                .collect(Collectors.toList());
        if (statusList.contains(status)) {
            if (stage.getStageStatus().equals(Status._2_TO_DO) && status.equals("_1_BACKLOG")) {
                stage.setStageStatus(Status.valueOf(status));
                stage.setStageStartTime(LocalDateTime.now());
                stageRepo.save(stage);
            } else if ((stage.getStageStatus().equals(Status._1_BACKLOG) || stage.getStageStatus().equals(Status._3_IN_PROGRESS)) && status.equals("_2_TO_DO")) {
                stage.setStageStatus(Status.valueOf(status));
                stage.setStageStartTime(LocalDateTime.now());
                stageRepo.save(stage);
            } else if ((stage.getStageStatus().equals(Status._2_TO_DO) || stage.getStageStatus().equals(Status._4_DONE)) && status.equals("_3_IN_PROGRESS")) {
                stage.setStageStatus(Status.valueOf(status));
                stageRepo.save(stage);
            } else if ((stage.getStageStatus().equals(Status._3_IN_PROGRESS) || stage.getStageStatus().equals(Status._5_ON_CHECK)) && status.equals("_4_DONE")) {
                stage.setStageStatus(Status.valueOf(status));
                stageRepo.save(stage);
            } else if ((stage.getStageStatus().equals(Status._4_DONE) || stage.getStageStatus().equals(Status._6_VERIFIED)) && status.equals("_5_ON_CHECK")) {
                stage.setStageStatus(Status.valueOf(status));
                stageRepo.save(stage);
            } else if ((stage.getStageStatus().equals(Status._5_ON_CHECK) || stage.getStageStatus().equals(Status._7_COMPLETED)) && status.equals("_6_VERIFIED")) {
                if (stageAnswersStatusIs(stage, Status._6_VERIFIED) || stageAnswersStatusIs(stage, Status._7_COMPLETED)) {
                    stage.setStageStatus(Status.valueOf(status));
                    stageRepo.save(stage);
                }
            } else if (stage.getStageStatus().equals(Status._6_VERIFIED) && status.equals("_7_COMPLETED")) {
                stage.setStageStatus(Status.valueOf(status));
                stage.setStageEndTime(LocalDateTime.now());
                stageRepo.save(stage);
            }
        }
    }

    public Boolean stageAnswerStatusIs(Stage stage, Status status) {
        for (Answer answer :
                stage.getStageAnswers()) {
            if (!answer.getAnswerStatus().equals(status))
                return false;
        }
        return true;
    }

    public Boolean stageAnswersStatusIs(Stage stage, Status status) {
        for (Answer answer :
                stage.getStageAnswers()) {
            if (!answer.getAnswerStatus().equals(status))
                return false;
        }
        return true;
    }


    public Stage getPrevStage(@PathVariable("projectId") Project project, @Valid Stage stage) {
        Iterator<Stage> stageIterator = project.getProjectStages().iterator();

        Stage previousStage = null;
        Long currentStage = stage.getStageId();

        while (stageIterator.hasNext()) {
            stage = stageIterator.next();
            if (stage.getStageId() == currentStage) {
                if (stageIterator.hasNext())
                    break;
            }
            previousStage = stage;
        }
        return previousStage;
    }

    public Stage getNextStage(@PathVariable("projectId") Project project, @Valid Stage stage) {
        Iterator<Stage> stageIterator = project.getProjectStages().iterator();

        Stage nextStage = null;
        Long currentStage = stage.getStageId();

        while (stageIterator.hasNext()) {
            stage = stageIterator.next();
            if (stage.getStageId() == currentStage) {
                if (stageIterator.hasNext())
                    nextStage = stageIterator.next();
                break;
            }
        }
        return nextStage;
    }

    public static void getPrevAndNextStage(@PathVariable("projectId") Project project, @PathVariable("stageId") Stage stage, Model model) {
        Iterator<Stage> stageIterator = project.getProjectStages().iterator();

        Stage nextStage = null;
        Stage previousStage = null;
        Long currentStage = stage.getStageId();

        while (stageIterator.hasNext()) {
            stage = stageIterator.next();
            if (stage.getStageId() == currentStage) {
                if (stageIterator.hasNext())
                    nextStage = stageIterator.next();
                break;
            }
            previousStage = stage;
        }

        model.addAttribute("previousStage", previousStage);
        model.addAttribute("nextStage", nextStage);
    }

    public void uploadFile(@Valid Stage stage, @RequestParam("file") MultipartFile file) {
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
            stage.setStageImage(resultFilename);
        }
    }

    public void uploadFiles(@Valid Stage stage, @RequestParam("files") MultipartFile[] files) {
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
                    stage.addFile(file);
                }
            }
        }
    }

    public boolean isStageTimeInFuture(Stage stage) {
        if (stage.getStageTheoreticalLeadTime().isAfter(LocalDateTime.now())) {
            return true;
        }
        return false;
    }

    public boolean isStageTimeEarlierThanProjectTime(Stage stage, Project project) {
        if (stage.getStageTheoreticalLeadTime().isBefore(project.getProjectTheoreticalLeadTime())) {
            return true;
        }
        return false;
    }

    public boolean isStageTimeLaterThanPrevStageTime(Project project, Stage stage) {
        Stage prevStage = getPrevStage(project, stage);
        if (prevStage != null) {
            if (stage.getStageTheoreticalLeadTime().isAfter(prevStage.getStageTheoreticalLeadTime())) {
                return true;
            }
            return false;
        } else return true;
    }

}
