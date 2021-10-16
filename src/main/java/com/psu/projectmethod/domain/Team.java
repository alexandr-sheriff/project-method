package com.psu.projectmethod.domain;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.*;

@Entity
@Table
public class Team implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long teamId;

    @Size(min = 4, max = 20, message = "Введено некорректное название. Название должно быть длиной от 4 до 20 символов.")
    private String teamName;

    @OneToMany
    @JoinTable(name = "team_chat_messages",
            joinColumns = {@JoinColumn(name = "fk_team_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_chat_message_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<ChatMessage> teamChatMessages = new ArrayList<ChatMessage>();

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private Project teamProject;

    private Double teamRating;

    @NotEmpty(message = "Выберите хотя бы одного участника.")
    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(name = "team_users",
            joinColumns = {@JoinColumn(name = "fk_team_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_user_id")})
    private List<User> teamUsers = new ArrayList<User>();

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    private User teamCaptain;

    @OneToMany(
            mappedBy = "answerTeam",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Answer> teamAnswers = new ArrayList<Answer>();

    public Team() {
    }


    public Long getTeamId() {
        return teamId;
    }

    public void setTeamId(Long id) {
        this.teamId = id;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String name) {
        this.teamName = name;
    }

    public void setTeamRating(Double teamRating) {
        this.teamRating = teamRating;
    }

    public void setTeamRating() {
        if (this.teamProject.getProjectStatus().equals(Status._7_COMPLETED)) {
            Double size = Double.valueOf(this.getTeamAnswers().size());
            teamRating = Double.valueOf(0);
            for (Answer answer :
                    this.getTeamAnswers()) {
                if (answer.getAnswerRating() != null) {
                    teamRating += answer.getAnswerRating();
                }
            }
            teamRating /= size;
        }
    }

    public Double getTeamRating() {
        return teamRating;
    }

    public Project getTeamProject() {
        return teamProject;
    }

    public void setTeamProject(Project project) {
        this.teamProject = project;
    }

    public List<User> getTeamUsers() {
        return teamUsers;
    }

    public void setTeamUsers(List<User> users) {
        this.teamUsers = users;
    }

    public User getTeamCaptain() {
        return teamCaptain;
    }

    public void setTeamCaptain(User teamCapitan) {
        this.teamCaptain = teamCapitan;
    }

    public List<Answer> getTeamAnswers() {
        return teamAnswers;
    }

    public void setTeamAnswers(List<Answer> teamAnswers) {
        this.teamAnswers = teamAnswers;
    }

    public List<ChatMessage> getTeamChatMessages() {
        return teamChatMessages;
    }

    public void setTeamChatMessages(List<ChatMessage> teamChatMessages) {
        this.teamChatMessages = teamChatMessages;
    }

    public void addMessage(ChatMessage chatMessage) {
        teamChatMessages.add(chatMessage);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Team team = (Team) o;
        return Objects.equals(teamId, team.teamId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(teamId);
    }

    @Override
    public String toString() {
        return "Team{" +
                "teamId=" + teamId +
                ", teamName='" + teamName + '\'' +
                ", teamProject=" + teamProject +
                ", teamUsers=" + teamUsers +
                ", teamCaptain=" + teamCaptain +
                '}';
    }
}
