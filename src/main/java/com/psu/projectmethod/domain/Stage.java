package com.psu.projectmethod.domain;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import javax.validation.constraints.Future;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table
public class Stage implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long stageId;

    @Size(min = 4, max = 20, message = "Введено некорректное название. Название должно быть длиной от 4 до 20 символов.")
    private String stageName;

    @Size(min = 20, max = 500, message = "Введено некорректное описание. Описание должно быть длиной от 20 до 500 символов.")
    private String stageDescription;

    private Double stageRating;

    private String stageImage;

    @OneToMany
    @JoinTable(name = "stage_files",
            joinColumns = {@JoinColumn(name = "fk_stage_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_file_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<File> stageFiles = new ArrayList<File>();

    private LocalDateTime stageTheoreticalLeadTime;

    private LocalDateTime stageStartTime;

    private LocalDateTime stageEndTime;

    @Enumerated(EnumType.STRING)
    private Status stageStatus;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Project stageProject;

    @OneToMany(
            mappedBy = "answerStage",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Answer> stageAnswers = new ArrayList<Answer>();

    public Stage() {
    }

    public Long getStageId() {
        return stageId;
    }

    public void setStageId(Long id) {
        this.stageId = id;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String name) {
        this.stageName = name;
    }

    public String getStageDescription() {
        return stageDescription;
    }

    public void setStageDescription(String stageDescription) {
        this.stageDescription = stageDescription;
    }

    public String getStageImage() {
        return stageImage;
    }

    public void setStageImage(String stageImage) {
        this.stageImage = stageImage;
    }

    public void setStageRating(Double stageRating) {
        this.stageRating = stageRating;
    }

    public void setStageRating() {
        if (this.stageProject.getProjectStatus().equals(Status._7_COMPLETED)) {
            Double size = Double.valueOf(this.getStageAnswers().size());
            stageRating = Double.valueOf(0);
            for (Answer answer :
                    this.getStageAnswers()) {
                if (answer.getAnswerRating() != null) {
                    stageRating += answer.getAnswerRating();
                }
            }
            stageRating /= size;
        }
    }

    public Double getStageRating() {
        return stageRating;
    }

    public List<File> getStageFiles() {
        return stageFiles;
    }

    public void setStageFiles(List<File> stageFiles) {
        this.stageFiles = stageFiles;
    }

    public LocalDateTime getStageTheoreticalLeadTime() {
        return stageTheoreticalLeadTime;
    }

    public void setStageTheoreticalLeadTime(LocalDateTime stageTheoreticalLeadTime) {
        this.stageTheoreticalLeadTime = stageTheoreticalLeadTime;
    }

    public LocalDateTime getStageStartTime() {
        return stageStartTime;
    }

    public void setStageStartTime(LocalDateTime stageStartTime) {
        this.stageStartTime = stageStartTime;
    }

    public LocalDateTime getStageEndTime() {
        return stageEndTime;
    }

    public void setStageEndTime(LocalDateTime stageEndTime) {
        this.stageEndTime = stageEndTime;
    }

    public Status getStageStatus() {
        return stageStatus;
    }

    public void setStageStatus(Status stageStatus) {
        this.stageStatus = stageStatus;
    }

    public Project getStageProject() {
        return stageProject;
    }

    public void setStageProject(Project project) {
        this.stageProject = project;
    }

    public List<Answer> getStageAnswers() {
        return stageAnswers;
    }

    public void setStageAnswers(List<Answer> stageAnswers) {
        this.stageAnswers = stageAnswers;
    }

    public void addFile(File file) {
        stageFiles.add(file);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Stage stage = (Stage) o;
        return Objects.equals(stageId, stage.stageId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stageId);
    }

    @Override
    public String toString() {
        return "Stage{" +
                "stageId=" + stageId +
                ", stageName='" + stageName + '\'' +
                ", stageStatus=" + stageStatus +
                ", stageProject=" + stageProject +
                '}';
    }
}
