package com.psu.projectmethod.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table
public class File implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long fileId;

    private String filename;

    private String encodedFilename;

    public File() {
    }

    public Long getFileId() {
        return fileId;
    }

    public void setFileId(Long fileId) {
        this.fileId = fileId;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getEncodedFilename() {
        return encodedFilename;
    }

    public void setEncodedFilename(String encodedfilename) {
        this.encodedFilename = encodedfilename;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        File file = (File) o;
        return Objects.equals(fileId, file.fileId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(fileId);
    }

    @Override
    public String toString() {
        return "File{" +
                "fileId=" + fileId +
                ", filename='" + filename + '\'' +
                ", encodedFilename='" + encodedFilename + '\'' +
                '}';
    }
}
