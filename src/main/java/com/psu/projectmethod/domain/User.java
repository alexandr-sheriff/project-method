package com.psu.projectmethod.domain;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.URL;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PathVariable;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.*;

@Entity
@Table
public class User implements UserDetails, Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Size(min = 2, max = 16, message = "Введено некорректное имя. Имя должно быть длиной от 2 до 16 символов.")
    private String firstname;

    @Size(min = 2, max = 16, message = "Введена некорректная фамилия. Фамилия должна быть длиной от 2 до 16 символов.")
    private String lastname;

    private String fullname;

    private Double userRating;

    private String userImage;

    @Size(min = 4, max = 16, message = "Введен некорректный логин. Логин должен быть длиной от 4 до 16 символов.")
    private String username;

    @Email(message = "Введен некорректный email")
    @Size(min = 4, max = 32, message = "Введен некорректный логин. Email должен быть длиной от 4 до 32 символов.")
    private String email;

    @Size(max = 32, message = "Введено некорректное название учреждения образования. Название учреждения образования должно быть длиной до 32 символов.")
    private String userInstitution;

    @Size(max = 32, message = "Введено некорректное название должности. Название должности должно быть длиной до 32 символов.")
    private String userPosition;

    @URL(message = "Введена некорректная ссылка на сайт учреждения образования.")
    private String userInstitutionWebsite;

    @Size(max = 32, message = "Введено некорректное название города. Название города должно быть длиной до 32 символов.")
    private String userCity;

    @Size(max = 32, message = "Введено некорректное название страны. Название страны должно быть длиной до 32 символов.")
    private String userCountry;

    @Size(max = 500, message = "Введено некорректное описание. Описание должно быть до 50 символов.")
    private String userDescription;

    @URL(message = "Введена некорректная ссылка на профиль.")
    private String userFacebook;

    @URL(message = "Введена некорректная ссылка на профиль.")
    private String userVK;

    @URL(message = "Введена некорректная ссылка на профиль.")
    private String userTwitter;

    @URL(message = "Введена некорректная ссылка на профиль.")
    private String userLinkedIn;

    @URL(message = "Введена некорректная ссылка на профиль.")
    private String userTelegram;

    private String activationCode;

    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+=;:,./?\\|`~{}-])(?=\\S+$).{8,}$", message = "Введен некорректный пароль. Используйте для пароля длиной от 8 только буквы (a–z, A–Z), цифры и символы ! @ # $ % ^ & * ( ) - _ + = ; : , . / ? \\ | ` ~ { }")
    private String password;

    private boolean active;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private List<Role> roles;

    @OneToMany(
            mappedBy = "projectLead",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Project> userProjects = new ArrayList<Project>();

    @ManyToMany(mappedBy = "teamUsers")
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Team> userTeams = new ArrayList<Team>();

    @OneToMany(
            mappedBy = "teamCaptain",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Team> userTeamCaptains = new ArrayList<Team>();

    @OneToMany(
            mappedBy = "answerUser",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<Answer> userAnswers = new ArrayList<Answer>();

    @OneToMany(mappedBy = "chatMessageSender",
            cascade = CascadeType.ALL)
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<ChatMessage> chatMessages;

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "user_subscriptions",
            joinColumns = {@JoinColumn(name = "subscriber_id")},
            inverseJoinColumns = {@JoinColumn(name = "channel_id")}
    )
    private List<User> userSubscriptions = new ArrayList<User>();

    @ManyToMany
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinTable(
            name = "user_subscriptions",
            joinColumns = {@JoinColumn(name = "channel_id")},
            inverseJoinColumns = {@JoinColumn(name = "subscriber_id")}
    )
    private List<User> userSubscribers = new ArrayList<User>();

    public User() {
    }

    public boolean isAuthorized() {
        return active;
    }

    public boolean isAdmin() {
        return roles.contains(Role._1_ADMIN);
    }

    public boolean isTeacher() {
        return roles.contains(Role._2_TEACHER);
    }

    public boolean isStudent() {
        return roles.contains(Role._3_STUDENT);
    }

/*    public boolean isTeamCaptain(@AuthenticationPrincipal User user, @PathVariable("teamId") Team team) {
        if (user == team.getTeamCaptain())
            return true;
        else return false;
    }*/

    public Double getUserRating() {
        return userRating;
    }

    public void setUserRating(Double userRating) {
        this.userRating = userRating;
    }

    public void setUserRating() {
        Double size = Double.valueOf(0);
        userRating = Double.valueOf(0);
        if (this.isTeacher()) {
            for (Project project :
                    this.getUserProjects()) {
                if (project.getProjectStatus().equals(Status._7_COMPLETED)) {
                    size++;
                }
                if (project.getProjectRating() != null) {
                    userRating += project.getProjectRating();
                }
            }
            userRating /= size;
        } else if (this.isStudent()) {
            for (Team team :
                    this.getUserTeams()) {
                if (team.getTeamProject().getProjectStatus().equals(Status._7_COMPLETED)) {
                    size++;
                }
                if (team.getTeamRating() != null) {
                    userRating += team.getTeamRating();
                }
            }
            userRating /= size;
        }
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long id) {
        this.userId = id;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getUsername() {
        return username;
    }

    public String getFullname() {
        return lastname + " " + firstname;
    }

    public void setFullname() {
        this.fullname = lastname + " " + firstname;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getUserInstitution() {
        return userInstitution;
    }

    public void setUserInstitution(String userInstitution) {
        this.userInstitution = userInstitution;
    }

    public String getUserPosition() {
        return userPosition;
    }

    public void setUserPosition(String userPosition) {
        this.userPosition = userPosition;
    }

    public String getUserInstitutionWebsite() {
        return userInstitutionWebsite;
    }

    public void setUserInstitutionWebsite(String userInstitutionWebsite) {
        this.userInstitutionWebsite = userInstitutionWebsite;
    }

    public String getUserCity() {
        return userCity;
    }

    public void setUserCity(String userCity) {
        this.userCity = userCity;
    }

    public String getUserCountry() {
        return userCountry;
    }

    public void setUserCountry(String userCountry) {
        this.userCountry = userCountry;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserFacebook() {
        return userFacebook;
    }

    public void setUserFacebook(String userFacebook) {
        this.userFacebook = userFacebook;
    }

    public String getUserVK() {
        return userVK;
    }

    public void setUserVK(String userVK) {
        this.userVK = userVK;
    }

    public String getUserTwitter() {
        return userTwitter;
    }

    public void setUserTwitter(String userTwitter) {
        this.userTwitter = userTwitter;
    }

    public String getUserLinkedIn() {
        return userLinkedIn;
    }

    public void setUserLinkedIn(String userLinkeIn) {
        this.userLinkedIn = userLinkeIn;
    }

    public String getUserTelegram() {
        return userTelegram;
    }

    public void setUserTelegram(String userTelegram) {
        this.userTelegram = userTelegram;
    }

    public String getUserDescription() {
        return userDescription;
    }

    public void setUserDescription(String userDescription) {
        this.userDescription = userDescription;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public List<Project> getUserProjects() {
        return userProjects;
    }

    public void setUserProjects(List<Project> userProjects) {
        this.userProjects = userProjects;
    }

    public List<Team> getUserTeams() {
        return userTeams;
    }

    public void setUserTeams(List<Team> userTeams) {
        this.userTeams = userTeams;
    }

    public List<Team> getUserTeamCaptains() {
        return userTeamCaptains;
    }

    public void setUserTeamCaptains(List<Team> userCaptains) {
        this.userTeamCaptains = userCaptains;
    }

    public List<Answer> getUserAnswers() {
        return userAnswers;
    }

    public void setUserAnswers(List<Answer> userAnswers) {
        this.userAnswers = userAnswers;
    }

    public List<ChatMessage> getChatMessages() {
        return chatMessages;
    }

    public void setChatMessages(List<ChatMessage> chatMessages) {
        this.chatMessages = chatMessages;
    }

    public List<User> getUserSubscriptions() {
        return userSubscriptions;
    }

    public void setUserSubscriptions(List<User> subscriptions) {
        this.userSubscriptions = subscriptions;
    }

    public List<User> getUserSubscribers() {
        return userSubscribers;
    }

    public void setUserSubscribers(List<User> subscribers) {
        this.userSubscribers = subscribers;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(userId, user.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId);
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", fullname='" + fullname + '\'' +
                ", roles=" + roles +
                '}';
    }
}
