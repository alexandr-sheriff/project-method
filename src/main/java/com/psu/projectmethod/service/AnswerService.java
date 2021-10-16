package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.repo.AnswerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class AnswerService {
    @Autowired
    private AnswerRepo answerRepo;

    @Autowired
    private FileService fileService;

    public Answer findAnswerByAnswerStageStageIdAndAnswerTeamTeamId(Long stageId, Long teamId) {
        return answerRepo.findAnswerByAnswerStageStageIdAndAnswerTeamTeamId(stageId, teamId);
    }

    public void sendAnswerByProjectByStage(Answer answer, Stage stage, Team team, User user) {
        answer.addStageAndTeamAndCaptain(stage, team, user);
        answer.setAnswerResponseTime(LocalDateTime.now());
        answerRepo.save(answer);
    }

    public void assessmentAnswerByProjectByStage(Answer answer) {
        answer.setAnswerAssessmentTime(LocalDateTime.now());
        answer.setAnswerAssessmentTime(LocalDateTime.now());
        answerRepo.save(answer);
    }

    public void updateAnswerStatus(Answer answer, String status, User user) {
        List<String> statusList = Arrays.stream(Status.values())
                .map(Status::name)
                .collect(Collectors.toList());
        if (statusList.contains(status)) {
            if (answer.getAnswerStage().getStageProject().getProjectLead().equals(user)) {
                if (answer.getAnswerStatus().equals(Status._2_TO_DO) && status.equals("_1_BACKLOG")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if ((answer.getAnswerStatus().equals(Status._1_BACKLOG) || answer.getAnswerStatus().equals(Status._3_IN_PROGRESS)) && status.equals("_2_TO_DO")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if ((answer.getAnswerStatus().equals(Status._2_TO_DO) || answer.getAnswerStatus().equals(Status._4_DONE)) && status.equals("_3_IN_PROGRESS")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if ((answer.getAnswerStatus().equals(Status._3_IN_PROGRESS) || answer.getAnswerStatus().equals(Status._5_ON_CHECK)) && status.equals("_4_DONE")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if ((answer.getAnswerStatus().equals(Status._4_DONE) || answer.getAnswerStatus().equals(Status._6_VERIFIED)) && status.equals("_5_ON_CHECK")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if ((answer.getAnswerStatus().equals(Status._5_ON_CHECK) || answer.getAnswerStatus().equals(Status._7_COMPLETED)) && status.equals("_6_VERIFIED")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if (answer.getAnswerStatus().equals(Status._6_VERIFIED) && status.equals("_7_COMPLETED")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                }
            } else if (answer.getAnswerUser().equals(user)) {
                if ((answer.getAnswerStatus().equals(Status._2_TO_DO) || answer.getAnswerStatus().equals(Status._4_DONE)) && status.equals("_3_IN_PROGRESS")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                } else if (answer.getAnswerStatus().equals(Status._3_IN_PROGRESS) && status.equals("_4_DONE")) {
                    answer.setAnswerStatus(Status.valueOf(status));
                    answerRepo.save(answer);
                }
            }
        }
    }

    public void uploadFiles(@Valid Answer answer, @RequestParam("files") MultipartFile[] files) {
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
                    answer.addFile(file);
                }
            }
        }
    }

    /*public void setProjectAndStageAndAnswerInProgress(Answer answer) {
        if (answer.getAnswerStatus().equals(Status._2_TO_DO) && answer.getAnswerStage().getStageTheoreticalLeadTime().isAfter(answer.getAnswerStage().getStageTheoreticalLeadTime().now())) {
            answer.getAnswerStage().getStageProject().setProjectStatus(Status._3_IN_PROGRESS);
            answer.getAnswerStage().setStageStatus(Status._3_IN_PROGRESS);
            answer.setAnswerStatus(Status._3_IN_PROGRESS);
            answerRepo.save(answer);
        }
    }*/
    

    /*public void setProjectAndStageAndAnswerOnCheck(Answer answer) {
        if (answer.getAnswerStatus().equals(Status._4_DONE) && answer.getAnswerStage().getStageTheoreticalLeadTime().isAfter(answer.getAnswerStage().getStageTheoreticalLeadTime().now())) {
            answer.setAnswerStatus(Status._5_ON_CHECK);
            answerRepo.save(answer);
        }
        boolean answersDone = answersDone(answer.getAnswerStage());
        boolean answersTimeEnd = answersTimeEnd(answer.getAnswerStage());
        if (answersDone || answersTimeEnd) {
            answer.getAnswerStage().getStageProject().setProjectStatus(Status._5_ON_CHECK);
            answer.getAnswerStage().setStageStatus(Status._5_ON_CHECK);
            answerRepo.save(answer);
        }
    }*/
    

    /*public boolean answersDone(Stage stage) {
        for (Answer answer :
                stage.getStageAnswers()) {
            if (!answer.getAnswerStatus().equals(Status._4_DONE)) return false;
        }
        return true;
    }

    public boolean answersTimeEnd(Stage stage) {
        for (Answer answer :
                stage.getStageAnswers()) {
            if (!answer.getAnswerStage().getStageTheoreticalLeadTime().isBefore(answer.getAnswerStage().getStageTheoreticalLeadTime().now())) return false;
        }
        return true;
    }*/

}
