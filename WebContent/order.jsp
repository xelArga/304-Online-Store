<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id

String custId = request.getParameter("customerId");
// Determine if valid customer id was entered

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
Connection con;
try {
	Integer.parseInt(custId);
	con = DriverManager.getConnection(url, uid, pw);
	String SQL = "SELECT firstName, lastName " +
		"FROM customer WHERE customerId = ?";
		PreparedStatement pstmt= con.prepareStatement(SQL);
		pstmt.setString(1, custId);
		ResultSet rst = pstmt.executeQuery();
		if(!rst.next()){ //means no customers returned
			out.println("<h1>Invalid customer id. Go back to the previous page and try again</h1>");
		} else if (productList == null || productList.isEmpty()){
			out.println("<h1>Your shopping cart is empty!</h1>");
		} else{
			DecimalFormat df = new DecimalFormat("#.00");
			String fullName = rst.getString("firstName") + " " + rst.getString("lastName");
			double totalAmount = 0;
			SQL = "INSERT INTO ordersummary(orderDate, customerId) VALUES (?, ?)";
			pstmt = con.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);	
			pstmt.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
			pstmt.setString(2, custId);  
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			SQL = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
			pstmt = con.prepareStatement(SQL);
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			out.println("<h1>Your Order Summary</h1>");
			out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
			while (iterator.hasNext())
			{ 
				double subtotal = 0;
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
        		String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				subtotal = qty * pr;
				totalAmount += subtotal;
				pstmt.setInt(1, orderId);
				pstmt.setString(2, productId);
				pstmt.setInt(3, qty);
				pstmt.setDouble(4, pr);
				pstmt.executeUpdate();
				out.println("<tr><td>" + productId +"</td><td>"+(String)product.get(1)+"</td><td>"+qty+"</td><td>$"+df.format(pr)+"</td><td>$"+df.format(subtotal)+"</td></tr>");
				
			}
			out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td aling=\"right\">$"+ df.format(totalAmount)+
			 "</td></tr></table>");
			out.println("<h1>Order completed. Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is: "+orderId+"</h1>");
			out.println("<h1>Shipping to customer: "+custId+" Name: " +fullName+ "</h1>");
			SQL = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setDouble(1, totalAmount);
			pstmt.setInt(2, orderId);
			pstmt.executeUpdate();
			session.removeAttribute("productList");
			
		}
		con.close();
}
		catch(NumberFormatException ex){
			out.println("<h1>Invalid customer id. Go back to the previous page and try again</h1>");
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}


// Determine if there are products in the shopping cart
// If either are not true, display an error message

// Make connection

// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

