<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String delete = request.getParameter("delete");
if(delete != null && productList != null){
	productList.remove(delete);
}

if (productList == null || productList.isEmpty())
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	String updateId = request.getParameter("update");
    String newQtyStr = request.getParameter("newqty");

        if (updateId != null && newQtyStr != null) {
            try {
                Integer newQty = Integer.parseInt(newQtyStr);

                if (productList.containsKey(updateId)) {
                    ArrayList<Object> product = productList.get(updateId);
                    product.set(3, newQty);  // Update the quantity at the correct index (3rd position)
                    session.setAttribute("productList", productList); // Save the updated product list back to session
                }
            } catch (NumberFormatException e) {
                out.println("Invalid quantity format.");
            }
        }
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");


	out.print("<table class=\"product-table\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total = 0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<form method=\"get\" action=\"showcart.jsp\">");
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

        out.print("<td><input type=\"text\" name=\"newqty\" size=\"3\" value=\"" + product.get(3) + "\" /></td>");

		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");

		out.print("<td><a href=\"showcart.jsp?delete=" + product.get(0) + "\">Remove Item</a></td>");
		out.print("<td><input class=\"styled-button\" type=\"submit\" value=\"Update Quantity\" onclick=\"this.form.submit()\" /></td>");
        out.print("<input type=\"hidden\" name=\"update\" value=\"" + product.get(0) + "\" />");
		out.println("</tr>");
		out.print("</form>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" style=\"text-align:right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");
	
	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

