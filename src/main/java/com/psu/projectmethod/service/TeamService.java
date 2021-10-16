package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.ChatMessage;
import com.psu.projectmethod.domain.Team;
import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.repo.ChatMessageRepo;
import com.psu.projectmethod.repo.TeamRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.*;
import java.util.List;

@Service
public class TeamService {
    @Autowired
    private TeamRepo teamRepo;

    public Team findByTeamId(Long teamId) {
        return teamRepo.findByTeamId(teamId);
    }

    public List<Team> findAllByTeamProject(Project project) {
        return teamRepo.findAllByTeamProject(project);
    }

    /*public List<User> findAllByTeamId(Long teamId) {
        return teamRepo.findAllByTeamId(teamId);
    }*/

    public void saveTeam(Team team) {
        teamRepo.save(team);
    }

    public Long createProjectTeam(Project project, Team team) {
        team.setTeamRating(Double.valueOf(0));
        project.addTeam(team);
        teamRepo.save(team);
        return team.getTeamId();
    }

    public static void getPrevAndNextTeam(@PathVariable("projectId") Project project, @PathVariable("teamId") Team team, Model model) {
        Iterator<Team> teamIterator = project.getProjectTeams().iterator();

        Long nextTeam = null;
        Long previousTeam = null;
        Long currentTeam = team.getTeamId();

        while (teamIterator.hasNext()) {
            team = teamIterator.next();
            if (team.getTeamId() == currentTeam) {
                if (teamIterator.hasNext())
                    nextTeam = teamIterator.next().getTeamId();
                break;
            }
            previousTeam = team.getTeamId();
        }

        model.addAttribute("previousTeam", previousTeam);
        model.addAttribute("nextTeam", nextTeam);
    }

}
