package com.psu.projectmethod.service;

import com.psu.projectmethod.controller.ControllerUtils;
import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

/*
    public User findByUserId(Long userId) {
        return userRepo.findByUserId(userId);
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }
*/

    public List<User> findByRolesEquals(Sort sort, Role role) {
        return userRepo.findByRolesEquals(sort, role);
    }

/*
    public List<User> findAllByRolesEqualsAndNotAddedToProject(Sort sort, Role role, Long projectId) {
        return userRepo.findAllByRolesEqualsAndNotAddedToProject(sort, role, projectId);
    }

    public List<User> findUsersByUserIdIn(List<Long> usersIds) {
        return userRepo.findUsersByUserIdIn(usersIds);
    }
*/

    public List<User> userList() {
            return userRepo.findAll();
    }

/*
    public Page<User> userPage(Integer pageNo, Integer pageSize, String sortBy, String directionBy, String search) {
        Pageable paging;
        if (directionBy.equals("DESC")) {
            paging = PageRequest.of(pageNo, pageSize, Sort.by(sortBy).descending());
        } else {
            paging = PageRequest.of(pageNo, pageSize, Sort.by(sortBy).ascending());
        }
        if (search != null && !search.isEmpty()) {
            return userRepo.findByFullnameContains(search, paging);
        } else {
            return userRepo.findAll(paging);
        }
    }
*/

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("Пользователь не найден");
        }
        return user;
    }

    public void encodePassword(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
    }

    public boolean isCurrentPassword(String currentUserPassword, String password) {
        return passwordEncoder.matches(currentUserPassword, password);
    }

    public void addUser(User user) {
        user.setUserRating(Double.valueOf(0));
        user.setFullname();
        user.setActive(false);
        user.setRoles(Collections.singletonList(Role._3_STUDENT));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        sendActivationMessage(user);
    }

    public boolean isUserByUsernameExist(User user) {
        User userRepoByUsername = userRepo.findByUsername(user.getUsername());
        if (userRepoByUsername != null) {
            return true;
        }
        return false;
    }

    public boolean isUserByUsernameExistAndNotCurrent(User user) {
        User userRepoByUsername = userRepo.findByUsername(user.getUsername());
        if (userRepoByUsername != null && !userRepoByUsername.equals(user)) {
            return true;
        }
        return false;
    }

    public boolean isUserByEmailExist(User user) {
        User userRepoByEmail = userRepo.findByEmail(user.getEmail());
        if (userRepoByEmail != null) {
            return true;
        }
        return false;
    }

    public boolean isUserByEmailExistAndNotCurrent(User user) {
        User userRepoByEmail = userRepo.findByEmail(user.getEmail());
        if (userRepoByEmail != null && !userRepoByEmail.equals(user)) {
            return true;
        }
        return false;
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActive(true);
        user.setActivationCode(null);
        userRepo.save(user);
        sendActivationConfirmationMessage(user);
        return true;
    }

    public void sendAccountSettingsConfirmationMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Это сообщение было отправлено вам, поскольку вы, или кто-то другой, изменили настройки учетной записи на сайте PSU.BY/PROJECT-METHOD для вашего email адреса.\n" +
                            "\n" +
                            "Для подтверждения вашей учетной записи, пройдите, пожалуйста, по ссылке:\n" +
                            "http://localhost:8088/activate/%s\n" +
                            "\n" +
                            "Если вы не можете нажать на ссылку, просто скопируйте ее и вставьте в адресную строку вашего браузера.\n" +
                            "\n" +
                            "Если вы уверены, что данное сообщение пришло к вам по ошибке, вам не нужно предпринимать никаких действий, просто проигнорируйте его.\n" +
                            "\n" +
                            "С уваженем,\n" +
                            "ProjectMethod.psu.by\n",
                    user.getFirstname() + " " + user.getLastname(),
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(), "Активация аккаунта PSU.BY/PROJECT-METHOD", message);
        }
    }

    private void sendActivationMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Это сообщение было отправлено вам, поскольку вы, или кто-то другой, зарегистрировались на сайте psu.by/project-method под вашим email адресом.\n" +
                            "\n" +
                            "Для подтверждения вашей учетной записи, пройдите, пожалуйста, по ссылке:\n" +
                            "http://localhost:8088/activate/%s\n" +
                            "\n" +
                            "Если вы не можете нажать на ссылку, просто скопируйте ее и вставьте в адресную строку вашего браузера.\n" +
                            "\n" +
                            "Если вы уверены, что данное сообщение пришло к вам по ошибке, вам не нужно предпринимать никаких действий, просто проигнорируйте его.\n" +
                            "\n" +
                            "С уваженем,\n" +
                            "ProjectMethod.psu.by\n",
                    user.getFirstname() + " " + user.getLastname(),
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(), "Активация аккаунта PSU.BY/PROJECT-METHOD", message);
        }
    }

    private void sendActivationConfirmationMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Вы успешно завершили регистрацию на сайте PSU.BY/PROJECT-METHOD.\n" +
                            "\n" +
                            "Для входа на сайт используйте, пожалуйста, следующий данные:\n" +
                            "логин: %s\n" +
                            "пароль: указанный вами в процессе регистрации\n" +
                            "\n" +
                            "Вы можете изменить информацию о себе в личном кабинете: http://localhost:8088/user/profile/%s\n" +
                            "\n" +
                            "С уваженем,\n" +
                            "ProjectMethod.psu.by\n",
                    user.getFirstname() + " " + user.getLastname(),
                    user.getUsername(),
                    user.getUserId()
            );
            mailSender.send(user.getEmail(), "PSU.BY/PROJECT-METHOD - завершение регистрации", message);
        }
    }

    public void saveUser(User user) {
        userRepo.save(user);
    }

    public void save(User user) {
        userRepo.save(user);
    }

    public void subscribe(User currentUser, User user) {
        user.getUserSubscribers().add(currentUser);
        userRepo.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getUserSubscribers().remove(currentUser);
        userRepo.save(user);
    }

}
