package com.shop.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.Utils.WebUtils;
import com.shop.model.Products;
import com.shop.repository.PaymentMethodRepository;
import com.shop.repository.ProductRepository;

@Controller
public class ProductCotroller {
	
	@Autowired
	private ProductRepository repo;
	
	@Autowired
	PaymentMethodRepository paymentRepository;
	
	@Autowired
	private WebUtils webUtils;
	
		
	@PostMapping("saveproduct")
	String saveproduct(@ModelAttribute Products pro, RedirectAttributes redirect) throws IllegalStateException, IOException {
		
		try {
			
			 MultipartFile[] file=pro.getFile();
			 if(file.length>0) {
			// String fileName = file[0].getOriginalFilename();	         
			 String parseMd5=webUtils.md5(file[0].getOriginalFilename().toLowerCase());
	         pro.setImg(parseMd5);}
			 repo.save(pro);
			 webUtils.addproductImages(pro);			
			redirect.addFlashAttribute("msg", "Product Saved");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/shop";
	}
	
	@PostMapping("editproduct")
	String editproduct(@ModelAttribute Products pro, RedirectAttributes redirect) throws IllegalStateException, IOException {
		
		try {
			 repo.save(pro);
			 webUtils.addproductImages(pro);			
			 redirect.addFlashAttribute("msg", "Product Updated");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/profile";
	}
	
	@GetMapping("deleteproduct")
	String deleteproduct(@RequestParam Long id) {
		repo.deleteById(id);
		return "redirect:profile";	
	}
	
	@ModelAttribute("product")
	Products prod() {
	return new Products();		
	}

}
