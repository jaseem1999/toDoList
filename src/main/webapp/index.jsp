<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.doit.dao.TaskDAO"%>
<%@page import="com.doit.dto.ToDoDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Blob"%>
<%@page import="com.doit.dao.ProfileImageDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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
	.signin{
		color: blue;
	}
	.signin:hover {
		color: #0dcaf0;
	}
	.logout{
		color: red;
	}
	.profile-img {
		margin-top: -30px;
		margin-left: -20px;
	    width: 70px; /* Adjust width as needed */
	    height: 70px; /* Adjust height as needed */
	    border-radius: 50%; /* Make it circular if desired */
	    border: 2px solid; 
	}
	.box{
		margin-top: 100px;
		position : relative;
		left : 20%;
		height: auto;
		width: 700px;
		border: 2px solid; 
	}
	.fa-solid{
		margin: 10px;
	}
	.accept:hover {
		background: lime;
	}
	.reject:hover {
		background: repeating-linear-gradient(45deg, black, transparent 100px);
	}
	
	
</style>
<%
Integer uid = (Integer) session.getAttribute("uid");
String email = (String) session.getAttribute("userEmail");
Blob img = (Blob) session.getAttribute("userImage");
String profileImageData = ""; // Initialize profile image data
if (img != null) {
    byte[] byteArray = ProfileImageDAO.getProfileImage(img, response);
    if (byteArray != null) {
        // Convert byte array to Base64 string
        profileImageData = "data:image/jpeg;base64," + java.util.Base64.getEncoder().encodeToString(byteArray);
    }
}

Long number =(Long) session.getAttribute("userPhone");
%>
<title>To Do List</title>
<body>

	<nav class="navbar ">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">
	      <img src="img/toDoLogo.png" alt="Logo" width="50" height="40" class="d-inline-block align-text-top">
	    </a>
	    
	     <ul class="nav justify-content-end">
	     <%if (email == null){ %>
		  	<li class="nav-item">
		  		<a href=""  class="nav-link login" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-regular fa-user"></i> Login</a>
		  	</li>
		  	<li class="nav-item signin">
		  		<a href="signin.jsp"  class="nav-link signin"><i class="fa-regular fa-user"></i> Sign in</a>
		  	</li>
		  <%}else{%>
		  	<li class="nav-item signin">
		  		<a href="logout.jsp"  class="nav-link logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
		  	</li>
		  	
		  <%} %>
		  </ul>
	  </div>
	  
	 
	  
	</nav>

		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel"><i class="fa-regular fa-user" style="height: 50px;"></i> Login</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="userLoginServlet.jsp" method="post">
				  <div class="input-group mb-3">
					    <span class="input-group-text"><i class="fa fa-envelope" aria-hidden="true"></i></span>
					    <input type="email" class="form-control" id="email" name="email" placeholder="Email address" aria-describedby="emailHelp">
					</div>
					<div id="emailHelp" class="form-text" style="color: white;">We'll never share your email with anyone else.</div>
					
					<div class="input-group mb-3">
					    <span class="input-group-text"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
					    <input type="password" class="form-control" id="pass" name="pass" placeholder="Enter Password" aria-describedby="passwordHelp">
					</div>
				  <button type="submit" class="btn btn-primary">Login <i class="fa-solid fa-arrow-right-to-bracket"></i></button>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<div class="container">
		<%if(email != null){ %>
					<div class="card box" >
						<c:if test="${not empty img}">
						    <img src="<%= profileImageData %>" alt="Profile Image" class="profile-img">
						</c:if>
						<div style="margin: 40px;"  id="contentToRefreshTwo">
							<form id="taskForm" action="taskSubmitServlet.jsp" method="post" onsubmit="return validateForm()">
							    <input type="hidden" name="uid" id="uid" value="<%=uid%>">
							    <div class="input-group mb-3">
							        <span class="input-group-text"><i class="fa-solid fa-list-check"></i></span>
							        <input type="text" class="form-control" id="addTask" name="task" aria-describedby="addTask" placeholder="Enter Task">
							        <input type="date" class="form-control" id="date" name="date" aria-describedby="date">
							        <input type="time" class="form-control" id="time" name="time" aria-describedby="time">
							        <button type="submit" class="btn btn-outline-success"><i class="fa-solid fa-plus"></i></button>
							    </div>
							    <span id="error" style="color: red;"></span>
							</form>
							<%
							List<ToDoDTO> tasks = TaskDAO.getAllTaskBasedOnUID(uid);
							for(ToDoDTO task: tasks){
							%>
							<div class="input-group mb-3">
								<%
						    // Java code to determine the color based on task status
						    String textColor = "blue"; // Default color
						    if (task.getStatus() != null) {
						        if (task.getStatus().equals("accept")) {
						            textColor = "green";
						        } else {
						            // Handle other statuses if needed
						        }
						    }
						
						    // Java code to determine the background color based on task date
						    LocalDate taskDate = LocalDate.parse(task.getDate()); // Sample task date
						    LocalDate currentDate = LocalDate.now();
						    String backgroundColor = taskDate.isBefore(currentDate) ? "#ff000054" : "";
						%>
						
						<!-- HTML input element with dynamic style -->
						<input class="form-control" style="color: <%=textColor%>; background: <%=backgroundColor%>"
						       type="text" value="<%=task.getTask()%>" aria-label="readonly input example" readonly>
								
								<span class="input-group-text" style="color: <%
								if(task.getStatus() == null){
									out.print("blue");
								}else if(task.getStatus() != null && task.getStatus().equals("accept")){
									out.print("green");
								}else if(task.getStatus() != null && task.getStatus().equals("reject")){
									out.print("red");
								}else{
									out.print("");
								}
								
								
								    
								  
							%>; background: <%=backgroundColor%>;"><i class="fa-solid fa-calendar-days"></i> <%=task.getDate() %></span>
								<span class="input-group-text" style="color: <%
								if(task.getStatus() == null){
									out.print("blue");
								}else if(task.getStatus() != null && task.getStatus().equals("accept")){
									out.print("green");
								}else if(task.getStatus() != null && task.getStatus().equals("reject")){
									out.print("red");
								}else{
									out.print("blue");
								}

							%>; background: <%=backgroundColor%>"><i class="fa-solid fa-clock" ></i> <%=task.getTime() %></span>
								<span class="input-group-text accept" data-tid="<%=task.getTid()%>"><i class="fa-solid fa-check" style="color: green;"></i></span>
								<span class="input-group-text reject" data-tid="<%=task.getTid()%>" ><i class="fa-solid fa-trash" style="color: red;"></i></span>
								
							</div>
							<%} %>
						</div>
					</div>
		<%}else{ %>
			
		<%} %>
		</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	
