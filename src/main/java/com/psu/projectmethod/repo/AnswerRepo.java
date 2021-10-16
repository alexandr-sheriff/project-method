package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.Answer;
import org.springframework.data.repository.CrudRepository;

public interface AnswerRepo extends CrudRepository<Answer, Long> {
    Answer findAnswerByAnswerStageStageIdAndAnswerTeamTeamId(Long stageId, Long teamId);
}
