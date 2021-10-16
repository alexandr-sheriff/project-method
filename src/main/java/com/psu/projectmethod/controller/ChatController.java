package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.service.ChatMessageService;
import com.psu.projectmethod.service.ProjectService;
import com.psu.projectmethod.service.TeamService;
import com.psu.projectmethod.service.UserService;
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
public class ChatController {

    @Autowired
    private ChatMessageService chatMessageService;

    @Autowired
    private ProjectService projectService;

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/chat")
    public String viewProjectChat(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            Model model) {
        boolean studentInProject = projectService.studentInProject(project, currentUser);
        if (!project.getProjectLead().equals(currentUser) && !studentInProject)
            return "redirect:/projects/project/" + project.getProjectId();
        List<User> studentsInProject = projectService.studentsInProject(project);
        model.addAttribute("project", project);
        model.addAttribute("projectUsers", studentsInProject);
        model.addAttribute("projectMessages", project.getProjectChatMessages());
        return "chatProject";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @PostMapping("/project/{projectId}/chat")
    public String processChatProject(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @RequestParam("files") MultipartFile[] files,
            @Valid ChatMessage message,
            BindingResult bindingResult,
            Model model) {
        boolean studentInProject = projectService.studentInProject(project, currentUser);
        if (!project.getProjectLead().equals(currentUser) && !studentInProject)
            return "redirect:/projects";
        List<User> studentsInProject = projectService.studentsInProject(project);
        model.addAttribute("project", project);
        model.addAttribute("projectUsers", studentsInProject);
        model.addAttribute("projectMessages", project.getProjectChatMessages());
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "chatProject";
        } else {
            chatMessageService.userSendProjectChatMessage(currentUser, project, message, files);
            return "redirect:/projects/project/" + project.getProjectId() + "/chat";
        }
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/team/{teamId}/chat")
    public String viewProjectTeamChat(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("teamId") Team team,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        model.addAttribute("team", team);
        model.addAttribute("teamMessages", team.getTeamChatMessages());
        TeamService.getPrevAndNextTeam(project, team, model);
        return "chatTeam";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @PostMapping("/project/{projectId}/team/{teamId}/chat")
    public String processChatTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("teamId") Team team,
            @RequestParam("files") MultipartFile[] files,
            @Valid ChatMessage message,
            BindingResult bindingResult,
            Model model) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects";
        model.addAttribute("project", project);
        model.addAttribute("team", team);
        model.addAttribute("teamMessages", team.getTeamChatMessages());

        TeamService.getPrevAndNextTeam(project, team, model);

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "chatTeam";
        } else {
            chatMessageService.userSendTeamChatMessage(currentUser, team, message, files);
            return "redirect:/projects/project/" + project.getProjectId() + "/team/" + team.getTeamId() + "/chat";
        }
    }

}
