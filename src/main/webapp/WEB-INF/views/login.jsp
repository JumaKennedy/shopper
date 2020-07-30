


<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js"> <!--<![endif]-->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="description" content="Aviato E-Commerce Template">
  
  <meta name="author" content="#">

  <title>Login</title>

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
          
          <h2 class="text-center">Login </h2>
          <form action="login" method="post"  class="text-left clearfix" >
          <p><span class="text-success"> ${msg}  ${logout} 
          </span>
          
          <span class="text-danger">${error} ${expired}</span>          
          </p>
            <div class="form-group">
              <input type="email" name="email" class="form-control"  placeholder="Email">
            </div>
            <div class="form-group">
              <input type="password" name="password" class="form-control" placeholder="Password">
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-main text-center" >Login</button>
            </div>
          </form>
          <p class="mt-20">New in this site ?<a href="register"> Create New Account</a></p>
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