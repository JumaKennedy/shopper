
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- Main Menu Section -->
<section class="menu">
	<nav class="navbar navigation">
	    <div class="container">
	      <div class="navbar-header">
	      	<h2 class="menu-title">Main Menu</h2>
	        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	          <span class="sr-only">Toggle navigation</span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	          <span class="icon-bar"></span>
	        </button>

	      </div><!-- / .navbar-header -->

	      <!-- Navbar Links -->
	      <div id="navbar" class="navbar-collapse collapse text-center">
	      <form id="logoutForm" method="POST" action="logout" class="d-none">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		  </form>
	        <ul class="nav navbar-nav">

	          <!-- Home -->
	          <li class="dropdown ">
	            <a href="index">Home</a>
	          </li><!-- / Home -->

			 <li class="dropdown dropdown-slide">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350" role="button" 
	            aria-haspopup="true" aria-expanded="false">Shop <span class="tf-ion-ios-arrow-down"></span></a>
	            <ul class="dropdown-menu">
				<li class="dropdown-header">Store Shopping</li>
				<li role="separator" class="divider"></li>
				<li><a href="shop">Shop</a></li>
				<c:if test="${not empty itemlist}">
				<li><a href="cart"> Cart </a></li>	
				</c:if>
	            </ul>
	          </li>
	          

	          <!-- Pages -->
	          <li class="dropdown full-width dropdown-slide">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350" role="button"
	             aria-haspopup="true" aria-expanded="false">Company<span class="tf-ion-ios-arrow-down"></span></a>
	            <div class="dropdown-menu">
	              	<div class="row">

		                <!-- Introduction -->
		                <div class="col-sm-3 col-xs-12">
		                	<ul>
								<li class="dropdown-header">Info</li>
								<li role="separator" class="divider"></li>
								<li><a href="contact"> Contact </a></li>
								<li><a href="about">About Us</a></li>
								<li><a href="services">Services</a></li>								
		                	</ul>
		                </div>
						<sec:authorize access="isAuthenticated()">
		                <!-- User Interface -->
		                <div class="col-sm-3 col-xs-12">
		                	<ul>
								<li class="dropdown-header">Dashboard</li>
								<li role="separator" class="divider"></li>
								<li><a href="profile">My Profile </a></li>
								<sec:authorize access="hasAnyAuthority('ADMIN','DBA')">	
								<li><a href="cutomerOrders">Orders</a></li>
								</sec:authorize>
								<li><a href="myorders">My Orders</a></li>
								
		                	</ul>
		                </div>
		                </sec:authorize>
		                
		                <!-- Utility -->
		                <div class="col-sm-3 col-xs-12">
		                	<ul>
								<li class="dropdown-header">Members</li>
								<li role="separator" class="divider"></li>
								<li><a href="users">Club Members </a></li>
								<sec:authorize access="!isAuthenticated()">
								<li><a href="login">Login </a></li>
								<li><a href="register">Register </a></li>
								</sec:authorize>
				  			    <sec:authorize access="isAuthenticated()">								
								<a id="logout_link" href="logout"><sec:authentication property="principal.username" />  | Logout</a>
								</sec:authorize>
		                	</ul>
		                </div>

		                <!-- Mega Menu -->
		                <div class="col-sm-3 col-xs-12">
		                	<a href="shop">
			                	<img class="img-responsive" src="static/images/shop/header-img.jpg" alt="menu image" />
		                	</a>
		                </div>
	              	</div><!-- / .row -->
	            </div><!-- / .dropdown-menu -->
	          </li><!-- / Pages -->
			
			  <sec:authorize access="!isAuthenticated()">
	          <li><a href="login">Login </a></li>
			  <li><a href="register">Register </a></li>
	          </sec:authorize>
	          
	          <sec:authorize access="isAuthenticated()">   
	          <li><a href="profile">My Profile </a></li>       
			  <li><a onclick="document.forms['logoutForm'].submit()">  <i class="ti-power-off text-white"></i> Logout</a>
			  </li>
			  </sec:authorize>							
			  <li class="dropdown cart-nav dropdown-slide">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">
	            <c:if test="${not empty itemlist}">
				<i class="tf-ion-android-cart fa-2x" value="${itemlist.size()}"></i>
				</c:if>
				<c:if test="${empty itemlist}">
				<i class="tf-ion-android-cart fa-2x" value="0"></i>
				</c:if>
				
				<c:if test="${not empty itemlist}">
	            <div class="dropdown-menu cart-dropdown">
	            	<!-- Cart Item -->
	            	<c:if test="${not empty itemlist}">  
	            	
	            	<c:forEach var="item" items="${itemlist}">
	            	<div class="media">
	            		<a class="pull-left" href="#">
	            			<img  class="media-object" src="static/img/products/${item.getProduct().id}/${item.getProduct().img}" alt="image" />
	            		</a>
	            		<div class="media-body">
	            			<h4 class="media-heading"><a href="">${item.getProduct().name}</a></h4>
	            			<div class="cart-price">
                              <span>${item.qty} x $<fmt:formatNumber value=" ${item.getProduct().price}" 
						       maxFractionDigits="2" minFractionDigits="2"/>
						       </span>
                            </div>
                            <h5><strong>$<fmt:formatNumber value="${item.getProduct().price*item.qty}" 
						       maxFractionDigits="2" minFractionDigits="2"/>
						       </strong></h5>
	            		</div>
                        <a href="deleteItem?id=${item.id}" class="remove"><i class="tf-ion-close"></i></a>
	            	</div><!-- / Cart Item -->
	            	</c:forEach>
	            	<!-- Cart Item -->
	            	</c:if>
	            	
	            	<div class="cart-summary">
                        <span>Total</span>
                        <span class="total-price">$<fmt:formatNumber value="${itemlist.stream().map(a -> a.getProduct().price*a.qty).sum()}" 
				       maxFractionDigits="2" minFractionDigits="2"/>
				       </span>
                    </div>
                    <ul class="text-center cart-buttons">
                    	<li><a href="cart" class="btn btn-danger"><b>View Cart</b></a></li>
                    	<sec:authorize access="!isAuthenticated()">
				          <li><a href="checkout" class="btn btn-small btn-solid-border">Checkout</a></li>
                    	</sec:authorize>
                    	<sec:authorize access="isAuthenticated()">
						  <li><a href="checkingout" class="btn btn-small btn-solid-border">Checkout</a></li>
                    	</sec:authorize>
                    </ul>
                </div>
                </c:if>

	          </li><!-- / Cart -->

	          <!-- Search -->
	          <!-- <li class="dropdown search dropdown-slide">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i class="tf-ion-ios-search-strong"></i> </a>
	            <ul class="dropdown-menu search-dropdown">
	              <li><form action="post"><input type="search" class="form-control" placeholder="Search..."></form></li>
	            </ul>
	          </li> --><!-- / Search -->
	          	
	         </ul><!-- / .nav .navbar-nav -->

	      	</div><!--/.navbar-collapse -->
	    </div><!-- / .container -->
	</nav>
</section>