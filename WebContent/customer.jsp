<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
 <link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String sql = "SELECT * FROM customer WHERE userid = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
        out.print("<h1>Customer Profile</h1>");
        out.println("<table class=\"customer-table\">");
        if(rst.next()){
            out.println("<tr><th>Id</th>" + "<td>"+rst.getInt(1) + "</td></tr>");
			out.println("<tr><th>First Name</th>" + "<td>"+rst.getString(2) + "</td></tr>");
			out.println("<tr><th>Last Name</th>" + "<td>"+rst.getString(3) + "</td></tr>");
			out.println("<tr><th>Email</th>" + "<td>"+rst.getString(4) + "</td></tr>");
			out.println("<tr><th>Phone</th>" + "<td>"+rst.getString(5) + "</td></tr>");
			out.println("<tr><th>Address</th>" + "<td>"+rst.getString(6) + "</td></tr>");
			out.println("<tr><th>City</th>" + "<td>"+rst.getString(7) + "</td></tr>");
			out.println("<tr><th>State</th>" + "<td>"+rst.getString(8) + "</td></tr>");
			out.println("<tr><th>Postal Code</th>" + "<td>"+rst.getString(9) + "</td></tr>");
			out.println("<tr><th>Country</th>" + "<td>"+rst.getString(10) + "</td></tr>");
			out.println("<tr><th>User id</th>" + "<td>"+rst.getString(11) + "</td></tr>");
        }
        out.println("</table>");
		boolean onOrder = false;
		int lastOrder = -1;
        sql = "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount, c.userid, " +
		"op.productId, op.quantity, op.price " +
		"FROM orderproduct op JOIN ordersummary os ON op.orderId = os.orderId JOIN customer c ON os.customerId = c.customerId WHERE c.userid = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);
		rst = pstmt.executeQuery();
        out.print("<h1>Customer Orders</h1>");
        out.println("<table class=\"customer-table\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
        while (rst.next()){
			int currentOrder = rst.getInt("orderId");
			if(currentOrder != lastOrder){
				lastOrder = currentOrder;
				if(onOrder){
					out.println("</table>");
					onOrder = false;
				}
				out.println("<tr><td>"+rst.getString("orderId")+"</td><td>"+rst.getString("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble("totalAmount"))+"</tr>");
				out.println("<tr align=\"right\"><td colspan=\"4\">");
				out.println("<table align=\"right\" border = \"1\"><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
				out.println("<tr><td>"+rst.getInt("productId")+"</td><td>"+rst.getInt("quantity")+"</td><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble("price"))+"</td></tr>");
				onOrder = true;
			} else{
				out.println("<tr><td>"+rst.getInt("productId")+"</td><td>"+rst.getInt("quantity")+"</td><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble("price"))+"</td></tr>");
			}
			
			
		}
		out.println("</table>");
		out.println("</table>");
			  }
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	

%>
<div class="login-container">
<form method="post" action="editcustomer.jsp">
<h2>Edit Address</h2>
<table>
<tr><td>Address:</td><td><input type="text" name="address" required></td></tr>
<tr><td>City:</td><td><input type="text" name="city" required></td></tr>
<tr><td>State</td><td><input type="text" name="state" required></td></tr>
<tr><td>Postal Code:</td><td><input type="text" name="postalCode" required></td></tr>
<tr><td>Country:</td><td><input type="text" name="country" required></td></tr>
<tr><td><input type="hidden" name="change" value="address"></td></tr>
<tr><td><input type="hidden" name="userId" value=<% out.print(userName);%>></td></tr>
<tr><td><input type="submit" value="Submit"></td>
</table>
</form>
</div>
<div class="login-container">
<form method="post" action="editcustomer.jsp" onsubmit="return validatePasswords()">
<h2>Change Password</h2>
<table>
<tr><td>New password:</td><td><input type="password" id="newpw" name="newpw" required></td></tr>
<tr><td>Confirm new password:</td><td><input type="password" id="confirmpw" name="confirmpw" required></td></tr>
<tr><td><input type="hidden" name="change" value="password"></td></tr>
<tr><td><input type="hidden" name="userId" value=<% out.print(userName);%>></td></tr>
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

</body>
</html>

