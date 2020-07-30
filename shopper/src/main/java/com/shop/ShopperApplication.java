package com.shop;

import java.util.Arrays;
import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.shop.model.Role;
import com.shop.model.Users;

@SpringBootApplication
public class ShopperApplication implements CommandLineRunner{

	@Autowired 
	private com.shop.repository.UserRepository userRepository; 
	
	@Autowired 
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
	public static void main(String[] args) {
		SpringApplication.run(ShopperApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {		
		
		
		
		if(!userRepository.getByEmail("admin@email.com").isPresent()) {
			HashSet<Role> roles= new HashSet<>();
			
			Role role_1=new Role(3, "USER");
	        Role role_2=new Role(3, "DBA");
	        Role role_3=new Role(3, "ADMIN");
	        
	        roles.add(role_1);
	        roles.add(role_2);
	        roles.add(role_3);
	        
			Users user=new Users();
			user.setFname("Admin");
			user.setLname("Manager");
			user.setEmail("admin@email.com");
			user.setPassword("123");
			user.setPassword2("123");			
			user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
	        user.setActive(1);	      
	        
	        user.setRoles(roles);
	        userRepository.save(user);
	       
		}
	}
}
