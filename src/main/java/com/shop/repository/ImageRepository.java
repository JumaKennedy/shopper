package com.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.model.ImageFiles;



@Repository
public interface ImageRepository extends JpaRepository<ImageFiles, Long> {

}
