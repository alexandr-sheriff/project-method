package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.repo.UserRepo;
import com.psu.projectmethod.service.AdminService;
import com.psu.projectmethod.service.ProjectService;
import com.psu.projectmethod.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Map;
import java.util.List;
import java.util.List;

@Controller
@PreAuthorize("hasAuthority('_1_ADMIN')")
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String viewAdminPanel(
            @AuthenticationPrincipal User currentUser,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        List<Integer> countProjectStatuses = projectService.countProjectStatuses();
        List<Double> percentageProjectStatuses = projectService.percentageProjectStatuses();
        List<Project> findProjects = projectService.projectList();
        List<User> findStudents = userService.findByRolesEquals(Sort.by("username"), Role._3_STUDENT);
        List<User> findTeachers = userService.findByRolesEquals(Sort.by("username"), Role._2_TEACHER);
        model.addAttribute("countProjectStatuses", countProjectStatuses);
        model.addAttribute("percentageProjectStatuses", percentageProjectStatuses);
        model.addAttribute("projects", findProjects);
        model.addAttribute("students", findStudents);
        model.addAttribute("teachers", findTeachers);
        return "adminPanel";
    }

    @GetMapping("/users")
    public String viewAdminUsers(
            @AuthenticationPrincipal User currentUser,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        List<User> users = userService.userList();
        model.addAttribute("url", "/admin/users");
        model.addAttribute("users", users);
        model.addAttribute("roles", Role.values());
        return "adminUsers";
    }

    @GetMapping("/user/create")
    public String viewAdminCreateUser(
            @AuthenticationPrincipal User currentUser,
            @ModelAttribute("user") User user,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        model.addAttribute("roles", Role.values());
        return "adminUserCreate";
    }

    @PostMapping("/user/create")
    public String processCreateUser(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("password2") String passwordConfirm,
            @RequestParam(required = false, defaultValue = "") List<String> roles,
            @ModelAttribute("user") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        model.addAttribute("roles", Role.values());
        boolean isUserByUsernameExist = userService.isUserByUsernameExist(user);
        if (isUserByUsernameExist) {
            model.addAttribute("usernameError", "Пользователь с таким логином уже существует");
        }
        boolean isUserByEmailExist = userService.isUserByEmailExist(user);
        if (isUserByEmailExist) {
            model.addAttribute("emailError", "Пользователь с таким email уже существует");
        }
        boolean isConfirmEmpty = !StringUtils.isEmpty(passwordConfirm) && StringUtils.isEmpty(passwordConfirm);
        if (isConfirmEmpty) {
            model.addAttribute("password2Error", "Необходимо ввести пароль еще раз");
        }
        boolean isDifferentPasswords = user.getPassword() != null && !user.getPassword().equals(passwordConfirm);
        if (isDifferentPasswords) {
            model.addAttribute("password2Error", "Подтверждение не совпадает с паролем");
        }
        if (isUserByUsernameExist || isUserByEmailExist || isConfirmEmpty || isDifferentPasswords || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "adminUserCreate";
        } else {
            adminService.createUser(user);
            return "redirect:/admin/users";
        }
    }

    @GetMapping("/user/{userId}/update")
    public String viewUpdateUser(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "adminUserUpdate";
    }

    @PutMapping("/user/{userId}/update")
    public String processUpdateUser(
            @AuthenticationPrincipal User currentUser,
            @RequestParam String firstname,
            @RequestParam String lastname,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam List<String> roles,
            @ModelAttribute("userId") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
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
            return "adminUserUpdate";
        } else {
            adminService.updateUser(user, firstname, lastname, username, email);
            return "redirect:/admin/users";

        }
    }

    @GetMapping("/user/{userId}/activate")
    public String activateUser(
            @AuthenticationPrincipal User currentUser,
            @PathVariable("userId") User user) {
        if (!currentUser.isAdmin())
            return "redirect:/projects";
        adminService.activateUser(user);
        return "redirect:/admin/users";
    }

}
