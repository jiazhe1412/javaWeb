<%-- 
    Document   : header
    Created on : 31 Mar 2024, 8:33:08 pm
    Author     : Rong
--%>
<%@page import="model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/header.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Header</title>
    </head>
    <body>
        <%
            Customer customer = (Customer) session.getAttribute("customer");
            Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");

            if (loggedIn == null) {
                loggedIn = false;
            }
        %>
        <div class="header">
            <div class="container-1">
                <div class="top-1">
                    <p style="width:50%">Call Us: +60 11-5699 4938</p>
                    <p style="width:50%">Email: <a href="mailto:toystore@example.com">toystore@example.com</a></p>
                </div>
                <div class="top-2">   
                    <p class="fb"><a href="#"><i class="fa fa-facebook-official" aria-hidden="true"></i></a></p>
                    <p class="ins"><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></p>
                    <p class="twi"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></p>
                    <p class="yt"><a href="#"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></p>
                </div>
            </div>
            <div class="container-2">
                <div class="bottom-1">
                    <p class="logo"><a href="../../HomePageDisplay">Pet Store</a></p>
                </div>
                <div class="bottom-2">
                    <p class="product"><a href="../../ProductList">Products</a></p>
                </div>
                <div class="bottom-4">
                    <% if (loggedIn) { %>
                    <!-- If user is logged in, display payment history -->

                    <p class="payment"><a href="../../PaymentHistoryDisplay">Payment History</a></p>

                    <% } %>
                </div>
                <div class="bottom-5">
                    <% if (loggedIn) { %>
                    <!-- If user is logged in, display payment history -->

                    <p class="order"><a href="../../ClientOrderStatusDisplay">Order Status</a></p>

                    <% } %>
                </div>
                <div class="bottom-3">
                    <p class="cart"><a href="../../DisplayCart">Cart<i class="fa fa-shopping-cart" aria-hidden="true"></i></a></p>
                            <% if (loggedIn) { %>
                    <!-- If user is logged in, display logout link -->
                    <p class="logout"><a href="../Client/UserLogout">Logout<i class="fa fa-sign-out" aria-hidden="true"></i></a></p>
                            <% } else { %>
                    <!-- If user is not logged in, display login link -->
                    <p class="login"><a href="login.jsp">Login<i class="fa fa-user-circle-o" aria-hidden="true"></i></a></p>
                            <% }%>
                </div>
            </div>
        </div>
    </body>
</html>
