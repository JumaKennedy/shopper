package com.shop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.model.Users;

public interface UserRepository extends JpaRepository<Users, Long> {

	Optional<Users> getByEmail(String email);
	
	@Query("FROM Users WHERE email=?1 AND password=?2")
	Optional<Users> login(String email, String password);
	
	@Query("FROM Users WHERE fname=?1 OR lname=?1")
	List<Users> searchByName(String name);
	
	
}
