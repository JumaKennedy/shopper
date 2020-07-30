package com.shop.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.Utils.DataValidation;
import com.shop.Utils.States;
import com.shop.Utils.WebUtils;
import com.shop.model.Addressess;
import com.shop.model.PaymentMethod;
import com.shop.model.PhoneBook;
import com.shop.model.Products;
import com.shop.model.Role;
import com.shop.model.Users;
import com.shop.repository.AddressRepository;
import com.shop.repository.PaymentMethodRepository;
import com.shop.repository.PhoneBookRepository;
import com.shop.repository.RoleRepository;
import com.shop.service.SecurityService;
import com.shop.service.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private DataValidation dataValidation;
	@Autowired
	private UserService userService;
	@Autowired
	private AddressRepository addressRepository;
	
	@Autowired
	private PhoneBookRepository phoneBookRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private SecurityService securityService;
	
	@Autowired
	private WebUtils webUtils;
	
	@Autowired
	PaymentMethodRepository paymentMethodRepository;
	
	@Autowired
	private WebApplicationContext appContext;
	
	@GetMapping("register")
	String register(Model model) {
	 model.addAttribute("user", new Users());		
	return "register";		
	}
	
	@PostMapping("register")
	String register(@ModelAttribute("user") Users user, 
					BindingResult result, 
					RedirectAttributes redirect) {

			try {
				dataValidation.validate(user, result);
				if (result.hasErrors()) {
				   return "register";
		        }
			
			userService.save(user);
			securityService.autoLogin(user.getEmail(), user.getPassword2());
			redirect.addFlashAttribute("msg", "Registration success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	return "redirect:/profile";	
	}
	
	@GetMapping("/login")
    public String login(Model model, String error, String logout,  String expired) {
    	try {
			if (expired != null) {				
				model.addAttribute("expired", "Your Have been logged out due to inactivity.");			   
			}
			if (error != null) {
			    model.addAttribute("error", "Your username and password is invalid.");
			}
			if (logout != null) {
			    model.addAttribute("logout", "You have been logged out.");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        return "login";
    }
	
	@GetMapping("profile")
	String profile(Model model, Principal principal) {
		
		model.addAttribute("_profile", "active"); 
		model.addAttribute("user_account", userService.findByEmail(principal.getName()).get());
		
		return "profiles";		
	}
	
	@GetMapping("logout")
	String logout(Model model) {
		model.addAttribute("msg", "You have been logged out");
	return "login";		
	}
	
	@PostMapping("login")
	String login(@RequestParam String email,
			    @RequestParam String password, Model model) {
		
		try {
			Optional<Users> user= userService.login(email, password); 
			if(user.isPresent()) {				
			model.addAttribute("msg", "Welcome"); 
			Users usr=new Users();
			usr.setEmail(email);
			return "redirect:profile";
			}
			model.addAttribute("error", "Invalid credential");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	   return "login";		
	}
	
	@GetMapping("users")
	String users(Model model) {
		try {
			model.addAttribute("users", userService.findAll());
			model.addAttribute("msg", "All Users");
		} catch (Exception e) {
			e.printStackTrace();
		}
	return "users";		
	}
	
	@PostMapping("/addimages")
	public String add(@RequestParam("file") MultipartFile file, 
			@RequestParam Long id, RedirectAttributes model) {
    	    
		Pattern ext = Pattern.compile("([^\\s]+(\\.(?i)(png|jpg))$)");
		try {
			
			  if(file != null && file.isEmpty()){
				  model.addFlashAttribute("error", "Error No file Selected "); 
			      return "redirect:profile"; 
			      } 
			  if(file.getSize()>1073741824){
				  model.addAttribute("error","File size "+file.getSize()+"KB excceds max allowed, try another photo ");
				  return "redirect:profile"; 
			      } 
			  Matcher mtch = ext.matcher(file.getOriginalFilename());
			  
			  if (!mtch.matches()) {
				  model.addFlashAttribute("error", "Invalid Image type "); 
			      return "redirect:profile";			  
			  }
			 		
			//save image
			webUtils.addProfilePhoto(file, id, "users");
			model.addFlashAttribute("msg", "Upload success "+ file.getSize()+" KB");
			model.addFlashAttribute("_profile", "active");
		} catch (Exception e) {
			//e.printStackTrace);
		}

		return "redirect:profile";
	}
	
	@PostMapping("search")
	String search(@RequestParam String name, Model model) {
	    model.addAttribute("users", userService.SearchByname(name));
	    model.addAttribute("msg", "User(s) found with "+ name);
		return "users";
	}
	
	
	@GetMapping("delete")
	String delete(@RequestParam Long id, RedirectAttributes redirect) {
		
		try {
			userService.delete(id);
			redirect.addFlashAttribute("success", "Delete Success");
		} catch (Exception e) {
			e.printStackTrace();
			redirect.addFlashAttribute("success", "Delete Fail");
		}
		
		return "redirect:/users";		
	}
	
	@PostMapping("editrole")
	String editrole(@RequestParam Long id, @RequestParam String role, 
			RedirectAttributes redirect) {
		
		try {			
			userService.findById(id).
			ifPresent(a->{				
				a.setRoles(new HashSet<Role>(Arrays.asList(roleRepository.findByRole(role))));
			    userService.save(a);
			});
			
			redirect.addFlashAttribute("success", role+ " Role Granted ");
		} catch (Exception e) {
			e.printStackTrace();
			redirect.addFlashAttribute("success", "Operation Fail");
		}
		
		return "redirect:/users";		
	}
	
	@PostMapping("addcoment")
	String addcoment(@RequestParam String comment, 
			@RequestParam Long id,
			Model model) {
		
		userService.addcoment(id, comment);		
		model.addAttribute("msg", "Update success");
		return "redirect:profile";
	}
	
	@PostMapping("updatecontact")
	String update(@ModelAttribute Addressess addressess, Model model) {
	
		try {
			Users user=userService.findById(addressess.getId()).get();	
			addressess.setUser(user);
			addressRepository.save(addressess);
			model.addAttribute("msg", "Update success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
		
	}
	
	@PostMapping("addcard")
	String addcard(@ModelAttribute PaymentMethod payment, Model model) {
	
		try {
			Users user=userService.findById(payment.getId()).get();	
			payment.setUser(user);			
			paymentMethodRepository.save(payment);
			model.addAttribute("msg", "Card Added");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
		
	}
	
	@PostMapping("addphone")
	String addphone(@RequestParam Long id, @RequestParam String type, 
					@RequestParam String tel, Model model) {
	
		try {
			PhoneBook book = new PhoneBook();
			Users user=userService.findById(id).get();	
			book.setUser(user);
			book.setTel(tel);
			book.setType(type);
			phoneBookRepository.save(book);
			model.addAttribute("msg", "Phone Added");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
		
	}
	
	@GetMapping("deletephone")
	String deletephone(@RequestParam Long id, RedirectAttributes redirect) {
		
		try {
			phoneBookRepository.deleteById(id);
			redirect.addFlashAttribute("success", "Delete Success");
		} catch (Exception e) {
			e.printStackTrace();
			redirect.addFlashAttribute("success", "Delete Fail");
		}
		
		return "redirect:profile";		
	}
	
	@GetMapping("deletecard")
	String deletecard(@RequestParam Long id) {
		paymentMethodRepository.deleteById(id);
		return "redirect:profile";	
	}
	
	@ModelAttribute("states")
    public List<States> populateStates(){    	
        return Arrays.asList(States.values());
    }
	
	@ModelAttribute("product")
	Products prod() {
	return new Products();		
	}
	
	@ModelAttribute("card")
	PaymentMethod pay() {
	return new PaymentMethod();		
	}
	
	
	@ModelAttribute("address")
	Addressess address() {
	return new Addressess();		
	}
	
	
}
