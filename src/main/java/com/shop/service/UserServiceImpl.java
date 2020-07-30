package com.shop.service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.shop.model.Role;
import com.shop.model.Users;
import com.shop.repository.RoleRepository;
import com.shop.repository.UserRepository;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	private UserRepository userRepository;
	
	private RoleRepository roleRepository;
    
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    private enum roles {
	      USER, DBA, ADMIN
    }
    
	@Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository,
			BCryptPasswordEncoder bCryptPasswordEncoder) {
		super();
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}

    @Override
    public void save(Users user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setActive(1);
        Role userRole = roleRepository.findByRole(roles.USER.toString());
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        userRepository.save(user);
    }

	
	@Override
	public void delete(Long id) {
		userRepository.deleteById(id);
	}

	@Override
	public List<Users> findAll() {
		return userRepository.findAll();
	}

	@Override
	public void Update(Users user) {
		userRepository.findById(user.getId()).
		ifPresent(a->{
		  a.setAddress(user.getAddress());
		  a.setFname(user.getFname());
		  a.setLname(user.getLname());		  		  
		});
		
	}

	@Override
	public List<Users> SearchByname(String name) {
		return userRepository.searchByName(name);
	}

	@Override
	public Optional<Users> findByEmail(String email) {
		return userRepository.getByEmail(email);
	}

	@Override
	public Optional<Users> findById(Long id) {
		return userRepository.findById(id);
	}

	@Override
	public Optional<Users> login(String email, String password) {
		return userRepository.login(email, password);
	}

	@Override
	public void addcoment(Long id, String comment) {
		userRepository.findById(id).
		ifPresent(a->{
		  a.setComment(comment);		  	  
		});
	}

}
