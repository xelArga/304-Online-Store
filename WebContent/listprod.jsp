<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery</title>
<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
<form method="get" action="listprod.jsp">
	<select type="number" name="categoryName">
  <option value="All">All</option>
  <option value="Beverages">Beverages</option>
  <option value="Condiments">Condiments</option>
  <option value="Confections">Confections</option>
  <option value="Dairy Products">Dairy Products</option>
  <option value="Grains/Cereals">Grains/Cereals</option>
  <option value="Meat/Poultry">Meat/Poultry</option>
  <option value="Produce">Produce</option>
  <option value="Seafood">Seafood</option>       
  </select>
    <input type="text" name="productName" size="50" placeholder="Search for products...">
    <input type="submit" value="Search">
    <input type="reset" value="Clear">
</form>


<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName") == null ? "All" : request.getParameter("categoryName");
	
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
	PreparedStatement pstmt;
	if(name == null || name.trim().isEmpty()){
		String SQL = "SELECT product.productId, productName, productPrice, product.categoryId, categoryName, quantity " +
		"FROM productinventory JOIN product ON product.productId = productinventory.productId JOIN category ON product.categoryId = category.categoryId " + 
		"WHERE (? = 'All' OR categoryName = ?) " +
		"ORDER BY quantity ASC";
		pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, category);
		pstmt.setString(2, category);
        
	}else{
		String SQL = "SELECT product.productId, productName, productPrice, product.categoryId, categoryName, quantity " +
		"FROM product JOIN category ON product.categoryId = category.categoryId JOIN productinventory ON product.productId = productinventory.productId " +
		"WHERE productName LIKE ? and (? = 'All' OR categoryName = ?) ORDER BY quantity ASC";
		pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, "%" + name + "%");
		pstmt.setString(2, category);
		pstmt.setString(3, category);
        
	}
		ResultSet rst = pstmt.executeQuery();
		if(category.equals("All")){
		out.println("<h2>All Products</h2>");
		} else{
			out.println("<h2>Products in category: " + category+ "</h2>");
		}
		out.println("<table class=\"product-table\"><tr><th></th><th>Product Name</th><th>Product Category</th><th>Price</th></tr>");
		while (rst.next()){
			int id = rst.getInt("productId");
			String productName = rst.getString("productName");
			Double price = rst.getDouble("productPrice");
			out.print("<tr><td><a href=\"addcart.jsp?id=" + id + "&name="+productName+"&price="+price+"\">Add to Cart</a></td>");
			out.print("<td><a href=\"product.jsp?id=" + id+"\">"+productName+"</a></td>");
			out.print("<td>"+rst.getString("categoryName")+"</td>");
			out.println("<td>" +NumberFormat.getCurrencyInstance().format(price) + "</td></tr>");
			}
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>		
</div>

</body>
</html>