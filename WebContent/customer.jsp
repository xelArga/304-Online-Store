<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String sql = "SELECT * FROM customer WHERE userid = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
        out.print("<h1>Customer Profile</h1>");
        out.println("<table border=\"2\">");
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
        
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	

%>

</body>
</html>

