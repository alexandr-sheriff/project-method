package com.psu.projectmethod.service;

import com.psu.projectmethod.controller.ControllerUtils;
import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class AdminService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void createUser(User user) {
        user.setFullname();
        user.setActive(false);
        user.setUserRating(Double.valueOf(0));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        sendActivationMessage(user);
    }

    public void updateUser(User user, String firstname, String lastname, String username, String email) {
        String userFirstname = user.getFirstname();
        String userLastname = user.getLastname();
        String userUsername = user.getUsername();
        String userEmail = user.getEmail();

        boolean isFirstnameChanged = isChanged(firstname, userFirstname);
        if (isFirstnameChanged) {
            user.setUsername(username);
        }

        boolean isLastnameChanged = isChanged(lastname, userLastname);
        if (isLastnameChanged) {
            user.setUsername(username);
        }

        boolean isUsernameChanged = isChanged(username, userUsername);
        if (isUsernameChanged) {
            user.setUsername(username);
        }

        boolean isEmailChanged = isChanged(email, userEmail);
        if (isEmailChanged) {
            user.setActive(false);
            user.setEmail((email));
            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
            sendActivationMessage(user);
        }

        user.setFullname();

        userRepo.save(user);
    }

    public void activateUser(User user) {
        if (user.isActive()) {
            user.setActive(false);
            sendDisactiveMessage(user);
        } else {
            user.setActive(true);
            sendActiveMessage(user);
        }
        userRepo.save(user);
    }

    private boolean isChanged(String firstString, String secondString) {
        return (firstString != null && !firstString.equals(secondString)) || (secondString != null && !secondString.equals(firstString));
    }

    private void sendActivationMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Это сообщение было отправлено вам, поскольку администратор зарегистрировал вас на сайте ProjectMethod.psu.by под вашим email адресом.\n" +
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
            mailSender.send(user.getEmail(), "ProjectMethod.psu.by - подтверждение регистрации", message);
        }
    }

    private void sendActiveMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Это сообщение было отправлено вам, поскольку администратор активировал учетную запить под вашим email адресом на сайте ProjectMethod.psu.by.\n" +
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
            mailSender.send(user.getEmail(), "ProjectMethod.psu.by - активация учетной записи", message);
        }
    }

    private void sendDisactiveMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Здравствуйте, %s!\n" +
                            "\n" +
                            "Это сообщение было отправлено вам, поскольку администратор дезактивировал учетную запить под вашим email адресом на сайте ProjectMethod.psu.by.\n" +
                            "\n" +
                            "Если вы уверены, что администратор дезактивировал вашу учетную запись по ошибке, обратитесь к администратору сайта с описанием вашей проблемы на адрес электронной почты post@psu.by.\n" +
                            "\n" +
                            "С уваженем,\n" +
                            "ProjectMethod.psu.by\n",
                    user.getFirstname() + " " + user.getLastname()
            );
            mailSender.send(user.getEmail(), "ProjectMethod.psu.by - дезактивация учетной записи", message);
        }
    }
}
