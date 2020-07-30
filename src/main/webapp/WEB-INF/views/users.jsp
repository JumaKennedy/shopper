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
					<h1 class="page-name">Members</h1>
					<ol class="breadcrumb">
						<li><a href="index">Home</a></li>
						<li class="active">Users</li>
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
         <a href="#">${msg} ${success} </a>
		 </h3>
		 
          <div class="table-responsive">
            <table class="table">
					 <tr class="text-success">
					 <th>#</th>
					 <th>
					  <form action="search" method="post">
	                  <input id="searchnow" class="form-control" type="text" name="name" placeholder="Search members">	                 
	     		     </form>
	     		     </th>
					 <th>Contact <i class="icon-map-marker"></i></th>
					 <th>Products </th>
					 <sec:authorize access="hasAnyAuthority('ADMIN','DBA')">	
					 <th>Roles</th>
					 <th>Edit</th>
					 </sec:authorize>
					 </tr>
					 <tbody>
					 <c:forEach var="item" items="${users}" >
					 <tr>
					 <td>${users.indexOf(item)+1}.</td>
					 
					 <td>
					 <c:if test="${not empty item.image}">
					 <img class="d-flex justify-content-center" src="static/img/users/${item.id}/profile/${item.image}" 
						 alt="${item.fname} ${item.lname}" style="width: 50px; height: 45px; border-radius: 50%;">
					 </c:if>
					 <c:if test="${empty item.image}">
					 <p>No Image</p>
					 </c:if>
					 <br>
					 ${item.fname} ${item.lname}
					 <c:if test="${not empty item.comment}">
					 <a href="#" data-toggle="modal" data-target="#cmt${item.id}" 
                     class="tf-ion-chatbubbles"></a>
                     </c:if>
                     <div class="modal fade" id="cmt${item.id}">
					    <div class="modal-dialog modal-md">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		 <h3 class="text-success">
			    		 ${item.fname} ${item.lname} Says
			    		 </h3>
                         <h4>   ${item.comment}</h4>
                         <br>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	                     </div>
	                     
					    </div>	        
					    
				      </div>
					  </div>
                     
					 </td>
					 <td>
					 <c:choose>
					 <c:when test="${not empty item.getAddress()}">
					 <a  href="#" data-toggle="modal" data-target="#adrr${item.id}" 
                     class="btn btn-default">Contact</a>
                     </c:when>
					 <c:otherwise>
					 No Contact
					 </c:otherwise>
					 </c:choose>
					 
					 <div class="modal fade" id="adrr${item.id}">
					    <div class="modal-dialog modal-md">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">
			    		  <div class="text-success">	
			    		  <h4>Contact</h4>			            
				             <i class=" icon-home text-success"> </i>
				             ${item.getAddress().street},
							 ${item.getAddress().city},
							 ${item.getAddress().state}<br>
							 <i class="icon-envelope-alt"></i> ${item.email}<br>
							 <c:forEach var="fone" items="${item.getPhoneBook()}">
				    		 <i class=" icon-phone-sign text-success"> </i>
				    		 <span> ${fone.tel} </span> 
				    	     </c:forEach><br>
					      </div>
				          <br>
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	
				         
	                     </div>
					    </div>	        
					    
				      </div>
					  </div>
					 </td>
					 <td>
					 <c:choose>
					 <c:when test="${not empty item.getProducts()}">
					 <a  href="#" data-toggle="modal" data-target="#show${item.id}" 
                     class="btn btn-default">Product</a>
                     </c:when>
					 <c:otherwise>
					 No Product
					 </c:otherwise>
					 </c:choose>
					 <div class="modal fade" id="show${item.id}">
					    <div class="modal-dialog modal-lg">
						<div class="modal-content">	      
						<!-- Modal body -->
						<div class="modal-body">
			    		<c:choose>
			    		<c:when test="${empty item.getProducts()}">
			    		No Products
			    		</c:when>
			    		<c:otherwise>
			    		 <h4>Products</h4>
			    		 <table class="table ">
					 <tr class="text-success">
					 <th>#</th>
					 <th>Product</th>
					 <th>Price</th>
					 <th>Type/Color</th>
					 </tr>
					 <tbody>
                    <c:set var="count" value="0"/>
                    <c:forEach var="pi" items="${item.getProducts()}">
				    <c:set var="count" value="${count+1}"/>
				     <tr>
				       <td> ${count}.</td>
				       <td> 
				       
						<div class='item'>
						<a href="#">
						<img src='static/img/products/${pi.id}/${pi.img}' alt='' 
						data-zoom-image="static/img/products/${pi.id}/${pi.img}"  style="width: 70px; height: 70px; border-radius: 50%;"/>
						</a>
						</div>
						
						${pi.name}
					    </td>
				       <td>
				        $ ${pi.price}
				       </td>
				       <td>
				       ${pi.color} ${pi.type}
				       </td>				       		              
				     </tr>
				    </c:forEach>
				    </tbody> 
				    </table>
			    	</c:otherwise>
			    	</c:choose>	
			    	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>		    		
	                </div>
					</div>	        
					   
				   </div>
					</div>
                     </td>
					 <sec:authorize access="hasAnyAuthority('ADMIN','DBA')">
					 <td>
	                 <form method="POST" action="editrole" >		    									
							<input type="hidden" name="id" value="${item.id}" />		    	 
							<select onchange="this.form.submit()" name="role" class="form-control">
							<option value="${item.getRoles().stream().findFirst().get().getRole()}">${item.getRoles().stream().findFirst().get().getRole()}</option>
							<option value="USER">USER </option>
							<option value="DBA">DBA</option>
							<option value="ADMIN">ADMIN</option>												  
						 </select>												
					   </form>
	                 </td>
                     <td>
                     <a href="delete?id=${item.id}" onclick="confirmed(); return false;" title="Delete member ${item.fname} ${item.lname}" class="btn btn-default"> <i class="tf-ion-close"></i></a>
                     </td>
					 </sec:authorize>
					 </tr>
					 </c:forEach>
					 </tbody>
					 
					 </table>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>



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
