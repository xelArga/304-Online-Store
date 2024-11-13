<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
    try (Connection con = DriverManager.getConnection(url, uid, pw)) {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		con.setAutoCommit(false);
		String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, orderId);
		ResultSet rst = pstmt.executeQuery();
		HashMap<Integer, Integer> products = new HashMap<>();
		while(rst.next()){
			products.put(rst.getInt("productId"), rst.getInt("quantity"));
		}
		sql = "INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)";
		pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
		pstmt.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
		pstmt.setString(2, "Some description");
		pstmt.setInt(3, 1);
		pstmt.executeUpdate();
		sql = "SELECT * FROM productinventory WHERE warehouseId = 1";
		pstmt = con.prepareStatement(sql);
		rst = pstmt.executeQuery();
		String sql2 = "UPDATE productinventory SET quantity = quantity - ? WHERE productId = ?";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		while(rst.next()){
			if(products.containsKey(rst.getInt("productId"))){
				if(rst.getInt("quantity") >= products.get(rst.getInt("productId"))){
					pstmt2.setInt(1, products.get(rst.getInt("productId")));
					pstmt2.setInt(2, rst.getInt("productId"));
					out.println("<h2>Ordered Product: " + rst.getInt("productId") + " Qty: " + products.get(rst.getInt("productId")) +
					" Previous inventory: " + rst.getInt("quantity") + " New inventory: " + (rst.getInt("quantity") - products.get(rst.getInt("productId"))));
					pstmt2.executeUpdate();
				}else{
					out.println("<h1>Shipment not done. Insufficient inventory for product id: " + rst.getInt("productId") +"</h1>");
					con.rollback();
					break;
				}
			}
		}
		con.commit();
        con.setAutoCommit(true);
		} catch(NumberFormatException e){
			out.println("Number Format Exception: " + e);
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}
	// TODO: Check if valid order id in database
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
