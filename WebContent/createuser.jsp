<!DOCTYPE html>
<html>
<head>
<title>Create Account Page</title>
 <link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<div class="login-container">
<form method="post" action="createuser.jsp" onsubmit="return validatePasswords()">
<h2>Edit Address</h2>
<table>
<tr><td>First name:</td><td><input type="text" name="firstName" required></td></tr>
<tr><td>Last name:</td><td><input type="text" name="lastName" required></td></tr>
<tr><td>Email:</td><td><input type="email" name="email" placeholder="example@example.com" required></td></tr>
<tr><td>Phone number:</td><td><input type="text" name="phoneNum" pattern="^\d{3}-\d{3}-\d{4}$" placeholder="123-456-7890" required></td></tr>
<tr><td>Address:</td><td><input type="text" name="address" required></td></tr>
<tr><td>City:</td><td><input type="text" name="city" required></td></tr>
<tr><td>State</td><td><input type="text" name="state" required></td></tr>
<tr><td>Postal Code:</td><td><input type="text" name="postalCode" required></td></tr>
<tr><td>Country:</td><td><input type="text" name="country" required></td></tr>
<tr><td>User name:</td><td><input type="text" name="username" required></td></tr>
<tr><td>New password:</td><td><input type="password" id="newpw" name="password" required></td></tr>
<tr><td>Confirm new password:</td><td><input type="password" id="confirmpw" name="confirmpw" required></td></tr>
<tr><td><input type="hidden" name="change" value="password"></td></tr>
<tr><td><input type="submit" value="Submit"></td>
</table>
</form>
</div>
<script>
    function validatePasswords() {
        const newPw = document.getElementById('newpw').value;
        const confirmPw = document.getElementById('confirmpw').value;

        if (newPw !== confirmPw) {
            alert('New passwords do not match. Please try again.');
            return false;
        }

        return true;
    }
</script>
<%
if ("POST".equalsIgnoreCase(request.getMethod())){
String userId = request.getParameter("username");
if(userId != null){
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String SQL = "SELECT email, userid FROM customer WHERE email = ? OR userid = ?";
    PreparedStatement pstmt = con.prepareStatement(SQL);
    pstmt.setString(1, request.getParameter("email"));
    pstmt.setString(2, request.getParameter("username"));
    ResultSet rst = pstmt.executeQuery();
    if(rst.next()){
        out.println("User name or email already used");
    }else{
    SQL = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) "+
    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(SQL);
        pstmt.setString(1, request.getParameter("firstName"));
        pstmt.setString(2, request.getParameter("lastName"));
        pstmt.setString(3, request.getParameter("email"));
        pstmt.setString(4, request.getParameter("phoneNum"));
	    pstmt.setString(5, request.getParameter("address"));
        pstmt.setString(6, request.getParameter("city"));
        pstmt.setString(7, request.getParameter("state"));
        pstmt.setString(8, request.getParameter("postalCode"));
        pstmt.setString(9, request.getParameter("country"));
        pstmt.setString(10, request.getParameter("username"));
        pstmt.setString(11, request.getParameter("password"));
	    pstmt.executeUpdate();
    }
        session.setAttribute("authenticatedUser",request.getParameter("username"));
        response.sendRedirect("customer.jsp");
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	
}
}

%>


</body>
</html>

