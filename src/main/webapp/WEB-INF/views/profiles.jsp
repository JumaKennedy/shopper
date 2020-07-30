<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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

  <title>Profile</title>

 <!-- Mobile Specific Meta-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="static/static/images/favicon.png" />
  
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

<!-- Main Menu Section -->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Dashboard</h1>
					<ol class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li class="active">my account</li>
					</ol>
					
				</div>
			</div>
		</div>
	</div>
</section>
<section class="user-dashboard page-wrapper">
  <div class="container">
    <div class="row">
      <div class="col-sm-3 col-xs-12">
	          
		     <c:if test="${not empty user_account.image}">
			 <img class="img-responsive" src="static/img/users/${user_account.id}/profile/${user_account.image}" alt="menu image">
			 </c:if>
			 <h5 class="text-success"> ${user_account.fname} ${user_account.lname}
			  <a href="#" data-toggle="modal" data-target="#add-images" >
			 <c:choose>
			 <c:when test="${not empty user_account.image}">
			 Edit <i class="tf-pencil2"></i>
			 </c:when>
			 <c:otherwise>
			 Add <i class="tf-pencil2"></i>
			 </c:otherwise>
			 </c:choose>			 
		     </a>			  
			  </h5>	                
      				
	  </div>
      <div class="col-md-9">
      ${msg}
 		<div class="tabCommon mt-20">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#info" aria-expanded="false">My Contact Info</a></li>
						<li><a data-toggle="tab" href="#details" aria-expanded="true">Update Profile</a></li>						
						<sec:authorize access="hasAnyAuthority('ADMIN','DBA')">			            
			            <li><a href="#products" data-toggle="tab">Products</a></li>
			            </sec:authorize> 
			            <li><a href="#cards" data-toggle="tab">Add Credit Card</a></li>	
			            <li><a href="myorders" >My Orders</a></li>		
			                       
					</ul>
					
		 </div>
        
		<div class="tab-content patternbg">
			<div id="details" class="tab-pane fade">
			      <div class="container">
				    <div class="row">
				      <div class="col-md-6">
				        <div class="block text-center">				          
				          <form:form action="updatecontact" modelAttribute="address" method="post" class="text-left clearfix" >
				            <form:input class="form-control"  type="hidden" path="id" value="${user_account.id}"/>
		                    <div class="form-group">
				             <form:input class="form-control"  type="hidden" path="email" value="${user_account.email}"/>
				            </div>
				            <div class="form-group">
				              <form:input class="form-control"  path="phone" value="${user_account.getAddress().phone}" placeholder="Enter phone" />				    
				            </div>
				            <div class="form-group">
				            <form:input class="form-control"  path="street" value="${user_account.getAddress().street}" placeholder="Enter Address"/>
						   	</div>
						   	<div class="form-group">
						   	<form:input class="form-control"  path="city" value="${user_account.getAddress().city}" placeholder="Enter City" />				   	
						    </div>
						    <div class="form-group">
						   	<form:input class="form-control"  path="zip" value="${user_account.getAddress().zip}" placeholder="Enter ZIP" />				   	
						    </div>
						   <div class="form-group">
						    <form:select class="form-control" path="state" id="state" required="true">
		                    <c:choose>
		                      <c:when test="${empty user_account.getAddress().state}">
		                      <option value="">Select State</option>
		                      </c:when>
		                      <c:otherwise>
		                      <option value="${user_account.getAddress().state}">
		                      ${user_account.getAddress().state}
		                      </option> 
		                      </c:otherwise>
		                      </c:choose>                                 
							  <c:forEach items="${states}" var="state">
							  <option value="${state}">${state.id}</option>
							  </c:forEach>
							</form:select>
				            </div>
				            <div class="text-left">
				              <button type="submit" class="btn btn-main btn-small btn-round">Submit</button>
				            </div>
				          </form:form>
				          
				        </div>
				      </div>
				    </div>
				  </div>

               </div>
               <div id="info" class="tab-pane fade active in">
               <div class="dashboard-wrapper dashboard-user-profile">
		          <div class="media">
		            
		            <div class="media-body">
		              <ul class="user-profile-list">
		                <li><span>Full Name:</span><i class="tf-ion-android-person"></i> ${user_account.fname} ${user_account.lname}</li>
		                <li><span>Address:</span><i class="tf-ion-ios-home"></i> ${user_account.getAddress().street} 
		                   ${user_account.getAddress().city}
		                  </li>
		                <li><span>Email:</span><i class="tf-ion-android-mail"></i> ${user_account.email}</li>
		                <li><span>
			                <a href="#" data-toggle="modal" data-target="#addtel" 
						 class="btn btn-default">Phone: Add </a>
						 </span>
		                <c:forEach var="fone" items="${user_account.getPhoneBook()}">
				    		<i class="tf-ion-android-phone-portrait"></i>
				    		${fone.tel} 
				    	 </c:forEach>
		                </li>
		                <li><label> 
		                <a href="#" data-toggle="modal" data-target="#addcmt" 
	                        class="btn btn-default"><i class="tf-ion-chatbubbles"></i> Add Comment</a>
	                    </label><br>
	                        ${user_account.comment}
	                     </li>
		                
		              </ul>
		            </div>
		          </div>
		        </div>
              
               </div>
              
               
               <div id="products" class="tab-pane fade">
                      <p> <a  href="#" data-toggle="modal" data-target="#add-item" 
                        class="btn btn-default">Add Product<i class="tf-plus" aria-hidden="true"></i>
                        </a>
                       </p> 
                <c:if test="${not empty user_account.getProducts()}">
                    <table class="table ">
					 <tr class="text-success">
					 <th>#</th>
					 <th>Product</th>
					 <th>Price</th>
					 <th>Type/Color</th>
					 <th>Action</th>
					 </tr>
					 <tbody>
                    <c:set var="count" value="0"/>
                    <c:forEach var="pi" items="${user_account.getProducts()}">
				    <c:set var="count" value="${count+1}"/>
				     <tr>
				       <td> ${count}.</td>
				       <td class="">
                        <div class="product-info">
                        <a href="productdetails?id=${pi.id}">
                          <img width="80" src="static/img/products/${pi.id}/${pi.img}" alt="" />
                          ${pi.name} </a>
                        </div>
                        
                      </td>
				       <td>
				        $ ${pi.price}
				       </td>
				       <td>
				       ${pi.color} ${pi.type}
				       </td>
				       <td>
				       <a href="deleteproduct?id=${pi.id}" onclick="confirmed(); return false;" class="btn btn-default"> <i class="tf-ion-close"></i></a>
				       
				       <a  href="#" data-toggle="modal" data-target="#show${pi.id}" 
                        class="btn btn-default"><i class="tf-pencil2" aria-hidden="true"></i>
                        </a>
                        
                       	<div class="modal fade" id="show${pi.id}">
					    <div class="modal-dialog modal-md">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 <h4>Edit Product</h4>
			    		  
			    		  <form:form action="editproduct" modelAttribute="product" 
			                    method="post" role="form" enctype="multipart/form-data" > 
			                    <p>Add Product</p>             
			                    <div class="form-group">
			                    <form:input type="hidden" path="id" value="${pi.id}"/>                    
			                    <form:input type="hidden" path="users_id" value="${user_account.id}"/>
			                    <form:input type="hidden" path="img" value="${pi.img}"/>
			                    <form:input path="name" placeholder="product name" value="${pi.name}" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="type" value="${pi.type}" placeholder="product type" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="price" value="${pi.price}" placeholder="product price" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="color" value="${pi.color}" placeholder="product color" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:textarea path="des" rows="6"  placeholder="Description" class="form-control"  required="required"/>
			                   </div>
			                    <form:input path="file" type="file" class="form-control" />					                             
								<form:input path="file" type="file" class="form-control" />
								<form:input path="file" type="file" class="form-control" /> 
			                    <form:input type="hidden" path="email" value="${loggedInuser}" /><br>
			                    <button class="btn btn-main btn-icon" type="submit">Add </button>
					           
			                    </form:form>
	                     </div>
					    </div>	
				      </div>
					  </div>
                        
                        
                      </td>			              
				     </tr>
				    </c:forEach>
				    </tbody> 
				    </table>
				    </c:if>
               
               </div>
               
               <div id="cards" class="tab-pane fade">
                <p class="text-left">
                    <a href="#" data-toggle="modal" data-target="#addnew" class="btn btn-default">Add New Card</a>
                    </p>
                    <c:if test="${not empty user_account.getPaymentMethod()}">
                    <table class="table ">
					 <tr class="text-success">
					 <th>#</th>
					 <th>Card Number</th>
					 <th>Expiry</th>
					 <th>Type</th>
					 </tr>
					 <tbody>
                    <c:set var="count" value="0"/>
                    <c:forEach var="cards" items="${user_account.getPaymentMethod()}">
				    <c:set var="count" value="${count+1}"/>
				     <tr>
				       <td> ${count}.</td>
				       <td> ${cards.cardno}</td>
				       <td>
				        ${cards.expiry}
				        </td>
				       <td> Visa
				       <a href="deletecard?id=${cards.id}" onclick="confirmed(); return false;" class="btn btn-default"> <i class="tf-ion-close"></i></a>
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
  </div>
