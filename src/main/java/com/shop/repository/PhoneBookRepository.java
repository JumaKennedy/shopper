package com.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.model.PhoneBook;

public interface PhoneBookRepository extends JpaRepository<PhoneBook, Long> {

}
