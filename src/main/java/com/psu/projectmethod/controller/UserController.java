package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/profile/{userId}")
    public String getProfile(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        model.addAttribute("user", user);
        model.addAttribute("isSubscriber", user.getUserSubscribers().contains(currentUser));
        return "profile";
    }

    @GetMapping("/profile/{userId}/settings")
    public String settingsProfile(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        return "profileSettings";
    }

    /*@GetMapping("/profile/{userId}/settings/publicInfo/save")
    public String settingsProfilePublicInfo(
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer,
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        String components = checkCurrentUser(redirectAttributes, referer, currentUser, user);
        if (components != null) return components;
        model.addAttribute("user", user);
        return "profileSettings";
    }*/

    @PutMapping("/profile/{userId}/settings/publicInfo/save")
    public String settingsProfilePublicInfo(
            @AuthenticationPrincipal User currentUser,
            @ModelAttribute("userId") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "profileSettings";
        } else {
            userService.saveUser(user);
            return "redirect:/user/profile/" + user.getUserId();
        }
    }

    /*@GetMapping("/profile/{userId}/settings/profilePhoto/save")
    public String setPhotoProfile(
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer,
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        String components = checkCurrentUser(redirectAttributes, referer, currentUser, user);
        if (components != null) return components;
        model.addAttribute("user", user);
        return "profileSettings";
    }*/

    @PostMapping("/profile/{userId}/settings/profilePhoto/save")
    public String processSetPhotoProfile(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("file") MultipartFile file,
            @PathVariable("userId") User user,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        try {
            uploadFile(user, file);
            userService.save(user);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/user/profile/" + user.getUserId();
    }

    @GetMapping("/profile/{userId}/settings/profilePhoto/delete")
    public String processDeletePhotoProfile(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        deleteFile(user);
        userService.save(user);
        return "redirect:/user/profile/" + user.getUserId();
    }

    /*@GetMapping("/profile/{userId}/settings/accountSettings/save")
    public String settingsProfileAccountSettings(
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer,
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        String components = checkCurrentUser(redirectAttributes, referer, currentUser, user);
        if (components != null) return components;
        model.addAttribute("user", user);
        return "profileSettings";
    }*/

    @PutMapping("/profile/{userId}/settings/accountSettings/save")
    public String settingsProfileAccountSettings(
            @AuthenticationPrincipal User currentUser,
            @ModelAttribute("userId") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        boolean isUserByUsernameExistAndNotCurrent = userService.isUserByUsernameExistAndNotCurrent(user);
        if (isUserByUsernameExistAndNotCurrent) {
            model.addAttribute("usernameError", "Пользователь с таким логином уже существует");
        }
        boolean isUserByEmailExistAndNotCurrent = userService.isUserByEmailExistAndNotCurrent(user);
        if (isUserByEmailExistAndNotCurrent) {
            model.addAttribute("emailError", "Пользователь с таким email уже существует");
        }
        if (isUserByUsernameExistAndNotCurrent || isUserByEmailExistAndNotCurrent || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "profileSettings";
        } else {
            user.setActive(false);
            user.setActivationCode(UUID.randomUUID().toString());
            userService.sendAccountSettingsConfirmationMessage(user);
            userService.saveUser(user);
            return "redirect:/user/profile/" + user.getUserId();
        }
    }

    /*@GetMapping("/profile/{userId}/settings/passwordChange/save")
    public String settingsProfilePasswordChange(
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer,
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        String components = checkCurrentUser(redirectAttributes, referer, currentUser, user);
        if (components != null) return components;
        model.addAttribute("user", user);
        return "profileSettings";
    }*/

    @PutMapping("/profile/{userId}/settings/passwordChange/save")
    public String settingsProfilePasswordChange(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(value = "passwordCurrent") String passwordCurrent,
            @RequestParam(value = "passwordConfirm") String passwordConfirm,
            @ModelAttribute("userId") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.equals(user))
            return "redirect:/projects";
        model.addAttribute("user", user);
        boolean isCurrentWrong = user.getPassword() != null && userService.isCurrentPassword(user.getPassword(), passwordCurrent);
        if (isCurrentWrong) {
            model.addAttribute("passwordCurrentError", "Текущий пароль неверный");
        }
        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);
        if (isConfirmEmpty) {
            model.addAttribute("passwordConfirmError", "Необходимо ввести пароль еще раз");
        }
        boolean isDifferentPasswords = user.getPassword() != null && !user.getPassword().equals(passwordConfirm);
        if (isDifferentPasswords) {
            model.addAttribute("passwordConfirmError", "Подтверждение не совпадает с паролем");
        }
        if (isCurrentWrong || isConfirmEmpty || isDifferentPasswords || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "profileSettings";
        } else {
            userService.encodePassword(user);
            userService.saveUser(user);
            return "redirect:/user/profile/" + user.getUserId();
        }
    }

    @GetMapping("/profile/{userId}/subscribe")
    public String subscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user
    ) {
        userService.subscribe(currentUser, user);
        return "redirect:/user/profile/" + user.getUserId();
    }

    @GetMapping("/profile/{userId}/unsubscribe")
    public String unsubscribe(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user
    ) {
        userService.unsubscribe(currentUser, user);
        return "redirect:/user/profile/" + user.getUserId();
    }

    @GetMapping("/profile/{userId}/subscribers")
    public String subscriberList(
            @PathVariable("userId") User user,
            @PathVariable String type,
            Model model
    ) {
        model.addAttribute("userChannel", user);
        model.addAttribute("type", type);
        if ("subscriptions".equals(type)) {
            model.addAttribute("users", user.getUserSubscriptions());
        } else {
            model.addAttribute("users", user.getUserSubscribers());
        }
        return "subscriptions";
    }

    /*private String checkCurrentUser(RedirectAttributes redirectAttributes, @RequestHeader(required = false) String referer, @AuthenticationPrincipal User currentUser, @PathVariable("userId") User user) {
        if (!currentUser.equals(user)) {
            if (referer != null) {
                UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();
                components.getQueryParams().
                        entrySet().
                        forEach(pair -> redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));
                return "redirect:" + components.getPath();
            } else {
                return "redirect:/projects";
            }
        }
        return null;
    }*/

    private void uploadFile(@PathVariable("userId") @Valid User user, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultFilename));
            user.setUserImage(resultFilename);
        }
    }

    private void deleteFile(@PathVariable("userId") @Valid User user) {
        File file = new File(uploadPath + "/" + user.getUserImage());
        if (file.exists()) {
            file.delete();
            user.setUserImage(null);
        }
    }

}
