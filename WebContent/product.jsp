<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>
<%@ page import="java.text.NumberFormat" %>

<%
// Get product name to search for
String productId = request.getParameter("id");
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    String sql = "SELECT productName, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(productId));
	ResultSet rst = pstmt.executeQuery();
		if(rst.next()){
            out.print("<h2>" + rst.getString(1) + "</h2>");
            out.println("<table><tr>");
            out.println("<th>Id</th><td>"+ productId +"</td></tr><tr><th>Price</th><td>"+NumberFormat.getCurrencyInstance().format(rst.getDouble(2))+"</td></tr>");
            if(rst.getString("productImageURL") != null){
                out.println("<img src=\"" + rst.getString("productImageURL") +"\">");
            }
            if(rst.getBinaryStream("productImage") != null){
                out.println("<img src=\"displayImage.jsp?id=" + productId +"\">");
            }
            out.println("</table>");
            out.println("<h3><a href=\"addcart.jsp?id=" + productId +"&name="+rst.getString(1)+"&price="+rst.getDouble(2)+"\">Add to Cart</a></h3>");
            out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
        }
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	
%>

</body>
</html>

