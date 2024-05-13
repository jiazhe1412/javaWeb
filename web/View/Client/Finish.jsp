<%-- 
    Document   : Finish
    Created on : Apr 3, 2024, 6:34:42 PM
    Author     : User
--%>
<jsp:useBean id="paymentRecord" scope="session" class="model.Payment" />
<%@page import="java.util.*, model.*"%>
<%@page import="java.util.Date"%>

<%
    List<Placeorder> placeorderList = (List<Placeorder>) session.getAttribute("cartList");
    List<Discount> discountInfo = (List<Discount>) (session.getAttribute("discountList") != null ? session.getAttribute("discountList") : null);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/Finish.css" rel="stylesheet" type="text/css"/>
        <title>Finish</title>
    </head>
    <body>

        <div id = "payment">

            <div style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>

            <!--Entire Webpage-->
            <div style="margin: 80px 0; height: fit-content">

                <!-- The div is use to display the path of current webpage -->

                <!--Link Box-->
                <div class="link-box">
                    <p class="link">
                        <a href="homeUser.jsp" 
                           class="hoverLink">Home
                        </a>
                        ️<i class="fa fa-arrow-right" style="margin-left: 16px"></i>
                        <a href="Product.jsp" class="hoverLink" style="margin-left: 16px">Cart
                        </a>
                        <i class="fa fa-arrow-right" style="margin-left: 16px"></i> 
                        <a style="margin-left: 16px">Check Out</a>
                    </p>
                </div>
                <!--Link Box End-->

                <!-- The progress  indicator for payment-->
                <div class="progressBar">
                    <div class="statusBar">
                        <div class="point done">
                            <div class="main"></div>
                            <span class="text done">CheckOut</span>
                        </div>
                        <div class="point done">
                            <div class="main"></div>
                            <span class="text done">Review</span>
                        </div>
                        <div class="point done">
                            <div class="main current"></div>
                            <span class="text done">Finish</span>
                        </div>
                    </div>
                </div>
                <!--Order Detail review section-->
                <section>
                    <a href="homeUser.jsp" id="homebutton">Back to Home</a>
                    <br>
                    <h1 style="font-size:200%;">Thank you. your order has been received.</h1>
                    <br>
                    <table class="basicDetail">
                        <tr>
                            <td>
                                <h4>Order number</h4>
                                <p><%= paymentRecord.getOrderid().getOrderid()%></p>
                            </td>
                            <td>
                                <h4>Date</h4>
                                <p>${paymentRecord.paymentdate}</p>
                            </td>
                            <td>
                                <h4>Total</h4>
                                <p>RM${paymentRecord.totalamount}</p>
                            </td>
                            <td>
                                <h4>Payment Method</h4>
                                <p>${paymentRecord.paymentmethod}</p>
                            </td>
                        </tr>
                    </table>

                    <br>

                    <h1>Order details</h1><br>
                    <table class="orderDetail">
                        <tr>
                            <th style="float:left;">PRODUCT</th>
                            <th style="float:right;">TOTAL</th>
                        </tr>
                        <tr>
                            <td colspan="2"><hr></td>
                        </tr>
                        <% if (placeorderList != null) {
                                double totalprice = 0;
                                for (Placeorder p : placeorderList) {
                        %>
                        <tr>
                            <td style="float:left;"><%= p.getProductid().getProductname()%></td>
                            <%
                                Date currentDate = new Date();
                                if (discountInfo.size() != 0) {
                                    int countProduct = 0;
                                    double discountPrice = 0;
                                    double price = 0;
                                    for (Discount d : discountInfo) {
                                        if (p.getProductid().getProductid().equals(d.getProductid().getProductid()) && currentDate.after(d.getActivateDate()) && currentDate.before(d.getExpireDate())) {
                                            countProduct++;
                                            Discount ds = new Discount();
                                            discountPrice = d.calculateDiscountTotalPrice(p.getProductid().getPrice(), d.getDiscountrate());
                                        }
                                    }
                            %>
                            <% if (countProduct > 0) {
                                    price = discountPrice * p.getQuantity();
                                    totalprice += price;
                            %>
                            <% } else {

                                    price = p.getProductid().getPrice().doubleValue() * p.getQuantity();
                                    totalprice += price;
                                }
                            %>

                            <td style="float:right;">RM<%= String.format("%.2f", price)%></td>

                            <% } %>

                        </tr>
                        <tr>
                            <td colspan="2"><hr></td>
                        </tr>
                        <% } %>
                        <%
                            double deliveryfees = 0.0;
                            if (totalprice < 1000) {
                                deliveryfees = 25.0;

                            }

                        %>
                        <tr>
                            <td style="float:left;">Shipping</td>
                            <td style="float:right;">RM<%= String.format("%.2f", deliveryfees)%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><hr></td>
                        </tr>
                        <tr>
                            <th style="float:left;">TOTAL</th>
                            <td style="float:right;">RM${paymentRecord.totalamount}</td>
                        </tr>
                        <tr>
                            <td colspan="2"><hr></td>
                        </tr>
                        <% }%>
                    </table>

                    <br><br> 

                    <h1>Customer Details</h1><br>
                    <table class="customerDetail">
                        <tr>
                            <th>Shipping address</th>
                            <th>Email address</th>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>${paymentRecord.shipaddress}</p>

                            </td>
                            <td>
                                <p>${paymentRecord.email}</p>
                            </td>
                        </tr>
                    </table>

                </section>
            </div>

            <%@ include file = "footer.jsp" %>
            <!--End Entire Web Page-->
        </div>




    </body>
    <%
        session.removeAttribute("paymentRecord");
        session.removeAttribute("cardList");
        session.removeAttribute("discountList");
        session.removeAttribute("paymentRecord");
        session.removeAttribute("findOrderID");
//%>
</html>
