package com.psu.projectmethod.controller;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ControllerUtils {

    static Map<String, String> getErrors(BindingResult bindingResult) {
        Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );
        return bindingResult.getFieldErrors().stream().collect(collector);
    }

/*
    public static void addUserRole(User user, Map<String, String> userRoles) {
        List<String> rolesList = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toList());
        user.getRoles().clear();
        for (String key : userRoles.keySet()) {
            if (rolesList.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
    }
*/

}
