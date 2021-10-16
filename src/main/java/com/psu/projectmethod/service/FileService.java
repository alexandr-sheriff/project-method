package com.psu.projectmethod.service;

import com.psu.projectmethod.domain.File;
import com.psu.projectmethod.repo.FileRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@Service
public class FileService {
    @Autowired
    private FileRepo fileRepo;

    @Value("${upload.path}")
    private String uploadPath;

    public void saveFile(File file) {
        fileRepo.save(file);
    }

    public com.psu.projectmethod.domain.File getFile(MultipartFile multipartFile) {
        String uuidFile = UUID.randomUUID().toString();
        String resultFilename = uuidFile + "." + multipartFile.getOriginalFilename();
        String resultPath = uploadPath + "/" + resultFilename;
        com.psu.projectmethod.domain.File file = new com.psu.projectmethod.domain.File();
        file.setFilename(multipartFile.getOriginalFilename());
        file.setEncodedFilename(resultFilename);
        try {
            multipartFile.transferTo(new java.io.File(resultPath));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return file;
    }

    public String getUploadPath() {
        return uploadPath;
    }

}
