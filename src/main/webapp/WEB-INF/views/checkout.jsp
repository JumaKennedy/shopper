
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
<!-- Start Top Header Bar -->
<jsp:include page="header.jsp"/>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Checkout</h1>
					<ol class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li class="active">checkout</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="page-wrapper">
   <div class="checkout shopping">
      <div class="container">
         <div class="row">
            <div class="col-md-8">
               <div class="block billing-details">
                  <h4 class="widget-title">Billing Details</h4>
                  <form:form action="confirmation" modelAttribute="order" method="post" class="checkout-form">
                     <form:input type="hidden" path="id" />
                     <div class="form-group">
                        <label for="full_name">Full Name</label>
                         <form:input path="full_name" class="form-control" id="full_name" placeholder=""/>
                     </div>
                     
                     <div class="checkout-country-code clearfix">
                        <div class="form-group">
                        <label for="user_address">Address</label>
                        <form:input path="street" class="form-control" id="user_address" placeholder=""/>
                     </div>
                        <div class="form-group" >
                           <label for="email">E-Mail</label>
                           <form:input path="email" class="form-control" id="email" />
                        </div>
                     </div>
                     <div class="checkout-country-code clearfix">
                        <div class="form-group" >
                           <label for="city">City</label>
                           <form:input path="city" class="form-control" id="user_city" />
                        </div>
                        <div class="form-group">
                           <label for="zip">Zip Code</label>
                           <form:input path="zip" class="form-control" id="user_post_code"  />
                        </div>
                        
                     </div>
                     
                     <div class="checkout-country-code clearfix">
                        <div class="form-group">
                           <label for="user_post_code">State</label>
                           <form:input path="state" class="form-control" id="user_post_code" />
                        </div>
                        <div class="form-group" >
                           <label for="phone">Phone</label>
                           <form:input path="phone" class="form-control" id="tel" />
                        </div>
                     </div>
                     <button  class="btn btn-main mt-20">Place Order</button>
                  </form:form>
               </div>
               <div class="block">
                  <h4 class="widget-title">Payment Method</h4>
                  <p>Credit Cart Details (Secure payment)</p>
                  <div class="checkout-product-details">
                     <div class="payment">
                        <div class="card-details">
                           <form  class="checkout-form">
                              <div class="form-group">
                                 <label for="card-number">Card Number <span class="required">*</span></label>
                                 <input  id="card-number" class="form-control"   type="tel" placeholder="•••• •••• •••• ••••">
                              </div>
                              <div class="form-group half-width padding-right">
                                 <label for="card-expiry">Expiry (MM/YY) <span class="required">*</span></label>
                                 <input id="card-expiry" class="form-control" type="tel" placeholder="MM / YY">
                              </div>
                              <div class="form-group half-width padding-left">
                                 <label for="card-cvc">Card Code <span class="required">*</span></label>
                                 <input id="card-cvc" class="form-control"  type="tel" maxlength="4" placeholder="CVC" >
                              </div>
                              <button  class="btn btn-main mt-20">Add Credit</button>
                           </form>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-4">
               <div class="product-checkout-details">
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
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
   <!-- Modal -->
   <div class="modal fade" id="coupon-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-body">
               <form>
                  <div class="form-group">
                     <input class="form-control" type="text" placeholder="Enter Coupon Code">
                  </div>
                  <button type="submit" class="btn btn-main">Apply Coupon</button>
               </form>
            </div>
         </div>
      </div>
   </div>
   
<jsp:include page="footer.jsp"/>


  </body>
  </html>