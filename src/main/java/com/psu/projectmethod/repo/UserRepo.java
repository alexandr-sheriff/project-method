package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.Team;
import com.psu.projectmethod.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.List;
import java.util.List;

public interface UserRepo extends CrudRepository<User, Long> {
    User findByUserId(Long userId);

    User findByUsername(String username);

    User findByEmail(String email);

    User findByActivationCode(String code);

    List<User> findAll();

    @Query("select distinct u from User u " +
            "join u.roles uRoles " +
            "left join u.userTeams uTeams " +
            "where uRoles = :role and " +
            "(u.userTeams is empty or uTeams.teamProject.projectId <> :projectId)")
    List<User> findAllByRolesEqualsAndNotAddedToProject(Sort sort, @Param("role") Role role, @Param("projectId") Long project);

    List<User> findByRolesEquals(Role role);

    List<User> findByRolesEquals(Sort sort, Role role);

    List<User> findUsersByUserIdIn(List<Long> usersIds);

    Page<User> findAll(Pageable pageable);

    Page<User> findByFullnameContains(String fullname, Pageable pageable);
}
