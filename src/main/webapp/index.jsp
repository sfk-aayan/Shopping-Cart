<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--
  Contains a simple login page. The designs were done using
  regular CSS, the code for which is present in the index.css
  file. The user just has to input his name to log in(for ease
  of access). The sign in request is sent to the ControllerServlet.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Introduction</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
<div class="form-area">
    <h3><%= "Enter Name To Continue" %> </h3>
<form action="controllerServlet" name="login" method="post">
    <div class="txt">
    <input name="name" type="text" required>
        <span></span>
    <label>Name</label>
    </div>
    <input type="submit" value="Submit">
</form>
</div>
</body>
</html>