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
int uid = Integer.parseInt(request.getParameter("uid"));
String task = request.getParameter("task");
String date = request.getParameter("date");
String time = request.getParameter("time");

int i = TaskDAO.addTask(uid, task, date, time);
if(i > 0){
	response.sendRedirect("index.jsp?message=successAdd");
}else{
	response.sendRedirect("index.jsp?message=FailedAdd");
}
%>

</body>
</html>