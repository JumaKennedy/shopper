<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

  <title>Shop</title>

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
					<h1 class="page-name">Shop</h1>
					<ol class="breadcrumb">
						<li><a href="index">Home</a></li>
						<li class="active">shop</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="products section">
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<div class="widget">
					<h4 class="widget-title">Short By</h4>
					<form method="post" action="#">
                        <select class="form-control">
                            <option>Man</option>
                            <option>Women</option>
                            <option>Accessories</option>
                            <option>Shoes</option>
                        </select>
                    </form>
	            </div>
				<div class="widget product-category">
					<h4 class="widget-title">Categories</h4>
					<div class="panel-group commonAccordion" id="accordion" role="tablist" aria-multiselectable="true">
					  	<div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingOne">
						      	<h4 class="panel-title">
						        	<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          	Shoes
						        	</a>
						      	</h4>
						    </div>
					    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body">
								<ul>
									<li><a href="">Brand & Twist</a></li>
									<li><a href="">Shoe Color</a></li>
									<li><a href="">Shoe Color</a></li>
								</ul>
							</div>
					    </div>
					  </div>
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">
					        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					         	Duty Wear
					        </a>
					      </h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					    	<div class="panel-body">
					     		<ul>
									<li><a href="">Brand & Twist</a></li>
									<li><a href="">Shoe Color</a></li>
									<li><a href="">Shoe Color</a></li>
								</ul>
					    	</div>
					    </div>
					  </div>
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingThree">
					      <h4 class="panel-title">
					        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					          	WorkOut Shoes
					        </a>
					      </h4>
					    </div>
					    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					    	<div class="panel-body">
					      		<ul>
									<li><a href="">Brand & Twist</a></li>
									<li><a href="">Shoe Color</a></li>
									<li><a href="">Gladian Shoes</a></li>
									<li><a href="">Swis Shoes</a></li>
								</ul>
					    	</div>
					    </div>
					  </div>
					</div>
					
				</div>
			</div>
			<div class="col-md-9">
			<h3>${msg}</h3>
		    <div class="row">
			<c:set var="count" value="0"/>
            <c:forEach var="item" items="${list}">
		    <div class="col-md-4">
				<div class="product-item">
					<div class="product-thumb">
						<span class="bage">Sale</span>
						
						<c:if test="${not empty item.img}">
						<img class="img-responsive" src="static/img/products/${item.id}/${item.img}" alt="product-img" />
						
						</c:if>
						<div class="preview-meta">
							<ul>
								<li>
									<span  data-toggle="modal" data-target="#product-modal${item.id}">
										<i class="tf-ion-ios-search-strong"></i>
									</span>
								</li>
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
						<h4><a href="product-single.html">${item.name}</a></h4>
						<p class="price">$<fmt:formatNumber value=" ${item.price}" 
				       maxFractionDigits="2" minFractionDigits="2"/></p>
					</div>
				</div>
			</div>
			
		        
				</c:forEach>
				</div>				
			</div>
		
		</div>
	</div>
</section>

  				<c:forEach var="modal" items="${list}">
  				   <div class="modal product-modal fade" id="product-modal${modal.id}">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<i class="tf-ion-close"></i>
						</button>
					  	<div class="modal-dialog " role="document">
					    	<div class="modal-content">
						      	<div class="modal-body">
						        	<div class="row">
						        		
						        	 <div class="row mt-20">
										<div class="col-md-5">
											<div class="single-product-slider">
												<div id='carousel-custom' class='carousel slide' data-ride='carousel'>
													<div class='carousel-outer'>
														<!-- me art lab slider -->
														<div class='carousel-inner '>
														    <div class='item active'>
														    <a href="productdetails?id=${modal.id}">
																<img src='static/img/products/${modal.id}/${modal.img}' alt='' data-zoom-image="static/img/products/${modal.id}/${modal.img}" />
															</a>
															</div>
															<c:forEach var="img" items="${modal.getIfiles()}">
															<div class='item'>
															<a href="productdetails?id=${modal.id}">
																<img src='static/img/products/${modal.id}/${img.image}' alt='' data-zoom-image="static/img/products/${modal.id}/${img.image}" />
															</a>
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
													      <c:set var="images" value="${modal.getIfiles()}"/>
													        <c:set var="no" value="0"/>
														    <c:forEach var="img" items="${images}">
														    <c:set var="no" value="${no+1}"/> 
														    <li data-target='#carousel-custom' data-slide-to='${no}' class=''>
														    <a href="productdetails?id=${modal.id}">
															<img src='static/img/products/${modal.id}/${img.image}' alt='' />
														    </a>
														    </li>
														    </c:forEach>
														
													</ol>
												</div>
											</div>
										</div>
										<div class="col-md-7">
											<div class="single-product-details">
												<h2>${modal.name}</h2>
												<p class="product-price">$<fmt:formatNumber value="${modal.price}" 
				       							 maxFractionDigits="2" minFractionDigits="2"/></p>
												
												<p>${modal.des}</p>
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
												<form:form action="addtobag" modelAttribute="shoppingcart" method="post" role="form" >				         					    
												<form:input type="hidden" path="prod_id" value="${modal.id}" />
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
													 <form:input type="number" id="qty" path="qty" class="form-control" value="1"/>													 	
													</div>
												</div>
												
												<button id="btn" class="btn btn-main mt-20">Add To Cart</button>
												</form:form>
											</div>
										</div>
									</div>
						        		
						        		
						        	</div>
						        </div>
					    	</div>
					  	</div>
					</div>
				</c:forEach>
<jsp:include page="footer.jsp"/>

   
    <script>
	    function confirmed(){
            if (confirm('You are about to delete, Do you want to proceed?')) {
                  document.getElementById("del").submit();
                  return true;
	            } else {
	               return false;
	            }
	         }
        	    
	    $("#searchnow").keyup(function () {
	        var value = this.value.toLowerCase().trim();

	        $("table tr").each(function (index) {
	            if (!index) return;
	            $(this).find("td").each(function () {
	                var id = $(this).text().toLowerCase().trim();
	                var not_found = (id.indexOf(value) == -1);
	                $(this).closest('tr').toggle(!not_found);
	                return not_found;
	            });
	        });
	    });


	   
	    </script>
	    
	    

  </body>
  </html>
