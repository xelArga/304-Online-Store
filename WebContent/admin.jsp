<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
 <%@ include file="header.jsp" %>
<%

try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String sql = "SELECT CONVERT(DATE, orderDate) AS orderDate, SUM(totalAmount) FROM ordersummary " +
        "GROUP BY CONVERT(DATE, orderDate)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
        out.print("<h1>Administrator Sales Report By Day</h1>");
        out.println("<table border=\"2\"><tr>");
        out.println("<th>Order Date</th><th>Total Order Amount</th></tr>");
        while(rst.next()){
            out.println("<tr><td>"+rst.getString(1) +"</td><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble(2))+ "</td></tr>");
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

