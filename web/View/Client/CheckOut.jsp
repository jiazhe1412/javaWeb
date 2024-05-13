<%-- 
    Document   : Payment
    Created on : Mar 28, 2024, 5:52:31 PM
    Author     : User
--%>
<%@page import="java.util.Date"%>
<%@page import="model.Discount"%>
<%@page import="model.Placeorder"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment</title>
        <link href="../CSS/CheckOut.css" rel="stylesheet" type="text/css"/>
    </head>

    <%
        List<Placeorder> placeorderList = (List<Placeorder>) session.getAttribute("cartList");
        List<Discount> discountInfo = (List<Discount>) (session.getAttribute("discountList") != null ? session.getAttribute("discountList") : null);

    %>
    <body>
        <script>
            function openMethod(evt, methodType) {
                var i, tabcontent, tablinks;

                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }

                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                    document.getElementById("paymentMethod").value = methodType;
                }
                document.getElementById(methodType).style.display = "block";
                evt.currentTarget.className += " active";
                event.preventDefault();

            }
        </script>

        <!-- retrieve the error message in session if have-->

        <%            boolean errorCheck = false;
            String[] errorList = new String[10];

            if (session.getAttribute("paymentError") != null) {
                errorList = (String[]) session.getAttribute("paymentError");
                errorCheck = true;

            } else {
                for (int i = 0; i < errorList.length; i++) {
                    errorList[i] = "";
                }
            }


        %>


        <% if (errorCheck == true) {
                if (errorList[0].equals("creditCard")) {%>
        <script>
            document.getElementById("creditCard").style.display = "block";
        </script>

        <% } else if (errorList[0].equals("cash")) {%>
        <script>
            document.getElementById("cash").style.display = "block";
        </script>

        <% } else if (errorList[0].equals("e-wallet")) {%>
        <script>
            document.getElementById("ewallet").style.display = "block";
        </script>

        <%    }
            }%>



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
                            <div class="main current"></div>
                            <span class="text done">CheckOut</span>
                        </div>
                        <div class="point">
                            <div class="main"></div>
                            <span class="text">Review</span>
                        </div>
                        <div class="point">
                            <div class="main"></div>
                            <span class="text">Finish</span>
                        </div>
                    </div>
                </div>

                <form action="../../PaymentDetailCheck" method="POST">

                    <!-- The Column that required user to insert their detail 
                         like payment info, customer info and shipping address. -->
                    <div class="paymentContent">

                        <div class="left">
                            <!-- Payment Method Info -->
                            <div class="detail">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px">
                                    <h2 class="head">Payment Info</h2>
                                    <p class="required">Required *</p>
                                </div>
                                <hr class = "headerBottom">
                                <h3>Select Payment Method:</h3>

                                <!--Tab Link--> 
                                <div class="tab">
                                    <button class="tablinks" onclick="openMethod(event, 'creditCard')" name="card">Credit Card</button>
                                    <button class="tablinks" onclick="openMethod(event, 'ewallet')" name="wallet">E-Wallet</button>
                                    <button class="tablinks" onclick="openMethod(event, 'cash')" name="cash">Cash</button>
                                    <input type="hidden" value="none" id="paymentMethod" name="paymentMethod">
                                    <p style="color:red;">
                                        <% if (errorCheck == true) {
                                                if (!errorList[0].equals("none")) {
                                        %>
                                        <%= errorList[0]%>
                                        <% }
                                            } %>
                                    </p>
                                </div>

                                <!-- Tab Info -->
                                <!-- content of each tab -->

                                <!-- Credit Card Tab Content -->
                                <div id="creditCard" class="tabcontent">
                                    <div>
                                        <table>
                                            <tr>
                                                <td colspan='3'>
                                                    <select class='type' name="cardType">
                                                        <option value="visa">VISA</option>
                                                        <option value="mastercard">MASTERCARD</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <label>Full Name *</label><br><br>
                                                    <input type = "text" class = "textfield" name="cardName">
                                                    <p style="color:red;">
                                                        <% if (errorCheck == true) {
                                                                if (!errorList[1].equals("none")) {
                                                        %>
                                                        <%= errorList[1]%>
                                                        <% }
                                                            } %>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <br>
                                                    <label>Card Number *</label><br><br>
                                                    <input type = "text" class = "textfield" name="cardNum">
                                                    <p style="color:red;">
                                                        <% if (errorCheck == true) {
                                                                if (!errorList[2].equals("none")) {
                                                        %>
                                                        <%= errorList[2]%>
                                                        <% }
                                                            } %>
                                                    </p><br><br>
                                                </td>  
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>Expiry Date (MM/YY) *</label><br><br>
                                                    <input type = "text" class = "textfield" name="expDate"><br><br>  
                                                    <p style="color:red;">
                                                        <% if (errorCheck == true) {
                                                                if (!errorList[3].equals("none")) {
                                                        %>
                                                        <%= errorList[3]%>
                                                        <% }
                                                            } %>
                                                    </p>
                                                </td>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <label>CCV *</label><br><br>
                                                    <input type = "text" class = "textfield" name="cvv"><br><br>
                                                    <p style="color:red;">
                                                        <% if (errorCheck == true) {
                                                                if (!errorList[4].equals("none")) {
                                                        %>
                                                        <%= errorList[4]%>
                                                        <% }
                                                            } %>
                                                    </p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <!-- End Credit Card Tab Content -->

                                <!-- E - Wallet tab content -->
                                <div id="ewallet" class="tabcontent">
                                    <h3>E-Wallet</h3>
                                    <select class='type' name="walletType">
                                        <option value="touchandgo">Touch 'n go</option>
                                        <option value="paypal">Paypal</option>
                                        <option value="shopeePay">Shopee Pay</option>
                                        <option value="grabPay">Grab Pay</option>
                                    </select>
                                </div>
                                <!-- End E - Wallet tab content -->

                                <!-- Cash Tab Content -->
                                <div id="cash" class="tabcontent">
                                    <p>Please pay on our counter in 7 days after place the order.</p>
                                </div>
                                <!-- End Cash Tab Content -->
                            </div>

                            <!-- Customer Info -->
                            <div class = "detail">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px">
                                    <h2 class="head">Customer Info</h2>
                                    <p class="required">Required *</p>
                                </div>
                                <hr class = "headerBottom">
                                <label>Email *</label><br><br>
                                <input type = "email" class="textfield" name="email" required><br><br>
                            </div>
                            <!-- End Customer Info -->


                            <!--<hr class = "separate">-->

                            <!-- Shipping detail -->
                            <div class = "detail">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px">
                                    <h2 class="head">Shipping Address</h2>
                                    <p class="required">Required *</p>
                                </div>
                                <hr class = "headerBottom">
                                <label>Full Name *</label><br><br>
                                <input type = "text" class = "textfield" name="fullname" required>
                                <p style="color:red;">
                                    <% if (errorCheck == true) {
                                            if (!errorList[5].equals("none")) {
                                    %>
                                    <%= errorList[5]%>
                                    <% }
                                        } %>
                                </p><br><br>
                                <br>
                                <label>Street Address *</label><br><br>
                                <input type = "text" class = "textfield" name="street1" required><br><br>
                                <input type = "text" class = "textfield" name="street2" required>
                                <p style="color:red;">
                                    <% if (errorCheck == true) {
                                            if (!errorList[6].equals("none")) {
                                    %>
                                    <%= errorList[6]%>
                                    <% }
                                        } %>
                                </p><br><br>
                                <br>
                                <div>
                                    <table>
                                        <tr>
                                            <td>
                                                <label>City *</label><br><br>
                                                <input type = "text" class = "textfield" name="city" required><br><br>


                                            </td>
                                            <td>&nbsp;</td>
                                            <td>
                                                <label>State *</label><br><br>
                                                <input type = "text" class = "textfield" name="state" required><br><br>


                                            </td>
                                            <td>&nbsp;</td>
                                            <td>
                                                <label>Zip/Postal Code *</label><br><br>
                                                <input type = "text" class = "textfield" name="zip" required><br><br>


                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p style="color:red;">
                                                    <% if (errorCheck == true) {
                                                            if (!errorList[7].equals("none")) {
                                                    %>
                                                    <%= errorList[7]%>
                                                    <% }
                                                        } %>
                                                </p>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>
                                                <p style="color:red;">
                                                    <% if (errorCheck == true) {
                                                            if (!errorList[8].equals("none")) {
                                                    %>
                                                    <%= errorList[8]%>
                                                    <% }
                                                        } %>
                                                </p>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>
                                                <p style="color:red;">
                                                    <% if (errorCheck == true) {
                                                            if (!errorList[9].equals("none")) {
                                                    %>
                                                    <%= errorList[9]%>
                                                    <% }
                                                        }%>
                                                </p>
                                            </td>

                                        </tr>
                                    </table>
                                </div>
                            </div>    
                            <!-- End Shipping detail -->

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
                                                }
                                            %>

                                        <tr>



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
                                            if (totalprice
                                                    < 1000) {
                                                deliveryfees = 25.0;
                                                totalprice += deliveryfees;
                                            }

                                            session.setAttribute(
                                                    "total", totalprice);
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
