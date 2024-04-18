<%@page import="java.util.Iterator"%>
<%@page import="com.doit.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.doit.dao.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String email = request.getParameter("email");
String pass = request.getParameter("pass");
boolean isLoggedIn = LoginDAO.userLogin(email, pass);
if(isLoggedIn){
    List<UserDTO> user = LoginDAO.getAllUserDetails(email, pass);
    if(user != null && !user.isEmpty()) {
        UserDTO userDetails = user.get(0);
        session.setAttribute("uid", userDetails.getUid());
        session.setAttribute("userEmail", userDetails.getEmail());
        session.setAttribute("userPass", userDetails.getPass());
        session.setAttribute("userPhone", userDetails.getPhone());
        session.setAttribute("userImage", userDetails.getProfileImage()); // Assuming profileImage is Blob or byte[]
    }
    response.sendRedirect("index.jsp");
} else {
    response.sendRedirect("index.jsp?message=LoginFailed");
}
%>
</body>
</html>