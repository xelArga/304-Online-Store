<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
		<link rel="stylesheet" type="text/css" href="css/dark-theme.css">
        <link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
 <%@ include file="header.jsp" %>
<header>
        <h1>Ray's Groceries</h1>
    </header>
    <div class="banner">
        <h2>Welcome to Ray's Groceries!</h2>
        <p>Your one-stop shop for fresh produce, pantry staples, and everyday essentials.</p>
        <a href="listprod.jsp">Start Shopping</a>
    </div>

    <div class="featured">
        <h2>Featured Products</h2>
        <div class="product-grid">
            <div class="product-card">
                <img src="img/1.jpg" alt="Chai">
                <h3>Chai</h3>
                <p>$18.00</p>
                <a href="product.jsp?id=1">View Details</a>
            </div>
            <div class="product-card">
                <img src="img/2.jpg" alt="Chang">
                <h3>Chang</h3>
                <p>$19.00</p>
                <a href="product.jsp?id=2">View Details</a>
            </div>
            <div class="product-card">
                <img src="img/5.jpg" alt="Gumbo Mix">
                <h3>Chef Anton's Gumbo Mix</h3>
                <p>$21.35</p>
                <a href="product.jsp?id=5">View Details</a>
            </div>
        </div>
    </div>

</body>
</head>


