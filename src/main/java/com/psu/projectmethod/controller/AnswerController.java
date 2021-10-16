package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.service.AnswerService;
import com.psu.projectmethod.service.StageService;
import com.psu.projectmethod.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
public class AnswerController {
    @Autowired
    private AnswerService answerService;

    @Autowired
    private TeamService teamService;

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/stage/{stageId}/team/{teamId}")
    public String viewAnswer(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";
        Answer answerByStageAnswerStageIdAndTeamAnswerTeamId = answerService.findAnswerByAnswerStageStageIdAndAnswerTeamTeamId(stage.getStageId(), team.getTeamId());
        List<ChatMessage> teamMessages = team.getTeamChatMessages();

        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("team", team);
        model.addAttribute("teams", project.getProjectTeams());
        model.addAttribute("answer", answerByStageAnswerStageIdAndTeamAnswerTeamId);
        model.addAttribute("teamMessages", teamMessages);

        StageService.getPrevAndNextStage(project, stage, model);

        return "answer";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/stage/{stageId}/team/{teamId}/answer/{answerId}/status/update")
    public String processUpdateAnswerStatus(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            @PathVariable("answerId") Answer answer,
            @ModelAttribute("status") String status) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamCaptain().equals(currentUser))
            return "redirect:/projects";
        answerService.updateAnswerStatus(answer, status, currentUser);
        return "redirect:/projects/project/" + project.getProjectId() +
                "/stage/" + stage.getStageId() +
                "/team/" + team.getTeamId();
    }

    /*@PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/stage/{stageId}/team/{teamId}/answer/{answerId}/create")
    public String viewStudentCreateAnswerByProjectByStageByTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            @ModelAttribute("answerId") Answer answer,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";

        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("team", team);
        model.addAttribute("teams", project.getProjectTeams());
        model.addAttribute("answer", answer);

        StageService.getPrevAndNextStage(project, stage, model);

        return "answer";
    }*/

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @PostMapping("/project/{projectId}/stage/{stageId}/team/{teamId}/answer/{answerId}/create")
    public String processStudentCreateAnswer(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            @RequestParam("files") MultipartFile[] files,
            @ModelAttribute("answerId") @Valid Answer answer,
            BindingResult bindingResult,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";

        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("team", team);
        model.addAttribute("teams", project.getProjectTeams());
        model.addAttribute("answer", answer);

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "answer";
        } else {
            answerService.uploadFiles(answer, files);
            answerService.sendAnswerByProjectByStage(answer, stage, team, currentUser);
            return "redirect:/projects/project/" + project.getProjectId() +
                    "/stage/" + stage.getStageId() +
                    "/team/" + team.getTeamId();
        }
    }

    /*@PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/stage/{stageId}/team/{teamId}/answer/{answerId}/assessment/create")
    public String viewTeacherCreateAnswerAssessmentByProjectByStageByTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            @ModelAttribute("answerId") Answer answer,
            Model model) {

        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";

        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("team", team);
        model.addAttribute("teams", project.getProjectTeams());
        model.addAttribute("answer", answer);

        StageService.getPrevAndNextStage(project, stage, model);

        return "answer";
    }*/

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @PostMapping("/project/{projectId}/stage/{stageId}/team/{teamId}/answer/{answerId}/assessment/create")
    public String processTeacherCreateAnswerAssessment(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("stageId") Stage stage,
            @PathVariable("teamId") Team team,
            @ModelAttribute("answerId") @Valid Answer answer,
            BindingResult bindingResult,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";
        model.addAttribute("project", project);
        model.addAttribute("stage", stage);
        model.addAttribute("team", team);
        model.addAttribute("teams", project.getProjectTeams());
        model.addAttribute("answer", answer);
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "answer";
        } else {
            answerService.assessmentAnswerByProjectByStage(answer);
            return "redirect:/projects/project/" + project.getProjectId() +
                    "/stage/" + stage.getStageId() +
                    "/team/" + team.getTeamId();
        }
    }

}
