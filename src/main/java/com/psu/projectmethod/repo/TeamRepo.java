package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.Team;
import com.psu.projectmethod.domain.Project;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TeamRepo extends CrudRepository<Team, Long> {
    Team findByTeamId(Long teamId);
    List<Team> findAllByTeamProject(Project project);
    //List<User> findAllByTeamId(Long teamId);
}
