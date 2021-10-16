package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.ChatMessage;
import com.psu.projectmethod.domain.Project;
import com.psu.projectmethod.domain.Team;
import com.psu.projectmethod.domain.User;
import com.psu.projectmethod.repo.ChatMessageRepo;
import com.psu.projectmethod.repo.ProjectRepo;
import com.psu.projectmethod.repo.TeamRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
public class ChatMessageService {
    @Autowired
    private ChatMessageRepo chatMessageRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private TeamRepo teamRepo;

    @Autowired
    private FileService fileService;

    public User senderUserName(String username) {
        return chatMessageRepo.findByChatMessageSender_Username(username);
    }

    public void userSendProjectChatMessage(User user, Project project, ChatMessage message, MultipartFile[] files) {
        uploadFiles(message, files);
        message.setChatMessageSender(user);
        project.addMessage(message);
        chatMessageRepo.save(message);
        projectRepo.save(project);
    }

    public void userSendTeamChatMessage(User user, Team team, ChatMessage message, MultipartFile[] files) {
        uploadFiles(message, files);
        message.setChatMessageSender(user);
        team.addMessage(message);
        chatMessageRepo.save(message);
        teamRepo.save(team);
    }

    public void uploadFiles(ChatMessage message, MultipartFile[] files) {
        List<MultipartFile> multipartFiles = Arrays.asList(files);
        if (files != null && multipartFiles.size() > 0) {
            java.io.File uploadDir = new java.io.File(fileService.getUploadPath());
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            for (MultipartFile multipartFile : files) {
                if (multipartFile.getSize() > 0 && !multipartFile.getOriginalFilename().isBlank()) {
                    com.psu.projectmethod.domain.File file = fileService.getFile(multipartFile);
                    fileService.saveFile(file);
                    message.addFile(file);
                }
            }
        }
    }
}
