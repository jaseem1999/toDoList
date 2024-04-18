<%@page import="com.doit.dao.TaskDAO"%>
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
Integer tid = Integer.parseInt(request.getParameter("id"));

int i = TaskDAO.completedTask(tid); // Change the method name to match your DAO method name

// Output the result if needed
out.println("Rows updated: " + i);
%>
</body>
</html>