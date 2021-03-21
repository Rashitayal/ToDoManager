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

<%@ include file="home.jsp" %>

<br>

<div class="container">
<h1>Update your Note Details</h1>
<br>
<form action="processUpdateNote" method = "POST">
<c:if test="${not empty successMessage}">
        <div class="successMessage">${successMessage}</div>
</c:if>        
    
     <br>
     <input type="hidden" name="id" value="${noteObject.id}">
  <div class="form-group">
    <label>Title</label>
    <input required type="text" class="form-control" placeholder="Enter Title" name="title" value="${noteObject.title}">
  </div>
  <div class="form-group">
    <label>Description</label>
    <textarea required class="form-control" style="height: 300px;" placeholder="Enter content" name="description">${noteObject.description}</textarea>
  </div>

    	<c:choose>
  	<c:when test="${noteObject.done}">
  		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="checkbox" name="done" checked>
		  <label class="form-check-label" for="inlineCheckbox1">Unmark if not Done</label>
		</div>
  	</c:when>
  	<c:otherwise>
  		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="checkbox" name="done">
		  <label class="form-check-label" for="inlineCheckbox1">Mark as done</label>
		</div>
  	</c:otherwise>
  	</c:choose>
  	
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