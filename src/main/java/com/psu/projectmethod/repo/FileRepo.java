package com.psu.projectmethod.repo;

import com.psu.projectmethod.domain.File;
import org.springframework.data.repository.CrudRepository;

public interface FileRepo extends CrudRepository<File, Long> {
}
