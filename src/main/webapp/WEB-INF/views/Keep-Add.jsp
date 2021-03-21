<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Keep</title>
</head>
<body>

	<%@ include file="home.jsp"%>

	<br>

	<div class="container">
		<h1>Please fill your Note Details</h1>
		<br>
		<form action="processAddNote" method="POST">
			<c:if test="${not empty successMessage}">
				<div class="successMessage">${successMessage}</div>
			</c:if>

			<br>
			<div class="form-group">
				<label>Title</label> <input required type="text"
					class="form-control" placeholder="Enter Title" name="title">
			</div>
			<div class="form-group">
				<label>Description</label>
				<textarea required class="form-control" style="height: 300px;"
					placeholder="Enter content" name="description"></textarea>
			</div>

			<div class="text-center">
				<button type="submit" class="btn btn-primary">Submit</button>
			</div>
			<%
        request.getSession().removeAttribute("successMessage");
%>
		</form>
	</div>
</body>
</html>