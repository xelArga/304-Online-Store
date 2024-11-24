<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
 <link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
String change = request.getParameter("change");
if(change != null){
try (Connection con = DriverManager.getConnection(url, uid, pw)) {
    if(change.equals("address")){
        String SQL = "UPDATE customer SET address = ?, city = ?, state = ?, postalCode = ?, country = ? " +
        "WHERE userId = ?";
        PreparedStatement pstmt = con.prepareStatement(SQL);
	    pstmt.setString(1, request.getParameter("address"));
        pstmt.setString(2, request.getParameter("city"));
        pstmt.setString(3, request.getParameter("state"));
        pstmt.setString(4, request.getParameter("postalCode"));
        pstmt.setString(5, request.getParameter("country"));
        pstmt.setString(6, request.getParameter("userId"));
	    pstmt.executeUpdate();
    } else{
       String SQL = "UPDATE customer SET password = ? " +
        "WHERE userId = ?"; 
        PreparedStatement pstmt = con.prepareStatement(SQL);
	    pstmt.setString(1, request.getParameter("confirmpw"));
         pstmt.setString(2, request.getParameter("userId"));
         pstmt.executeUpdate();
    }
        response.sendRedirect("customer.jsp");
}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}	
}
else {
    out.println("<h3>Error: Missing or invalid request parameter!</h3>");
}
%>

</body>
</html>