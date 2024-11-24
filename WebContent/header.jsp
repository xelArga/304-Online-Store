<nav>
        <a href="index.jsp">Home</a>
        <a href="listprod.jsp">Products</a>
        <a href="showcart.jsp">Cart</a>
		<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null){
		out.println("<p> Signed in as: "+userName+"</p>");
		out.println("<a href=\"logout.jsp\">Log out</a>");
	} else{
		out.println("<a href=\"login.jsp\">Login</a>");
	}
%>
		<a href="admin.jsp">Administrators</a>
    </nav>   
