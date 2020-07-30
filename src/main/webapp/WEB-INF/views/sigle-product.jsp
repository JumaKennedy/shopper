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

  <title>Product Detail</title>
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

<!-- Main Menu Section -->
<jsp:include page="header.jsp"/>


<section class="single-product">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li><a href="#">Shop</a></li>
					<li class="active">Single Product</li>
				</ol>
			</div>
			<div class="col-md-6">
				<ol class="product-pagination text-right">
				    <c:set var="cont" value=""/>
					<li><a href="productdetails?id=${item.id}"><i class="tf-ion-ios-arrow-left"></i> Next </a></li>
					<li><a href="productdetails?id=${item.id}">Preview <i class="tf-ion-ios-arrow-right"></i></a></li>
				</ol>
			</div>
		</div>
		<div class="row mt-20">
			<div class="col-md-5">
			
				<div class="single-product-slider">
												<div id='carousel-custom' class='carousel slide' data-ride='carousel'>
													<div class='carousel-outer'>
														<!-- me art lab slider -->
														<div class='carousel-inner '>
														    <div class='item active'>
																<img src='static/img/products/${item.id}/${item.img}' alt='' data-zoom-image="static/img/products/${item.id}/${item.img}" />
															</div>
															<c:forEach var="img" items="${item.getIfiles()}">
															<div class='item'>
																<img src='static/img/products/${item.id}/${img.image}' alt='' data-zoom-image="static/img/products/${item.id}/${img.image}" />
															</div>
															</c:forEach>
														</div>
														
														<!-- sag sol -->
														<a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
															<i class="tf-ion-ios-arrow-left"></i>
														</a>
														<a class='right carousel-control' href='#carousel-custom' data-slide='next'>
															<i class="tf-ion-ios-arrow-right"></i>
														</a>
													</div>
													
													<!-- thumb -->
													<ol class='carousel-indicators mCustomScrollbar meartlab'>
														  <c:set var="no" value="0"/>
														    <c:forEach var="img" items="${item.getIfiles()}">
														    <c:set var="no" value="${no+1}"/>
														    <li data-target='#carousel-custom' data-slide-to='${no}' class=''>
															<img src='static/img/products/${item.id}/${img.image}' alt='' />
														    </li>
														    </c:forEach>
														
													</ol>
												</div>
											</div>
									 </div>
									<div class="col-md-7">
									   <div class="single-product-details">
												<h2>${item.name}</h2>
												<p class="product-price">$<fmt:formatNumber value="${item.price}" 
				       							 maxFractionDigits="2" minFractionDigits="2"/></p>
												
												<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laborum ipsum dicta quod, quia doloremque aut deserunt commodi quis. Totam a consequatur beatae nostrum, earum consequuntur? Eveniet consequatur ipsum dicta recusandae.</p>
												<div class="color-swatches">
													<span>color:</span>
													<ul>
														<li>
															<a href="#" class="swatch-violet"></a>
														</li>
														<li>
															<a href="#" class="swatch-black"></a>
														</li>
														<li>
															<a href="#" class="swatch-cream"></a>
														</li>
														<li>
															<a href="#" class="swatch-red"></a>
														</li>
													</ul>
												</div>
												<form:form action="addtobag" modelAttribute="shoppingcart" method="post" role="form" class="contactForm">				         					    
												<form:input type="hidden" path="o_id" value="${o_id}" />
												<form:input type="hidden" path="prod_id" value="${item.id}" />			         					    
												<div class="product-size">
													<span>Size:</span>
													<form:select type="text" path="size" multiple="false" class="form-control"  required="true" >							                           
							                            <c:forEach items="${size}" var="item">
							                            <option value="${item}" > ${item}</option>
							                            </c:forEach>	                                                          
						                            </form:select> 
												</div>
												
												<div class="product-size">
													<span>Color:</span>
													<form:select type="text" path="color" multiple="false" class="form-control"  required="true" >						                            
						                            <c:forEach items="${col}" var="item">
						                            <option value="${item}" > ${item}</option>
						                            </c:forEach>	                                                          
					                                </form:select> 
												</div>
												
												
												<div class="product-quantity">
													<span>Quantity:</span>
													<div class="product-quantity-slider">
													 <!-- <input id="product-quantity" type="text" value="1" name="product-quantity"/> -->
													 <form:input id="qty" path="qty" value="1" class="form-control" type="number" />													 	
													</div>
												</div>
												
												<button id="btn" class="btn btn-main mt-20">Add To Cart</button>
												<a href="shop" class="btn btn-main mt-20">Continue Shopping</a>
												</form:form>
											</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="tabCommon mt-20">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#details" aria-expanded="true">Details</a></li>
						<li class=""><a data-toggle="tab" href="#reviews" aria-expanded="false">Reviews (3)</a></li>
					</ul>
					<div class="tab-content patternbg">
						<div id="details" class="tab-pane fade active in">
							<h4>Product Description</h4>
								<p>${item.des}</p></div>
						<div id="reviews" class="tab-pane fade">
							<div class="post-comments">
						    	<ul class="media-list comments-list m-bot-50 clearlist">
								    
								    <!-- Comment Item start-->
								    <li class="media">

								        <a class="pull-left" href="#">
								            <img class="media-object comment-avatar" src="images/blog/avater-1.jpg" alt="" width="50" height="50">
								        </a>

								        <div class="media-body">

								            <div class="comment-info">
								                <div class="comment-author">
								                    <a href="#">Jonathon Andrew</a>
								                </div>
								                <time datetime="2013-04-06T13:53">July 02, 2015, at 11:34</time>
								                <a class="comment-button" href="#"><i class="tf-ion-chatbubbles"></i>Reply</a>
								            </div>

								            <p>
								                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at magna ut ante eleifend eleifend.
								            </p>

								        </div>

								    </li>
							</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="products related-products section">
	<div class="container">
		<div class="row">
			<div class="title text-center">
				<h2>Related Products</h2>
			</div>
		</div>
		<div class="row">
			<c:set var="count" value="0"/>
            <c:forEach var="item" items="${list}">
		    <c:set var="count" value="${count+1}"/>		
			<div class="col-md-4">
				<div class="product-item">
					<div class="product-thumb">
						<span class="bage">Sale</span>
						<img class="img-responsive" src="static/img/products/${item.id}/${item.img}" alt="product-img" />
						<div class="preview-meta">
							<ul>								
								<li>
			                        <a href="#" ><i class="tf-ion-ios-heart"></i></a>
								</li>
								<li>
									<a href="productdetails?id=${item.id}"><i class="tf-ion-ios-cart-outline"></i></a>
								</li>
							</ul>
                      	</div>
					</div>
					<div class="product-content">
						<h4><a href="productdetails?id=${item.id}">${item.name}</a></h4>
						<p class="price">$<fmt:formatNumber value=" ${item.price}" 
				       maxFractionDigits="2" minFractionDigits="2"/></p>
					</div>
				</div>
			</div>
					
				</c:forEach>
				</div>	
	</div>
</section>


<jsp:include page="footer.jsp"/>
    


  </body>
  </html>