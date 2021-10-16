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
public class Project implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long projectId;

    public Boolean getProjectStarted() {
        return projectStarted;
    }

    public void setProjectStarted(Boolean projectStarted) {
        this.projectStarted = projectStarted;
    }

    public Boolean getProjectFinished() {
        return projectFinished;
    }

    public void setProjectFinished(Boolean projectFinished) {
        this.projectFinished = projectFinished;
    }

    private Boolean projectStarted;

    private Boolean projectFinished;

    @Size(min = 4, max = 20, message = "Введено некорректное название. Название должно быть длиной от 4 до 20 символов.")
    private String projectName;

    @Size(min = 20, max = 200, message = "Введены некорректное описаниие. Описание должно быть длиной от 20 до 200 символов.")
    private String projectDescription;

    @Size(min = 20, max = 500, message = "Введены некорректные цели. Цели должны быть длиной от 20 до 500 символов.")
    private String projectGoals;

    @Size(min = 20, max = 500, message = "Введены некорректные задачи. Задачи должны быть длиной от 20 до 500 символов.")
    private String projectTasks;

    /*@NotBlank(message = "Не выбрано изображение проекта.")*/
    private String projectImage;

    @OneToMany
    @JoinTable(name = "project_files",
            joinColumns = {@JoinColumn(name = "fk_project_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_file_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<File> projectFiles = new ArrayList<File>();

    private LocalDateTime projectCreatedTime;

    private LocalDateTime projectTheoreticalLeadTime;

    private LocalDateTime projectStartTime;

    private LocalDateTime projectEndTime;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private User projectLead;

    @Enumerated(EnumType.STRING)
    private Status projectStatus;

    private Double projectRating;

    @OneToMany(
            mappedBy = "stageProject",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Stage> projectStages = new ArrayList<Stage>();

    @OneToMany(
            mappedBy = "teamProject",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Team> projectTeams = new ArrayList<Team>();

    @OneToMany
    @JoinTable(name = "project_chat_messages",
            joinColumns = {@JoinColumn(name = "fk_project_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_chat_message_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<ChatMessage> projectChatMessages = new ArrayList<ChatMessage>();

    public Project() {
    }

    public Double getProjectRating() {
        return projectRating;
    }

    public void setProjectRating(Double projectRating) {
        this.projectRating = projectRating;
    }

    public void setProjectRating() {
        if (projectStatus.equals(Status._7_COMPLETED)) {
            Double size = Double.valueOf(this.getProjectTeams().size());
            projectRating = Double.valueOf(0);
            for (Team team :
                    this.getProjectTeams()) {
                if (team.getTeamRating() != null) {
                    projectRating += team.getTeamRating();
                }
            }
            projectRating /= size;
        }
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long id) {
        this.projectId = id;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String name) {
        this.projectName = name;
    }

    public String getProjectDescription() {
        return projectDescription;
    }

    public void setProjectDescription(String projectDescription) {
        this.projectDescription = projectDescription;
    }

    public String getProjectGoals() {
        return projectGoals;
    }

    public void setProjectGoals(String goal) {
        this.projectGoals = goal;
    }

    public String getProjectTasks() {
        return projectTasks;
    }

    public void setProjectTasks(String task) {
        this.projectTasks = task;
    }

    public Status getProjectStatus() {
        return projectStatus;
    }

    public void setProjectStatus(Status status) {
        this.projectStatus = status;
    }

    public String getProjectImage() {
        return projectImage;
    }

    public void setProjectImage(String projectImage) {
        this.projectImage = projectImage;
    }

    public List<File> getProjectFiles() {
        return projectFiles;
    }

    public void setProjectFiles(List<File> projectFiles) {
        this.projectFiles = projectFiles;
    }

    public LocalDateTime getProjectCreatedTime() {
        return projectCreatedTime;
    }

    public void setProjectCreatedTime(LocalDateTime projectCreatedTime) {
        this.projectCreatedTime = projectCreatedTime;
    }

    public LocalDateTime getProjectTheoreticalLeadTime() {
        return projectTheoreticalLeadTime;
    }

    public void setProjectTheoreticalLeadTime(LocalDateTime theoreticalLeadTime) {
        this.projectTheoreticalLeadTime = theoreticalLeadTime;
    }

    public LocalDateTime getProjectStartTime() {
        return projectStartTime;
    }

    public void setProjectStartTime(LocalDateTime projectStartTime) {
        this.projectStartTime = projectStartTime;
    }

    public LocalDateTime getProjectEndTime() {
        return projectEndTime;
    }

    public void setProjectEndTime(LocalDateTime actualLeadTime) {
        this.projectEndTime = actualLeadTime;
    }

    public User getProjectLead() {
        return projectLead;
    }

    public void setProjectLead(User projectUser) {
        this.projectLead = projectUser;
    }

    public List<Stage> getProjectStages() {
        return projectStages;
    }

    public void setProjectStages(List<Stage> stages) {
        this.projectStages = stages;
    }

    public List<Team> getProjectTeams() {
        return projectTeams;
    }

    public void setProjectTeams(List<Team> projectTeams) {
        this.projectTeams = projectTeams;
    }

    public List<ChatMessage> getProjectChatMessages() {
        return projectChatMessages;
    }

    public void setProjectChatMessages(List<ChatMessage> projectChatMessages) {
        this.projectChatMessages = projectChatMessages;
    }

    public void addProjectLead(User user) {
        this.setProjectLead(user);
        user.getUserProjects().add(this);
    }

    public void removeProjectLead(User user) {
        this.setProjectLead(null);
        user.getUserProjects().remove(this);
    }

    public void addStage(Stage stage) {
        projectStages.add(stage);
        stage.setStageProject(this);
    }

    public void removeStage(Stage stage) {
        projectStages.remove(stage);
        stage.setStageProject(null);
    }

    public void addTeam(Team team) {
        projectTeams.add(team);
        team.setTeamProject(this);
    }

    public void removeTeam(Team team) {
        projectTeams.remove(team);
        team.setTeamProject(null);
    }

    public void addFile(File file) {
        projectFiles.add(file);
    }

    public void addMessage(ChatMessage chatMessage) {
        projectChatMessages.add(chatMessage);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Project project = (Project) o;
        return Objects.equals(projectId, project.projectId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(projectId);
    }

    @Override
    public String toString() {
        return "Project{" +
                "projectId=" + projectId +
                ", projectName='" + projectName + '\'' +
                ", projectStatus=" + projectStatus +
                '}';
    }
}
