package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.Stage;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;
import java.util.List;
import java.util.List;

public interface StageRepo extends CrudRepository<Stage, Long> {
    List<Stage> findAllByStageProject(Project project);

    Stage findByStageId(Long stageId);
}
