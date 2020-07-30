package com.shop.Utils;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import javax.xml.bind.DatatypeConverter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.shop.model.ImageFiles;
import com.shop.model.Products;
import com.shop.repository.ProductRepository;
import com.shop.repository.UserRepository;
import com.shop.service.ImageFileService;

@Component
@Transactional
public class WebUtils{
	
	private static final Logger log=LoggerFactory.getLogger("WebUtils.class");
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private UserRepository usersRepository;
	
	@Autowired
	private ImageFileService imageFileService;
	
	@Autowired
	private ProductRepository productRepository;
		
	@Autowired
    HttpServletRequest request;
	
	private static final String UPLOADED_FOLDER = "static"+ File.separator +"img";
	private static final String folder="products";
	
	public void addProfilePhoto(MultipartFile file, long id, String folder) throws IllegalStateException, IOException {
	      try {
			 // save dir
	    	 String destDir = request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER)+ File.separator +folder+ File.separator +id+ File.separator +"profile";
	    	 log.info("This is path {}", destDir);
	    	 
	    	 //innitalize file	    	 
			 File dir = new File(destDir);
			 //if folder does not exist create it
			 if(!dir.exists()){                                    	 
			    new File(destDir).mkdirs();                                        
				}
			 
				MultipartFile multipartFile = (MultipartFile) file; 
				String fileName = file.getOriginalFilename(); //set
				
				String img= usersRepository.findById(id).get().getImage();
			
			    File doc = new File(destDir + File.separator + img); 
			    if(doc.exists()) {
			    doc.delete(); 
			    }
			 
			    //rename file to md5
			    String parseMd5=md5(fileName.toLowerCase());
			    File destination = new File(destDir + File.separator + parseMd5);
			    //save to file system and db
			    multipartFile.transferTo(destination);				
			    usersRepository.findById(id).ifPresent(
			    		a->{
			    		a.setImage(parseMd5);
			    		
			    		});
			  } catch (Exception e) {
				e.printStackTrace();
			}
				 
		   }
	
		public String addproductImages(Products product) throws IllegalStateException, IOException {
		  	  
			try {
				saveImages(product);				    
				
				} catch (Exception e) {
					e.printStackTrace();
					return "Upload Fail";
				}
			  
			return "Success";
		  }
		
		public void addsingleImage(MultipartFile[] file, long id, String folder) throws NoSuchAlgorithmException, IllegalStateException, IOException {
			
			String realPathtoUploads = request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER);
			File dir = new File(realPathtoUploads+ File.separator + folder+ File.separator + id);
			
			 String destDir = request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER)+ File.separator +folder+ File.separator +id+ File.separator +folder;
	    	 log.info("This is path {}", destDir);
	    	 
	    	   //if folder does not exist create it
			   if(!dir.exists()){                                    	 
			    new File(destDir).mkdirs();                                        
				}
			 
				//MultipartFile[] img = file[0].getOriginalFilename(); 
			    MultipartFile multipartFile = file[0]; 
			 	String fileName = multipartFile.getOriginalFilename(); 
				//set
				//name file to md5
			    String parseMd5=md5(fileName.toLowerCase());
			    //String filePath = realPathtoUploads + File.separator + folder+ File.separator + id+ File.separator + parseMd5;
		         ImageFiles images= new ImageFiles();
		         //save to database			         
		         images.setImage(parseMd5);
		         images.setStockId(id);	
		         images.setSize(multipartFile.getSize());
		         images.setExt(multipartFile.getContentType());
		         imageFileService.save(images);
		         
			    File destination = new File(destDir + File.separator + parseMd5);
			    //save to file system and db
			    multipartFile.transferTo(destination);				
			    
		
		}
		
		
		void saveImages(Products product) throws NoSuchAlgorithmException, IllegalStateException, IOException {
			MultipartFile[] files=product.getFile();
			String realPathtoUploads = request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER);
			File dir = new File(realPathtoUploads+ File.separator + folder+ File.separator + product.getId());
			
			if (!dir.exists())
			    dir.mkdirs();
			List<String> fileNames = new ArrayList<String>();
			if (files!=null &&  files.length > 0) {
			     for (MultipartFile file : files) {			    	 
			         String fileName = file.getOriginalFilename();
			         String parseMd5=md5(fileName.toLowerCase());
			         fileNames.add(parseMd5);
			         
			         if(!fileName.isEmpty()) {
			         String filePath = realPathtoUploads + File.separator + folder+ File.separator + product.getId()+ File.separator + parseMd5;
			         ImageFiles images= new ImageFiles();
			         //save to database			         
			         images.setImage(parseMd5);
			         images.setStockId(product.getId());		
			         images.setSize(file.getSize());
			         images.setExt(file.getContentType());
			         imageFileService.save(images);
			         //save to web folder
			         File destination = new File(filePath);
			         //file.transferTo(destination);
			         file.transferTo(destination);
			         }
			        }
			       }
			
			
			
		}
	
    
	public void sendMail(String to, String msg, String subject) {
        MimeMessage message = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        try {
            helper.setTo(to);
            helper.setText(msg);
            helper.setSubject(subject);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        try {
			sender.send(message);
		} catch (MailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	}        
  }
    
	
	
	public void multiplesave(MultipartFile[] files, long id) throws IllegalStateException, IOException {
  	  
			try {
				String realPathtoUploads = request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER);
				File dir = new File(realPathtoUploads+ File.separator + folder+ File.separator + id);
				if (!dir.exists())
				    dir.mkdirs();
				List<String> fileNames = new ArrayList<String>();
				if (files!=null &&  files.length > 0) {
				     for (MultipartFile file : files) {			    	 
				         String fileName = file.getOriginalFilename();
				         String parseMd5=md5(fileName.toLowerCase());
				         fileNames.add(parseMd5);
				         
				         if(!fileName.isEmpty()) {
				         String filePath = realPathtoUploads + File.separator + folder+ File.separator + id+ File.separator + parseMd5;
				         ImageFiles images= new ImageFiles();
				         //save to database			         
				         images.setImage(parseMd5);
				         images.setStockId(id);		
				         images.setSize(file.getSize());
				         images.setExt(file.getContentType());
				         imageFileService.save(images);
				         //save to web folder
				         File destination = new File(filePath);
				         //file.transferTo(destination);
				         file.transferTo(destination);
				         }
				        }
				       }
			} catch (Exception e) {
				e.printStackTrace();
			}
	    }
	
	
	 	   
	   public String removefiles(long id, String image, String folder) {
		try {
			String realPathtoUploads = 
		    request.getSession().getServletContext()
		    .getRealPath(UPLOADED_FOLDER+ File.separator +folder);			
			File file = new File(realPathtoUploads + File.separator 
					+ id+ File.separator +image+"");    		
	 	    file.delete();
		} catch (Exception e) {
			e.printStackTrace();
			return "Delete operation is failed.";
		}
		return "Delete Success.";
	   }
	   
	   public void getFiles(Model model, long id, String folder) {
	    	List<String> results = new ArrayList<String>();
			try {
				String realPathtoUploads = 
				request.getSession().getServletContext().getRealPath(UPLOADED_FOLDER+ File.separator +folder);
						
				File[] files = new File(realPathtoUploads + File.separator + id).listFiles();
			   for (File file : files) {
				    if (file.isFile()) {
				        results.add(file.getName());
				        model.addAttribute("filenames", results);
				     }				   
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	   
	   public String md5(String filename) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		    String hash = DatatypeConverter.printHexBinary(MessageDigest.getInstance("MD5").digest(filename.getBytes("UTF-8")));
			return hash;
	   }
	   
	
    
}