<script>

$(document).ready(function() {
    // Function to refresh the content of the specified element
    window.refreshContentTwo = function() {
        $('#contentToRefreshTwo').load(location.href + ' #contentToRefreshTwo', function() {
            // Rebind event handlers after content refresh
            bindEventHandlersTwo();
        });
    }

    // Click event to trigger the content refresh when the button is clicked
    $('#refreshButton').on('click', function() {
        window.refreshContentTwo();
    });

    // Initial binding of event handlers
    bindEventHandlersTwo();

    // Function to bind event handlers
    function bindEventHandlersTwo() {
        // Handle the click event on the "Accept" link
        $(".accept").on("click", function(event) {
            event.preventDefault(); // Prevent the default behavior of the link

            // Get the appointment id from the data-tid attribute
            var appointmentId = $(this).data("tid");

            // Make an AJAX request to the server to handle the acceptance
            $.ajax({
                type: "GET",
                url: "acceptServlet.jsp",
                data: { id: appointmentId },
                
                success: function(response) {
                    // Handle the success response (if needed)
                    console.log(" accepted successfully");
                   
                    // Show the success message
                   

                    // Reload the content within the div with id "contentToRefresh" after acceptance
                    window.refreshContentTwo();
                },
                error: function(xhr, status, error) {
                    // Handle the error response (if needed)
                    console.error("Error accepting Registration: " + error);
                  

                    // You can show an error message if needed
                }
            });
        });

        // Handle the click event on the "Reject" link
        $(".reject").on("click", function(event) {
            event.preventDefault(); // Prevent the default behavior of the link

            // Get the appointment id from the data-tid attribute
            var appointmentId = $(this).data("tid");

            // Make an AJAX request to the server to handle the rejection
            $.ajax({
                type: "GET",
                url: "rejectServlet.jsp",
                data: { id: appointmentId },
                success: function(response) {
                    // Handle the success response (if needed)
                    console.log("rejected successfully");

                   

                    // Reload the content within the div with id "contentToRefresh" after rejection
                    window.refreshContentTwo();
                },
                error: function(xhr, status, error) {
                    // Handle the error response (if needed)
                    console.error("Error rejecting Registration: " + error );
                  
                    // You can show an error message if needed
                }
            });
        });

       
        
    }
});

function validateForm() {
    var task = document.getElementById("addTask").value;
    var date = document.getElementById("date").value;
    var time = document.getElementById("time").value;
    var currentDate = new Date(); // Current date and time

    // Check if task is empty
    if (task.trim() === "") {
        document.getElementById("error").innerHTML = "Task cannot be empty";
        return false; // Prevent form submission
    }

    // Check if date or time is empty
    if (date.trim() === "" || time.trim() === "") {
        document.getElementById("error").innerHTML = "Date and time cannot be empty";
        return false; // Prevent form submission
    }

    // Combine date and time strings and parse to Date object
    var dateTimeString = date + " " + time;
    var dateTime = new Date(dateTimeString);

    // Check if date and time are before current date and time
    if (dateTime < currentDate) {
        document.getElementById("error").innerHTML = "Date and time cannot be before current date and time";
        return false; // Prevent form submission
    }

    // Clear any previous error message
    document.getElementById("error").innerHTML = "";

    return true; // Allow form submission
}


        
</script>
</body>
</html>
