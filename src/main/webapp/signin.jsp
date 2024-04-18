<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign in</title>
<link href="fontawesome-free-6.5.1-web/css/fontawesome.css" rel="stylesheet" />
<link href="fontawesome-free-6.5.1-web/css/brands.css" rel="stylesheet" />
<link href="fontawesome-free-6.5.1-web/css/solid.css" rel="stylesheet" />
<link href="fontawesome-free-6.5.1-web/css/custom-icons.css" rel="stylesheet" />
<link href="fontawesome-free-6.5.1-web/css/custom-icons.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style type="text/css">
	.login{
		color: green;
	}
	.login:hover {
		color: #20c997;
	}
	.body-container{
		margin-top: 50px;
	}
	
</style>
</head>
<body>
<nav class="navbar bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="img/toDoLogo.png" alt="Logo" width="50" height="40" class="d-inline-block align-text-top">
    </a>
     <ul class="nav justify-content-end">
	  	<li class="nav-item">
	  		<a href=""  class="nav-link login"><i class="fa-regular fa-user"></i> Login</a>
	  	</li>
	  
	  </ul>
  </div>
</nav>

<div class="container body-container">
		<form action="signup" method="post" enctype="multipart/form-data" > <!-- Replace submit-form-action with actual form submission URL -->
            <div class="input-group mb-3">
			    <span class="input-group-text"><i class="fa fa-envelope" aria-hidden="true"></i></span>
			    <input type="email" class="form-control" id="email" name="email" placeholder="Email address" aria-describedby="emailHelp">
			</div>
			<div id="emailHelp" class="form-text" style="color: white;">We'll never share your email with anyone else.</div>
			
			<div class="input-group mb-3">
			    <span class="input-group-text"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
			    <input type="password" class="form-control" id="pass" name="pass" placeholder="Enter Password" aria-describedby="passwordHelp">
			</div>

            <div class="form-group">
			    <label for="phone">Phone:</label>
			    <div class="input-group mb-3">
			        <span class="input-group-text"><i class="fa fa-phone" aria-hidden="true"></i></span>
			        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone number" aria-describedby="phoneHelp">
			    </div>
			</div>
			<div id="phoneHelp" class="form-text" style="color: white;">Enter your phone number.</div>

            <div class="form-group">
                <label for="profileImage">Profile Image:</label>
                <input type="file" class="form-control-file" id="profileImage" name="profileImage">
            </div>
            
            
            <button type="submit" class="btn btn-primary">Sign in</button>
        </form>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</body>
</html>