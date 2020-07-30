package com.shop.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorHandler implements ErrorController  {
 
	@RequestMapping("/error")
	public String handleError(HttpServletRequest request) {
	    Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
	     
	    if (status != null) {
	        Integer statusCode = Integer.valueOf(status.toString());
	        String er="Sorry requested page not found <br> The page might have moved permanently";
	        if(statusCode == HttpStatus.NOT_FOUND.value()) {
	        	request.setAttribute("error", er);
	        	request.setAttribute("status", statusCode);
	            return "error";
	        }
	        else if(statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
	        	request.setAttribute("error", "Technical error occured");
	        	request.setAttribute("status", statusCode+"Unexpected Error");
	        	request.setAttribute("error", "Our Engineers are working on it");
	        	
	        	return "error";
	        }
	        
	        request.setAttribute("expired", "Your session expired"); 
	    }
	    return "login";
	}
	 
    @Override
    public String getErrorPath() {
        return "/error";
    }
}
