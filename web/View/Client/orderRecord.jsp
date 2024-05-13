<%-- 
    Document   : orderRecord
    Created on : 8 Apr 2024, 6:53:39 pm
    Author     : Thomas Cheam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*, model.*"%>
<% List<Orders> orderList = (List<Orders>) session.getAttribute("orderList");%>

<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/orderRecordCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                            <h2>Your Order Record</h2>

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
                                    <th>Order ID</th>
                                    <th>Customer ID</th>
                                    <th>Shipping address</th>
                                    <th>Status</th>
                                </tr>
                                <%
                                    if (orderList != null) {
                                    int ordercount = 0;
                                        for (int i = 0; i < orderList.size(); ++i) {
                                            Orders order = orderList.get(i);
                                            ordercount++;%>
                                <tr>
                                    <td><%= i+1 %></td>
                                    <td><%= order.getOrderid()%></td>
                                    <td><%= order.getCustomerid().getCustomerId()%></td>
                                    <td>
                                        <% if (!order.getPaymentList().isEmpty()) {%>
                                        <%= order.getPaymentList().get(0).getShipaddress()%>
                                        <% } else {
                                                out.println("none");
                                            }%>
                                    </td>
                                    <td>
                                        <% if (order.getStatus().equals("PENDING")) { %>
                                        <div class="status pending">PENDING</div>
                                        <% } else if (order.getStatus().equals("PACKAGING")) { %>
                                        <div class="status packaging">PACKAGING</div>
                                        <% } else if (order.getStatus().equals("SHIPPING")) { %>
                                        <div class="status shipping">SHIPPING</div>
                                        <% } else { %>
                                        <div class="status delivered">DELIVERED</div>
                                        <% }
                                            }
                                       
                                        %>
                                        
                                    </td>
                                     <% if (ordercount == 0) { %>
                                     <tr>
                                    <td colspan="6">No order record found</td>
                                </tr>
                               
                                <% } %>
                                    <% }else{ %>
                                    <td colspan="5">No order record(s) found.</td>
                                    <% } %>
                                </tr>


                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <%@ include file = "footer.jsp" %>

        </div>
    </body>
</html>
