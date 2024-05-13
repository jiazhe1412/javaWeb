<%-- 
    Document   : AdminOrderStatus
    Created on : Apr 4, 2024, 6:22:22 PM
    Author     : User
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.util.*, model.*"%>
<% List<Orders> orderList = (List<Orders>) session.getAttribute("orderlist");%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/AdminOrderStatus.css" rel="stylesheet" type="text/css"/>
        <title>Order Status Management</title>
    </head>
    <body>


        <div class="all">
            <%@ include file = "sideNavForStaff.jsp" %>
            <section id="order">


                <div id="orderContent">
                    <h1>Order Status</h1>
                    <p>Custom View</p>
                    <hr><br>
                    <table id="orderList">
                        <tr><td colspan="7"> </td></tr>

                        <tr>
                            <th><input type="checkbox" id="all" name="all" ></th>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th class="custName">Customer</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>



                        <%
                            if (orderList != null) {
                                for (int i = 0; i < orderList.size(); ++i) {
                                    Orders order = orderList.get(i);%>

                        <tr>

                            <td align="center"><input type="checkbox"  name="<%= order.getOrderid()%>"/></td>
                            <td><%= order.getOrderid()%></td>
                            <td>
                                <%
                                    if (!order.getPaymentList().isEmpty()) {
                                        Date date = order.getPaymentList().get(0).getPaymentdate();
                                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                        String paymentDate = dateFormat.format(date);
                                %>
                                <%= paymentDate%>
                                <% } else {
                                        out.println("none");
                                    }%>
                            </td>
                            <td><%= order.getCustomerid().getCustomerId()%></td>
                            <td>
                                <% if (!order.getPaymentList().isEmpty()) {%>
                                <%= order.getPaymentList().get(0).getTotalamount()%>
                                <% } else {
                                        out.println("none");
                                    }%>
                            </td>
                            <td>
                                <% out.println("<form action=\"../../OrderStatusUpdate\" method=\"GET\" id=\"" + order.getOrderid() + "\">");
                                    if (!order.getStatus().equals("PENDING")) {
                                %>


                                <%
                                    String select1 = "", select2 = "", select3 = "", select4 = "", style = "";
                                    if (order.getStatus().equals("PACKAGING")) {
                                        select1 = "selected";
                                        style = "background-color: rgb(235, 196, 115);color:rgb(77, 77, 0);";
                                    } else if (order.getStatus().equals("SHIPPING")) {
                                        select2 = "selected";
                                         style = " background-color: rgb(111, 202, 234);color: rgb(0, 0, 179);";
                                    } else {
                                        select3 = "selected";
                                         style = "background-color: rgb(134, 228, 157);color: rgb(0, 107, 33);";
                                    }
                                %> 
                                <select name="status" style="<%= style %>">
                                    <option value="PACKAGING" <%= select1%>>PACKAGING</option>
                                    <option value="SHIPPING" <%= select2%>>SHIPPING</option>
                                    <option value="DELIVERY" <%= select3%>>DELIVERY</option>
                                </select>
                                <input type="hidden" name="orderid" value="<%= order.getOrderid()%>">
                                <% } else {%>

                                <p style="background-color:rgb(216, 147, 163);color: rgb(179, 0, 33);">PENDING</p>

                                <%  }
                                    out.println("</form>");
                                %>

                            </td>
                            <td>
                                <% if (!order.getStatus().equals("PENDING")) { %>

                                <% out.print("<button type=\"submit\" form=\"" + order.getOrderid() + "\" value=\"Submit\">Update</button>"); %>
                                <% } else { %>
                                <p>-</p>
                                <% } %>
                            </td>
                        </tr>

                        <% }
                            }else {%> 
                            <tr><td colspan="7">No order record(s) found.</td></tr>
                            <% } %>

                    </table>

                </div>
            </section>
        </div>

    </body>
</html>
