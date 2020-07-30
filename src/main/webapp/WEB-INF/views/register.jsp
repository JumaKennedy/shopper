<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="description" content="#">
  
  <meta name="author" content="#">

  <title>Register</title>

  <!-- Mobile Specific Meta-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
  
  <!-- Themefisher Icon font -->
  <link rel="stylesheet" href="static/plugins/themefisher-font/style.css">
  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="static/plugins/bootstrap/css/bootstrap.min.css">
  
  <!-- Revolution Slider -->
  <link rel="stylesheet" type="text/css" href="static/plugins/revolution-slider/revolution/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css">
  <link rel="stylesheet" type="text/css" href="static/plugins/revolution-slider/revolution/fonts/font-awesome/css/font-awesome.css">

  <!-- REVOLUTION STYLE SHEETS -->
  <link rel="stylesheet" type="text/css" href="static/plugins/revolution-slider/revolution/css/settings.css">
  <link rel="stylesheet" type="text/css" href="static/plugins/revolution-slider/revolution/css/layers.css">
  <link rel="stylesheet" type="text/css" href="static/plugins/revolution-slider/revolution/css/navigation.css">
  
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="static/css/style.css">

</head>

<body id="body">
<%-- <jsp:include page="header.jsp"/> --%>
<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          
          
          <form:form action="register" modelAttribute="user" method="post" class="text-left clearfix" >
          <h3><span class="text-success"> CREATE YOUR ACCOUNT ${success}</span>
                  <span class="text-danger text-center">${error}</span>
           </h3>
            <div class="form-group">
              <form:input type="text" path="fname"  class="form-control"  placeholder="First Name"/>
              <form:errors path="fname" class="text-danger text-center"/>
            </div>
            <div class="form-group">
              <form:input type="text" path="lname" class="form-control"  placeholder="Last Name"/>
              <form:errors path="lname" class="text-danger text-center"/>
            </div>
            <div class="form-group">
              <form:input type="hidden" path="id"/>
              <form:input type="email" path="email" class="form-control"  placeholder="E-mail"/>
              <form:errors path="email" class="text-danger text-center"/>
            </div>            
            <div class="form-group">
              <form:input type="password" path="password" class="form-control"  placeholder="Password"/>
              <form:errors path="password" class="text-danger text-center"/>
            </div>
            <div class="form-group">
              <form:input type="password" path="password2" class="form-control"  placeholder="Password"/>
              <form:errors path="password2" class="text-danger text-center"/>
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-main text-center">CREATE ACCOUNT</button>
            </div>
          </form:form>
          <p class="mt-20">Already hava an account ?<a href="login"> Login</a></p>
           <p>
          <a  href="#" data-toggle="modal" data-target="#forgot" 
            class="btn btn-link">Forgot your password?</a>
          </p>
          <p><a href="index"> Home</a> | <a href="shop"> Shop</a></p>
        </div>
      </div>
    </div>
  </div>
</section>

    
   <jsp:include page="footer.jsp"/>

  </body>
  </html>