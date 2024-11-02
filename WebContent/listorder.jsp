<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
		int lastOrder = -1;
		boolean onOrder = false;
		String SQL = "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount, " +
		"op.productId, op.quantity, op.price " +
		"FROM orderproduct op JOIN ordersummary os ON op.orderId = os.orderId JOIN customer c ON os.customerId = c.customerId ";
		PreparedStatement pstmt = con.prepareStatement(SQL);
        ResultSet rst = pstmt.executeQuery();
		out.println("<table border = \"1\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
		while (rst.next()){
			int currentOrder = rst.getInt("orderId");
			if(currentOrder != lastOrder){
				lastOrder = currentOrder;
				if(onOrder){
					out.println("</table>");
					onOrder = false;
				}
			
				out.println("<tr><td>"+rst.getString("orderId")+"</td><td>"+rst.getString("orderDate")+"</td><td>"+rst.getInt("customerId")+"</td><td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td><td>"+rst.getString("totalAmount")+"</tr>");
				out.println("<tr align=\"right\"><td colspan=\"4\">");
				out.println("<table border = \"1\"><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
				out.println("<tr><td>"+rst.getInt("productId")+"</td><td>"+rst.getInt("quantity")+"</td><td>"+rst.getString("price")+"</td></tr>");
				onOrder = true;
			} else{
				out.println("<tr><td>"+rst.getInt("productId")+"</td><td>"+rst.getInt("quantity")+"</td><td>"+rst.getString("price")+"</td></tr>");
			}
			
			
		}
		out.println("</table>");
			  }
	    
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	

// Write query to retrieve all order summary records
		
		
// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

