package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.*;
import com.psu.projectmethod.service.ProjectService;
import com.psu.projectmethod.service.TeamService;
import com.psu.projectmethod.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/projects")
public class TeamController {

    @Autowired
    private TeamService teamService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProjectService projectService;

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/team/{teamId}")
    public String viewProjectTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("teamId") Team team,
            Model model) {
        List<User> findAllByRolesEquals = userService.findByRolesEquals(Sort.by("username"), Role._3_STUDENT);
        List<ChatMessage> teamMessages = team.getTeamChatMessages();
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamUsers().contains(currentUser))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        model.addAttribute("team", team);
        model.addAttribute("users", findAllByRolesEquals);
        model.addAttribute("teamMessages", teamMessages);
        TeamService.getPrevAndNextTeam(project, team, model);
        return "team";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @GetMapping("/project/{projectId}/team/create")
    public String viewCreateProjectTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @ModelAttribute("team") Team team,
            Model model) {
        List<User> studentsDontAddedInProject = projectService.studentsDontAddedInProject(project);
        if (!project.getProjectLead().equals(currentUser) && !project.getProjectStatus().equals(Status._1_BACKLOG))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        model.addAttribute("users", studentsDontAddedInProject);
        return "teacherProjectTeamCreate";
    }

    @PreAuthorize("hasAuthority('_2_TEACHER')")
    @PostMapping("/project/{projectId}/team/create")
    public String processCreateProjectTeam(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @ModelAttribute @Valid Team team,
            BindingResult bindingResult,
            Model model) {
        List<User> studentsDontAddedInProject = projectService.studentsDontAddedInProject(project);
        if (!project.getProjectLead().equals(currentUser) && !project.getProjectStatus().equals(Status._1_BACKLOG))
            return "redirect:/projects/project/" + project.getProjectId();
        model.addAttribute("project", project);
        model.addAttribute("users", studentsDontAddedInProject);
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "teacherProjectTeamCreate";
        } else {
            Long teamId = teamService.createProjectTeam(project, team);
            return "redirect:/projects/project/" + project.getProjectId() + "/team/" + teamId;
        }
    }

    @PreAuthorize("hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    @GetMapping("/project/{projectId}/team/{teamId}/assign/captain/{captainId}")
    public String processAssignTeamCaptain(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("projectId") Project project,
            @PathVariable("teamId") Team team,
            @PathVariable("captainId") User captain,
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer) {
        if (!project.getProjectLead().equals(currentUser) && !team.getTeamCaptain().equals(currentUser))
            return "redirect:/projects/project/" + project.getProjectId();
        if (team.getTeamUsers().contains(captain)) {
            if (team.getTeamCaptain() == null && project.getProjectLead().equals(currentUser)) {
                team.setTeamCaptain(captain);
                teamService.saveTeam(team);
            } else if (team.getTeamCaptain() != null && !team.getTeamCaptain().equals(captain)
                    && (project.getProjectLead().equals(currentUser) || team.getTeamCaptain().equals(currentUser))) {
                team.setTeamCaptain(captain);
                teamService.saveTeam(team);
            }
        } else {
            return "redirect:/projects";
        }
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();
        components.getQueryParams().
                entrySet().
                forEach(pair -> redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));
        return "redirect:" + components.getPath();
    }

}
