package com.shop.Utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.shop.model.Users;
import com.shop.repository.UserRepository;

@Component
public class DataValidation implements Validator {
	
	@Autowired
	public UserRepository userRepository;
	
	String emailRegex ="^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
	String passwordRegex ="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";
	
	//String phoneRegex ="\\d{10}|(?:\\d{3}-){2}\\d{4}|\\(\\d{3}\\)\\d{3}-?\\d{4}";
			
	public boolean supports(Class<?> clazz) {
		return Users.class.equals(clazz);
	}

	public void validate(Object o, Errors errors) {
		Users user = (Users) o;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "fname", "size.user.fname");		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lname", "size.user.lname");			
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");		
		if (userRepository.getByEmail(user.getEmail()).isPresent()) {
	    	errors.rejectValue("email", "size.user.unique");
	    }
		
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
		/*
		 * if (user.getPassword().length() <=0 || user.getPassword().length() < 4) {
		 * errors.rejectValue("password", "size.user.password"); }
		 */
        
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password2", "NotEmpty");
        if (!user.getPassword2().equals(user.getPassword())) {
	    	errors.rejectValue("password2", "match.user.password2");
	    }
        
		
		if(!user.getEmail().matches(emailRegex)) { 
			errors.rejectValue("email","size.user.email"); 
		}
		 
        
        if (!user.getPassword().matches(passwordRegex)) {
        	errors.rejectValue("password", "size.user.password");
	    }
        
		/*
		 * if (!user.getPhone().matches(phoneRegex)) { errors.rejectValue("phone",
		 * "size.user.phone"); }
		 */
		
	}
}