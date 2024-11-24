<html>
<head>
<title>Ray's Grocery</title>
 <link rel="stylesheet" type="text/css" href="css/dark-theme.css">
<link rel="stylesheet" type="text/css" href="css/table-styles.css">
</head>
<body>
 <%@ include file="header.jsp" %>

<h1>Enter your customer id and password to complete the transaction:</h1>
<div class="login-container">
<form method="post" action="order.jsp">
<table>
<tr><td>Customer ID:</td><td><input type="text" name="customerId"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password"></td></tr>
<tr><td><h2>Payment information</h2></td></tr>
<tr><td>Payment type:</td><td> <select name="paymentType">
            <option value="Visa">Visa</option>
            <option value="MasterCard">MasterCard</option>
        </select></td></tr>
<tr><td>Card Number:</td><td><input type="text" name="cardNumber" pattern="\d{16}" 
               title="Please enter a 16-digit card number" required></td></tr>
<tr><td>Expiry Date:</td><td><input type="text" name="expiry" size="20" placeholder="MM/YY" pattern="(0[1-9]|1[0-2])/\d{2}" 
               title="Please enter a valid expiry date in MM/YY format" required></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>
</div>
</body>
</html>

