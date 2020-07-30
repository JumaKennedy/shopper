<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="_index" value="active" />


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

  <title>Cart</title>

 <!-- Mobile Specific Meta-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="static/images/favicon.png" />
  
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


<!-- Main Menu Section -->
<jsp:include page="header.jsp"/>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Cart</h1>
					<ol class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li class="active">cart</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>



<div class="page-wrapper">
  <div class="cart shopping">
    <div class="container">
      <div class="row">
        <div class="col-md-8">
          <div class="block">
           <c:if test="${empty itemlist}">
           <h3 class="text-center text-success">Cart is Empty 
             <a href="shop" class="btn btn-main btn-round btn-icon "><i class="tf-ion-ios-cart-outline"></i>Continue Shopping</a>
           </h3>
            </c:if>
            <c:if test="${not empty itemlist}">  
            
            <div class="product-list">
              
                <table class="table">
                  <thead>
                    <tr class="text-center">
                      <th class="">#</th>
                      <th class="">Item </th>
                      <th class="">Detail</th>
                      <th class="col-lg-3">Qty</th>
                      <th class="">Amount</th>
                      <th class="">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                   <c:set var="count" value="0"/>
                    <c:forEach var="item" items="${itemlist}">
				    <c:set var="count" value="${count+1}"/>
                    <tr class="">
                      <td class="">
                        ${count}.
                      </td>
                      <td class="">
                        <div class="product-info">
                          <img width="80" src="static/img/products/${item.getProduct().id}/${item.getProduct().img}" alt="" />
                          <a href="#"> 
                          </a>
                          
                        </div>
                        
                      </td>
                      <td class="">
                        <div class="product-info">
                          ${item.getProduct().name}
                           <br> 
                          Size: ${item.size}<br>
                          Color: ${item.color}<br>
                          $<fmt:formatNumber value="${item.getProduct().price}" 
				      		 maxFractionDigits="2" minFractionDigits="2"/>
                                                    
                        </div>
                        
                      </td>
                      <td >
                      
                      <form action="updateQty" method="Get" class="col-lg-6">	                     
                         <select class="form-control" onchange="this.form.submit()" name="qty">
							<option value="${item.qty}" selected>${item.qty}</option>
										<option value="1">1</option>
			                            <option value="2">2</option>
			                            <option value="3">3</option>
			                            <option value="4">4</option>
			                            <option value="5">5</option>
			                            <option value="6">6</option>
			                            <option value="7">7</option>
			                            <option value="8">8</option>					  
									</select>
					<input type="hidden" name="id"  value="${item.id}" /> 														    														
					</form>
                     
                      </td>
                      <td>
                      $<fmt:formatNumber value="${item.getProduct().price*item.qty}" 
				       maxFractionDigits="2" minFractionDigits="2"/>
				       </td>
                      <td class="">
                        <a href="deleteItem?id=${item.id}" 
				       onclick="confirmed(); return false;" class="btn btn-default"> 
				       <i class="tf-ion-close"></i></a>
                      </td>
                    </tr>
                    
                    </c:forEach>
                  </tbody>
                </table>
                <a href="emptycart" class="btn btn-main btn-medium ">Empty Cart <i class="tf-ion-ios-cart-outline"></i></a>
                <a href="shop" class="btn btn-main btn-medium ">Continue Shopping <i class="tf-ion-ios-cart-outline"></i></a>
               <sec:authorize access="!isAuthenticated()">
				   <a href="checkout" class="btn btn-main pull-right">Checkout</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				   <a href="checkingout" class="btn btn-main pull-right">Checkout</a>
				 </sec:authorize>
             
            </div>
            </c:if>
          </div>
        </div>
        
        <div class="col-md-4">
               <div class="product-checkout-details">
               <c:if test="${not empty itemlist}">
                  <div class="block">
                     <h4 class="widget-title">Order Summary
                     </h4>
                    
                     <c:forEach var="item" items="${itemlist}">
                     
                     <ul class="summary-prices">
                        <li>
                           <span> ${item.getProduct().name}:</span>
                           <span class="price">$
                           <fmt:formatNumber value="${item.getProduct().price*item.qty}" 
					       maxFractionDigits="2" minFractionDigits="2"/>
					       </span>
                        </li>
                     </ul>
                     </c:forEach>
                        <ul class="summary-prices">
                        <li>
                           <span>Shipping:</span>
                           <span>Free</span>
                        </li>
                        </ul>
                     <div class="summary-total">
                        <span>Total Due</span>
                        <span>$<fmt:formatNumber value="${itemlist.stream().map(a -> a.getProduct().price*a.qty).sum()}" 
				       maxFractionDigits="2" minFractionDigits="2"/>
				       </span>
                     </div>
                     <div class="verified-icon">
                        <img src="static/images/shop/verified.png">
                     </div>
                  </div>
                  </c:if>
               </div>
            </div>
            
      
      </div>
    </div>
  </div>
</div>


  <jsp:include page="footer.jsp"/>

   

  </body>
  </html>
