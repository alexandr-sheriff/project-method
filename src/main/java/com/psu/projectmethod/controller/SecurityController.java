package com.psu.projectmethod.controller;

import com.psu.projectmethod.domain.Role;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.domain.dto.CaptchaResponseDto;
import com.psu.projectmethod.repo.UserRepo;
import com.psu.projectmethod.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Collections;
import java.util.Map;

@Controller
public class SecurityController {
    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String recaptchaSecret;

    @GetMapping("/")
    @PreAuthorize("hasAuthority('_1_ADMIN') or hasAuthority('_2_TEACHER') or hasAuthority('_3_STUDENT')")
    public String index(
            Authentication authentication) {
        if (authentication.getAuthorities().contains(Role._1_ADMIN)) {
            return "redirect:/admin";
        } else if (authentication.getAuthorities().contains(Role._2_TEACHER) || authentication.getAuthorities().contains(Role._3_STUDENT)) {
            return "redirect:/projects";
        }
        return "/";
    }

    @GetMapping("/register")
    public String getRegistration(
            @ModelAttribute("user") User user
    ) {
        return "register";
    }

    @PostMapping("/register")
    public String processRegistration(
            @RequestParam("password2") String passwordConfirm,
            @RequestParam("g-recaptcha-response") String captchaResponse,
            @ModelAttribute("user") @Valid User user,
            BindingResult bindingResult,
            Model model) {
        boolean isUserByUsernameExist = userService.isUserByUsernameExist(user);
        if (isUserByUsernameExist) {
            model.addAttribute("usernameError", "Пользователь с таким логином уже существует");
        }
        boolean isUserByEmailExist = userService.isUserByEmailExist(user);
        if (isUserByEmailExist) {
            model.addAttribute("usernameError", "Пользователь с таким email уже существует");
        }
        boolean isConfirmEmpty = !StringUtils.isEmpty(passwordConfirm) && StringUtils.isEmpty(passwordConfirm);
        if (isConfirmEmpty) {
            model.addAttribute("password2Error", "Необходимо ввести пароль еще раз");
        }
        boolean isDifferentPasswords = user.getPassword() != null && !user.getPassword().equals(passwordConfirm);
        if (isDifferentPasswords) {
            model.addAttribute("password2Error", "Подтверждение не совпадает с паролем");
        }
        String url = String.format(CAPTCHA_URL, recaptchaSecret, captchaResponse);
        CaptchaResponseDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);
        if (!response.isSuccess()) {
            model.addAttribute("captchaError", "Пожалуйста, заполните капчу");
        }
        if (isUserByUsernameExist || isUserByEmailExist || isConfirmEmpty || isDifferentPasswords || bindingResult.hasErrors() || !response.isSuccess()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "register";
        } else {
            userService.addUser(user);
            return "redirect:/login";
        }
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);
        if (isActivated) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Пользователь успешно активирован");
        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Код активации пользователя не найден");
        }
        return "login";
    }

    @GetMapping("/success")
    public String successLogin(Authentication authentication) {
        if (authentication.getAuthorities().contains(Role._1_ADMIN)) {
            return "redirect:/admin";
        } else if (authentication.getAuthorities().contains(Role._2_TEACHER) || authentication.getAuthorities().contains(Role._3_STUDENT)) {
            return "redirect:/projects";
        }
        return "/";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/";
    }
}
