package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.ChatMessage;
import com.psu.projectmethod.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface ChatMessageRepo extends CrudRepository<ChatMessage, Long> {
    User findByChatMessageSender_Username(String username);
}
