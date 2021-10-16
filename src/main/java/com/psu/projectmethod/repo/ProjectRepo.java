package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ProjectRepo extends CrudRepository<Project, Long> {
    Project findByProjectId(Long projectId);

    Page<Project> findAll(Pageable pageable);

    List<Project> findAll();

    Page<Project> findByProjectLead(Pageable pageable, User user);

    List<Project> findByProjectLead(User user);

    @Query("select distinct p from Project p " +
            "join p.projectTeams teams " +
            "join teams.teamUsers teamsUsers " +
            "where teamsUsers = :user")
    Page<Project> findByStudent(Pageable pageable, @Param("user") User user);

    @Query("select distinct p from Project p " +
            "join p.projectTeams teams " +
            "join teams.teamUsers teamsUsers " +
            "where teamsUsers = :user")
    List<Project> findByStudent(@Param("user") User user);

    Page<Project> findByProjectNameContains(String projectName, Pageable pageable);

    Page<Project> findByProjectLeadAndProjectNameContains(User user, String projectName, Pageable pageable);

    @Query("select distinct p from Project p " +
            "join p.projectTeams teams " +
            "join teams.teamUsers teamsUsers " +
            "where teamsUsers = :user and p.projectName like :search")
    Page<Project> findByPStudentAndProjectNameContains(@Param("user") User user, @Param("search") String projectName, Pageable pageable);
}
