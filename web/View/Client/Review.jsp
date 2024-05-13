<%-- 
    Document   : Payment
    Created on : Mar 28, 2024, 5:52:31 PM
    Author     : User
--%>

<%@page import="javax.persistence.PersistenceContext"%>
<%@page import="javax.persistence.Query"%>
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
        <link href="../CSS/Review.css" rel="stylesheet" type="text/css"/>
        <title>Review</title>
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
                        <a href="Product.jsp" class="hoverLink" style="margin-left: 16px">Cart</a>

                        <i class="fa fa-arrow-right" style="margin-left: 16px"></i> 
                        <a style="margin-left: 16px">Check Out</a>

                        <i class="fa fa-arrow-right" style="margin-left: 16px"></i> 
                        <a style="margin-left: 16px">Review</a>
                    </p>
                </div>
                <!--Link Box End-->


                <!-- The progress  indicator for payment-->
                <div class="progressBar">
                    <div class="statusBar">
                        <span class="greenBar"></span>
                        <div class="point done">
                            <div class="main"></div>
                            <span class="text done">CheckOut</span>
                        </div>
                        <div class="point done">
                            <div class="main current"></div>
                            <span class="text done">Review</span>
                        </div>
                        <div class="point">
                            <div class="main"></div>
                            <span class="text">Finish</span>
                        </div>
                    </div>
                </div>


                <form action="../../SavePaymentDetail" method="POST">
                    <!-- The Column that required user to insert their detail 
                         like payment info, customer info and shipping address. -->
                    <div class="paymentContent">

                        <div class="left">
                            <!-- Payment Method Info -->
                            <div class="detail">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px">
                                    <h2 class="head">Payment Info</h2>
                                </div>
                                <hr class = "headerBottom">
                                <% if (paymentRecord.getPaymentmethod().equals("creditCard")) { %>
                                <h3>Payment Method</h3>
                                <p>${paymentRecord.paymentmethod}</p><br>
                                <div id="userCard">
                                    <img src="../image/mastercard.png" alt="visa"/><br>
                                    <p>${paymentRecord.cardnum}</p>
                                </div>
                                <% }
                                    if (paymentRecord.getPaymentmethod().equals("ewallet")) {%>
                                <h3>Payment Method</h3>
                                <h4>${paymentRecord.paymentmethod}</h4><br>
                                <p>
                                    <%
                                        if (paymentRecord.getWallettype().equals("touchandgo")) {
                                            out.println(paymentRecord.getWallettype());
                                        }
                                    %>
                                </p>
                                <% }
                                    if (paymentRecord.getPaymentmethod().equals("cash")) {%>
                                <h3>Payment Method</h3><br>
                                <p>Please pay on our counter in 7 days after place the order.</p>
                                <% }%>
                            </div>


                            <!-- Customer Info -->
                            <div class = "detail">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px">
                                    <h2 class="head">Customer Info</h2>
                                </div>
                                <hr class = "headerBottom">
                                <label>Email</label><br>
                                <p>${paymentRecord.email}</p>
                                <br><br>
                                <label>Shipping Address</label><br>
                                <p>${paymentRecord.shipaddress}</p>

                            </div>
                            <!-- End Customer Info -->

                            <!--Responsive Hidden Payment Box-->
                            <div class="paymentSummary2">
                                <div class="detail">
                                    <h3>Order Summary</h3>

                                    <hr class = "separate">

                                    <table id='summary'>
                                        <tr>
                                            <td>SubTotal</td>
                                            <td>RM120.00</td>
                                        </tr>
                                        <tr>
                                            <td>Delivery Fees</td>
                                            <td>RM25.00</td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><hr class = "separate"></td>
                                        </tr>
                                        <tr>
                                            <th>Subtotal</th>
                                            <th>RM145.00</th>
                                        </tr>
                                    </table>
                                </div>
                                <input type="submit" name="pay" value="Continue CheckOut" id="paySubmit">
                            </div>
                        </div>
                        <!-- End LEFT -->


                        <!-- The column that user can view their cart and total price -->
                        <div class="right">
                            <!-- The column that user can view their cart and total price -->
                            <div class="detail">
                                <div class="orderList">
                                    <h2>Item(s) in Order</h2>
                                    <hr class="headerBottom">
                                    <table id='orderProdList'>
                                        <% if (placeorderList != null) {
                                                double totalprice = 0;
                                                for (Placeorder p : placeorderList) {
                                        %>
                                        <tr>
                                            <th><img src="../image/<%= p.getProductid().getImagepath()%>" alt="" class="productImage" width="150"/></th>
                                            <td><p><%= p.getProductid().getProductname()%></p><p>Quantity: <%= p.getQuantity()%></p></td>
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
                                            <td><p>RM<%= String.format("%.2f", price)%></p></td>

                                            <% } else {

                                                price = p.getProductid().getPrice().doubleValue() * p.getQuantity();
                                                totalprice += price;
                                            %>

                                            <td><p>RM <%= String.format("%.2f", price)%></p></td>

                                            <%
                                                        }
                                                    
                                                }
                                            %>

                                        <tr>

                                            <% }%>
                                    </table>
                                </div>
                            </div>

                            <div class="paymentSummary">
                                <div class="detail">
                                    <h3>Order Summary</h3>

                                    <hr class = "separate">

                                    <table id='summary'>
                                        <tr>
                                            <td>Total</td>
                                            <td>RM<%= String.format("%.2f", totalprice)%></td>
                                        </tr>
                                        <%
                                            double deliveryfees = 0.0;
                                            if (totalprice < 1000) {
                                                deliveryfees = 25.0;
                                                totalprice += deliveryfees;
                                            }

                                            session.setAttribute("total", totalprice);
                                        %>
                                        <tr>
                                            <td>Delivery Fees</td>
                                            <td>RM<%= String.format("%.2f", deliveryfees)%></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><hr class = "separate"></td>
                                        </tr>
                                        <tr>
                                            <th>Subtotal</th>
                                            <th>RM<%= String.format("%.2f", totalprice)%></th>
                                        </tr>
                                    </table>
                                </div>
                                <% }%>
                                <input type="submit" name="pay" value="Continue CheckOut" id="paySubmit">
                            </div>

                            <!--End Right Content-->
                        </div>
                        <!--End Right-->
                    </div>
                    <!-- End Method Content -->
                </form>
            </div>
            <%@ include file = "footer.jsp" %>
            <!--End Entire Web Page-->
        </div>
    </body>
</html>
