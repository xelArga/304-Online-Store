<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="login-container">

<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table>
<tr>
	<td>Username</td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td>Password</td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In">
</form>
<h2><a href="createuser.jsp">Don't have an account? Create one!</a></h2>
</div>

</body>
</html>

