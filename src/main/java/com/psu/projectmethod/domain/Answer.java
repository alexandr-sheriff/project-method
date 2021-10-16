package com.psu.projectmethod.domain;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table
public class Answer implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long answerId;

    @Size(min = 20, max = 2000, message = "Введен некорректный ответ. Ответ должен быть длиной от 20 до 2000 символов.")
    private String answerText;

    @OneToMany
    @JoinTable(name = "answer_files",
            joinColumns = {@JoinColumn(name = "fk_answer_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_file_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<File> answerFiles = new ArrayList<File>();

    @Size(min = 20, max = 2000, message = "Введено некорректный комментарий. Комментарий должен быть длиной от 20 до 500 символов.")
    private String answerAssessment;

    @Min(value = 0, message = "Введена некорректна оценка. Оценка должна быть от 0.")
    @Max(value = 10, message = "Введена некорректна оценка. Оценка должна быть до 10.")
    private Double answerRating;

    @Enumerated(EnumType.STRING)
    private Status answerStatus;

    private LocalDateTime answerResponseTime;

    private LocalDateTime answerAssessmentTime;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Stage answerStage;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Team answerTeam;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private User answerUser;

    public Answer() {
    }

    public Long getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Long answerId) {
        this.answerId = answerId;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public List<File> getAnswerFiles() {
        return answerFiles;
    }

    public void setAnswerFiles(List<File> answerFiles) {
        this.answerFiles = answerFiles;
    }

    public String getAnswerAssessment() {
        return answerAssessment;
    }

    public void setAnswerAssessment(String answerAssessment) {
        this.answerAssessment = answerAssessment;
    }

    public Double getAnswerRating() {
        return answerRating;
    }

    public void setAnswerRating(Double rating) {
        this.answerRating = rating;
    }

    public Status getAnswerStatus() {
        return answerStatus;
    }

    public void setAnswerStatus(Status answerStatus) {
        this.answerStatus = answerStatus;
    }

    public LocalDateTime getAnswerResponseTime() {
        return answerResponseTime;
    }

    public void setAnswerResponseTime(LocalDateTime answerResponseTime) {
        this.answerResponseTime = answerResponseTime;
    }

    public LocalDateTime getAnswerAssessmentTime() {
        return answerAssessmentTime;
    }

    public void setAnswerAssessmentTime(LocalDateTime answerAssessmentTime) {
        this.answerAssessmentTime = answerAssessmentTime;
    }

    public Stage getAnswerStage() {
        return answerStage;
    }

    public void setAnswerStage(Stage stageAnswer) {
        this.answerStage = stageAnswer;
    }

    public Team getAnswerTeam() {
        return answerTeam;
    }

    public void setAnswerTeam(Team teamAnswer) {
        this.answerTeam = teamAnswer;
    }

    public User getAnswerUser() {
        return answerUser;
    }

    public void setAnswerUser(User userAnswer) {
        this.answerUser = userAnswer;
    }

    public void addStageAndTeamAndCaptain(Stage stage, Team team, User user) {
        this.setAnswerStage(stage);
        stage.getStageAnswers().add(this);

        this.setAnswerTeam(team);
        team.getTeamAnswers().add(this);

        this.setAnswerUser(user);
        user.getUserAnswers().add(this);
    }

    public void removeStageAndTeamAndCaptain(Stage stage, Team team, User user) {
        this.setAnswerStage(null);
        stage.getStageAnswers().remove(this);

        this.setAnswerTeam(null);
        team.getTeamAnswers().remove(this);

        this.setAnswerUser(null);
        user.getUserAnswers().remove(this);
    }

    public void addFile(File file) {
        answerFiles.add(file);
    }

    public void removeFile(File file) {
        answerFiles.remove(file);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Answer answer = (Answer) o;
        return Objects.equals(answerId, answer.answerId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(answerId);
    }

    @Override
    public String toString() {
        return "Answer{" +
                "answerId=" + answerId +
                ", answerStatus=" + answerStatus +
                ", answerStage=" + answerStage +
                ", answerTeam=" + answerTeam +
                ", answerUser=" + answerUser +
                '}';
    }
}
