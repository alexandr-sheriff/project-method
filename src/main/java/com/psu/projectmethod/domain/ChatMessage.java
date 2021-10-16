package com.psu.projectmethod.domain;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table
public class ChatMessage implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long chatMessageId;

    @Size(min = 20, max = 500, message = "Введено некорректное сообщение. Сообщение должно быть длиной от 20 до 500 символов.")
    private String chatMessageText;

    @ManyToOne
    @LazyCollection(LazyCollectionOption.FALSE)
    @JoinColumn(name = "user_id")
    private User chatMessageSender;

    @OneToMany
    @JoinTable(name = "chatMessage_files",
            joinColumns = {@JoinColumn(name = "fk_chat_message_id")},
            inverseJoinColumns = {@JoinColumn(name = "fk_file_id")})
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<File> chatMessageFiles = new ArrayList<File>();

    public ChatMessage() {
    }

    public Long getChatMessageId() {
        return chatMessageId;
    }

    public void setChatMessageId(Long chatMessageId) {
        this.chatMessageId = chatMessageId;
    }

    public String getChatMessageText() {
        return chatMessageText;
    }

    public void setChatMessageText(String chatMessageText) {
        this.chatMessageText = chatMessageText;
    }

    public User getChatMessageSender() {
        return chatMessageSender;
    }

    public void setChatMessageSender(User chatMessageSender) {
        this.chatMessageSender = chatMessageSender;
    }

    public List<File> getChatMessageFiles() {
        return chatMessageFiles;
    }

    public void setChatMessageFiles(List<File> chatMessageFiles) {
        this.chatMessageFiles = chatMessageFiles;
    }

    public void addFile(File file) {
        chatMessageFiles.add(file);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChatMessage that = (ChatMessage) o;
        return Objects.equals(chatMessageId, that.chatMessageId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(chatMessageId);
    }

    @Override
    public String toString() {
        return "ChatMessage{" +
                "chatMessageId=" + chatMessageId +
                ", chatMessageText='" + chatMessageText + '\'' +
                ", chatMessageSender=" + chatMessageSender +
                ", chatMessageFiles=" + chatMessageFiles +
                '}';
    }
}
