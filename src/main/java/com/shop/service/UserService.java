package com.shop.service;

import java.util.List;
import java.util.Optional;

import com.shop.model.Users;

public interface UserService {
	
	void save(Users user);
	void delete(Long id);
	List<Users> findAll();
	void Update(Users user);
	void addcoment(Long id, String comment);
	List<Users> SearchByname(String name);
	Optional<Users> findByEmail(String email);
	Optional<Users> findById(Long id);
	Optional<Users> login(String email, String password);
	

}
