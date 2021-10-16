package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.service.FileService;
import com.psu.projectmethod.service.ProjectService;
import com.psu.projectmethod.service.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import javax.validation.constraints.Future;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/projects")
public class StageController {
    @Autowired
    private StageService stageService;

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/stage/{stageId}")
    public String viewProjectStage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            Model model) {
        if (!project.getProjectLead().equals(currentUser))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("teams", project.getProjectTeams());
        StageService.getPrevAndNextStage(project, stage, model);
        return "stage";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/stage/create")
    public String viewCreateProjectStage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @ModelAttribute("stage") Stage stage,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !project.getProjectStatus().equals(Status._1_BACKLOG))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        return "teacherProjectStageCreate";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @PostMapping("/project/{projectId}/stage/create")
    public String processCreateProjectStage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @RequestParam("file") MultipartFile file,
            @RequestParam("files") MultipartFile[] files,
            @ModelAttribute("stage") @Valid Stage stage,
            BindingResult bindingResult,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !project.getProjectStatus().equals(Status._1_BACKLOG))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        boolean isStageTimeInFuture = stageService.isStageTimeInFuture(stage);
        if (!isStageTimeInFuture) {
            model.addAttribute("stageTheoreticalLeadTimeError", "Введен неверный срок сдачи. Срок сдачи должнен быть в будущем времени.");
        }
        boolean isStageTimeEarlierThanProjectTime = stageService.isStageTimeEarlierThanProjectTime(stage, project);
        if (!isStageTimeEarlierThanProjectTime) {
            model.addAttribute("stageTheoreticalLeadTimeError", "Введен неверный срок сдачи. Срок сдачи этапа должен быть раньше чем срок сдачи проекта.");
        }
        boolean isStageTimeLaterThanPrevStageTime = stageService.isStageTimeLaterThanPrevStageTime(project, stage);
        if (!isStageTimeLaterThanPrevStageTime) {
            model.addAttribute("stageTheoreticalLeadTimeError", "Введен неверный срок сдачи. Срок сдачи этапа должен быть позже чем срок сдачи предыдущего этапа.");
        }
        if (!isStageTimeEarlierThanProjectTime || !isStageTimeLaterThanPrevStageTime || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "teacherProjectStageCreate";
        } else {
            stageService.uploadFile(stage, file);
            stageService.uploadFiles(stage, files);
            Long stageId = stageService.createProjectStage(project, stage);
            return "redirect:/projects/project/" + project.getProjectId() + "/stage/" + stageId;
        }
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/stage/{stageId}/status/update")
    public String processUpdateProjectStageStatus(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @ModelAttribute("status") String status) {
        if (!project.getProjectLead().equals(currentUser))
            return "redirect:/projects/project/" + project.getProjectId();
        stageService.updateStageStatus(stage, status);
        return "redirect:/projects/project/" + project.getProjectId();
    }


}
