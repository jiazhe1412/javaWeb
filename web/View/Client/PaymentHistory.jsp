<%-- 
    Document   : PaymentHistory
    Created on : May 8, 2024, 6:50:24 PM
    Author     : User
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.*, model.*"%>
<% List<Orders> orderList = (List<Orders>) session.getAttribute("orderList");%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/orderRecordCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment History</title>
    </head>
    <body>
        <div class="outlineORbg">
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <div class="orderRecordBg">
                <div class="allContent">
                    <div class="searchContainer">
                        <input class="searchBar" type="text" placeholder="Search">
                    </div>

                    <div class="orderRecordContent">

                        <div style="position: relative; font-size: 1.875rem; line-height: 2.25rem;">
                            <h2>Your Payment History</h2>

                            <form action="homeUser.jsp" style="position: absolute;  right:25px; top: -5px;">
                                <button class="closeBtn">
                                    <i class="fa fa-times"></i>
                                </button>
                            </form>
                        </div>

                        <div class="oRtable">
                            <table>
                                <tr>
                                    <th>No</th>
                                    <th>Payment ID</th>
                                    <th>Pay Date</th>
                                    <th>Total Price</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                </tr>
                                <%
                                    if (orderList != null) {
                                        int paymentcount = 0;
                                        for (int i = 0; i < orderList.size(); ++i) {
                                            Orders order = orderList.get(i);
                                            if (!order.getPaymentList().isEmpty()) {
                                                paymentcount++;
                                %>

                                <tr>
                                    <td><%= i + 1%></td>
                                    <td ><%= order.getPaymentList().get(0).getPaymentid()%></td>
                                    <td>
                                        <%
                                            Date date = order.getPaymentList().get(0).getPaymentdate();
                                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                            String paymentDate = dateFormat.format(date);
                                        %>
                                        <%= paymentDate%>
                                    </td>
                                    <td><%= order.getPaymentList().get(0).getTotalamount()%></td>
                                    <td><%= order.getPaymentList().get(0).getPaymentmethod()%></td>
                                    <td><%= order.getPaymentList().get(0).getPaymentstatus()%></td>
                                </tr>

                                <% } //end if
                                    } //end order forloop
                                    if (paymentcount == 0) {


                                %> 
                                <tr>
                                    <td colspan="6">No payment record found</td>
                                </tr>
                                <% } %>

                                <%
                                } else {%>
                                <tr>
                                    <td colspan="6">No payment record found.</td>
                                </tr>
                                <% }%>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <%@ include file = "footer.jsp" %>

        </div>
    </body>
</html>