</section>
	

  <jsp:include page="footer.jsp"/>
  
                 <div class="modal fade" id="add-images">
					    <div class="modal-dialog modal-sm">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">	
			    		 <form method="POST" action="addimages" enctype="multipart/form-data">   
			    		 <h4>Add Image</h4>               
					     <img id="output_image" class="col-md-8"/>
					     <div class="control-group">
		                    <div class="controls">
		                     <input type="file" name="file" class="form-control" onchange="preview_image(event)">					                             
							 <input type="hidden" name="id" value="${user_account.id}">					
		                    </div>
		                  </div>                  
		                  <div class="control-group"><br>
		                    <div class="controls">
		                      <button type="submit" class="btn btn-default" >Upload</button>
		                      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                    </div>                    
		                  </div>        
					      </form>
		                  </div>
					  </div>	        
				   
				    </div>
					</div> 
					
					<div class="modal fade" id="addnew">
					    <div class="modal-dialog modal-sm">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 <h4>Add new Card</h4>
			    		  <form:form action="addcard" modelAttribute="card" 
		                    method="post" role="form" class="contactForm"> 
		                    <div class="form-group">
		                    <form:input type="hidden" path="id" value="${user_account.id}"/>
		                    </div>
		                    <div class="form-group">
		                    <form:input type="number" class="form-control"  path="cardno" placeholder="Card Number" min="14" />
		                    </div>
		                    <div class="form-group">
		                    <form:input type="number" class="form-control"  path="secode" placeholder="Card Security" min="3" />
							</div>
							<div class="form-group">
		                    <form:input type="month" class="form-control"  path="expiry" placeholder="Expiry Date"/>
		                    </div>
		                    <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
				            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                   </form:form>
			    		  
	                     </div>
					    </div>	
				      </div>
					  </div>
  
   
					
					<div class="modal fade" id="addnew">
					    <div class="modal-dialog modal-sm">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 <h4>Add new Card</h4>
			    		  <form:form action="addcard" modelAttribute="card" 
		                    method="post" role="form" class="contactForm"> 
		                    <div class="form-group">
		                    <form:input type="hidden" path="id" value="${user_account.id}"/>
		                    </div>
		                    <div class="form-group">
		                    <form:input type="number" class="form-control"  path="cardno" placeholder="Card Number" min="14" />
		                    </div>
		                    <div class="form-group">
		                    <form:input type="number" class="form-control"  path="secode" placeholder="Card Security" min="3" />
							</div>
							<div class="form-group">
		                    <form:input type="month" class="form-control"  path="expiry" placeholder="Expiry Date"/>
		                    </div>
		                    <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
				            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                   </form:form>
	                     </div>
					    </div>	
				      </div>
					  </div>
					  
					 
					  
					  <div class="modal fade" id="addcmt">
					    <div class="modal-dialog modal-lg">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 
			    		  <form action="addcoment" method="post" role="form" class="contactForm">
			              	<h4>Add Comment</h4>	                
			                  <input type="hidden" name="id" value="${user_account.id}">
			                  <textarea name="comment" rows="5" data-rule="required" value="${user_account.comment}" class="form-control" ></textarea>
			                  <div class="text-left"><br>
			                    <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
			                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					  		
			                  </div>
			                
			            </form>
				         
	                     </div>
					    </div>	        
					 
				      </div>
					  </div>
					  
					  <div class="modal fade" id="addtel">
					    <div class="modal-dialog modal-sm">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 
			    		  <form action="addphone" method="post" role="form" class="contactForm">
			              	<h4>Add Telephone Number</h4>	                
			                  <input type="hidden" name="id" value="${user_account.id}">
			                  <div class="form-group">
			                  <input type="text" name="tel" class="form-control" placeholder="Phone Number">
			                  </div>
			                  <div class="form-group">
			                  <select name="type" class="form-control">
								<option value="Select">Select Type</option>
								<option value="Mobile">Mobile </option>
								<option value="Home">Home</option>
								<option value="Work">Work</option>												  
							 </select>
							 </div>
			                  <div class="text-left">
			                    <button class="btn btn-main btn-small btn-round" type="submit">Add </button>
			                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					  		
			                  </div>
			                
			            </form>
				         
	                     </div>
					    </div>	        
					 
				      </div>
					  </div>
					  
					  
					  <div class="modal fade" id="add-item">
					    <div class="modal-dialog modal-md">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 <h4>Add Product</h4>
			    		<form:form action="saveproduct" modelAttribute="product" 
			                    method="post" role="form" enctype="multipart/form-data" > 
			                    <div class="form-group">
			                    <form:input type="hidden" path="id" />                    
			                    <form:input type="hidden" path="users_id" value="${user_account.id}"/>
			                    <form:input path="name" placeholder="product name" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="type" placeholder="product type" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="price" placeholder="product price" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:input path="color" placeholder="product color" class="form-control"/>
			                    </div>
			                    <div class="form-group">
			                    <form:textarea path="des" rows="6"  placeholder="Description" class="form-control"  required="required"/>
			                    </div>
			                    <form:input path="file" type="file" class="form-control" />					                             
								<form:input path="file" type="file" class="form-control" />
								<form:input path="file" type="file" class="form-control" /> 
			                    <form:input type="hidden" path="email" value="${loggedInuser}" /><br>
			                    <button class="btn btn-main btn-icon" type="submit">Add </button>
					           
			                    </form:form>
	                     </div>
					    </div>	
				      </div>
					  </div>
					  
	<script type="text/javascript">
    function preview_image(event) 
    {
     var reader = new FileReader();
     reader.onload = function()
     {
      var output = document.getElementById('output_image');
      output.classList.add("preview");
      output.src = reader.result;
     }
     reader.readAsDataURL(event.target.files[0]);
    }
    </script>			  
					  
  </body>
  </html>