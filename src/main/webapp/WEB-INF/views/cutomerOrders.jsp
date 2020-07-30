<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

  <title>Members</title>

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
					<h1 class="page-name">Orders</h1>
					<ol class="breadcrumb">
						<li><a href="index">Home</a></li>
						<li class="active">Orders</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="user-dashboard page-wrapper">
  <div class="container">
    <div class="row">
    
      <div class="col-md-12">
        <div class="dashboard-wrapper user-dashboard">
        <h3>${users.size()} 
		 </h3>
		 
         <c:if test="${not empty orderlist}">	
						<table class="table">
							<thead>
								<tr>
									<th>Order ID</th>
									<th>Customer</th>
									<th>Date</th>
									<th>Items</th>
									<th>Total Price</th>
									<th>Status</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${orderlist}">
								<tr>
									<td> 
							        # ${item.id}							        
							        </td>
									<th>${item.full_name}</th>
									<td><fmt:formatDate type = "date" value = "${item.createdon}" /></td>
									<td>
									    ${item.getCart().stream().map(a -> a.qty).sum()}
									</td>
									<td>$ ${item.getCart().stream().map(a -> a.amount).sum()}</td>
									<td><span class="label label-primary">${item.status}</span></td>
									<td>
									<a href="#product-modal${item.id}" class="btn btn-default"data-toggle="modal" data-target="#product-modal${item.id}">
										View <i class="tf-ion-ios-search-strong"></i>
									</a>
									<sec:authorize access="hasAnyAuthority('ADMIN','DBA')">
									<a href="deleteorder?id=${item.id}" onclick="confirmed(); return false;" title="Delete  " class="btn btn-default"> <i class="tf-ion-close"></i></a>
									</sec:authorize>
									<div class="modal product-modal fade" id="product-modal${item.id}">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<i class="tf-ion-close"></i>
									</button>
								  	<div class="modal-dialog " role="document">
								    	<div class="modal-content">
									      	<div class="modal-body">
									        	<div class="row">									        	
									        	<h3 class="text-center text-success">
									        	${item.full_name} <br>${item.street} ${item.city} ${item.zip}
									        	
									        	</h3>
									        	<hr>
									        	 <div class="row mt-20">
									        <table class="table">
							                  <thead>
							                    <tr>
							                      <th class="">Item Name</th>
							                      <th class="">Qty/Price</th>
							                      <th class="">Amount</th>
							                      
							                    </tr>
							                  </thead>
							                  <tbody>
							                   <c:set var="count" value="0"/>
							                    <c:forEach var="item" items="${item.getCart()}">
											    <c:set var="count" value="${count+1}"/>
							                    <tr class="">
							                      <td class="">
							                        <div class="product-info">
							                          <img width="80" src="static/img/products/${item.getProduct().id}/${item.getProduct().img}" alt="" />
							                          <a href="#">${item.getProduct().name} </a>
							                        </div>
							                      </td>
							                      <td class="">
							                      <p class="price">${item.qty} x $<fmt:formatNumber value=" ${item.getProduct().price}" 
											       maxFractionDigits="2" minFractionDigits="2"/>
							                      
							                      </p>
							                      
							                      </td>
							                      <td>
							                      $<fmt:formatNumber value="${item.amount}" 
											       maxFractionDigits="2" minFractionDigits="2"/>
											       </td>
							                      
							                    </tr>
							                    
							                    </c:forEach>
							                  </tbody>
							                </table>
							                <p>${item.email}</p>
												 </div>
									        	</div>
									        </div>
								    	</div>
								  	</div>
								</div><!-- /.modal -->
									
									</td>
								</tr>
							</c:forEach>	
								
							</tbody>
						</table>
				
				</c:if>
				</div>
			</div>
		</div>
	</div>
</section>



<jsp:include page="footer.jsp"/>

   
    <script>
	    function confirmed(){
            if (confirm('You are about to delete this order, Do you want to proceed?')) {
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
