<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
 <%@ include file="header.jsp" %>
<%
out.println("<h1>Administrator Panel</h1>");
%>
<div class ="container2">
<a href = "admin.jsp?option=day">Sales Report By Day</a>
<a href = "admin.jsp?option=customer">List Customers</a>
</div>
<%
String option = request.getParameter("option");
if(option != null){
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    if(option.equals("day")){
    String sql = "SELECT CONVERT(DATE, orderDate) AS orderDate, SUM(totalAmount) FROM ordersummary " +
        "GROUP BY CONVERT(DATE, orderDate)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rst = pstmt.executeQuery();
        out.print("<h1>Sales Report By Day</h1>");
        out.println("<table class=\"customer-table\"><tr>");
        out.println("<th>Order Date</th><th>Total Order Amount</th></tr>");
        while(rst.next()){
            out.println("<tr><td>"+rst.getString(1) +"</td><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble(2))+ "</td></tr>");
        }
        out.println("</table>");
        
		}else if (option.equals("customer")){
            String sql = "SELECT * FROM customer ";
	    PreparedStatement pstmt = con.prepareStatement(sql);
	    ResultSet rst = pstmt.executeQuery();
        out.print("<h1>All Customers</h1>");
        out.println("<table class=\"customer-table\"><tr>");
        out.println("<th>Customer Id</th><th>Customer Name</th></tr>");
        while(rst.next()){
            out.println("<tr><td>"+rst.getString(1) +"</td><td>"+rst.getString(2) +" "+ rst.getString(3)+ "</td></tr>");
        }
        out.println("</table>");
        }
}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	
}

%>

</body>
</html>

