<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.util.*, model.*"%>
<% List<Discount> discountList = (List<Discount>) session.getAttribute("DiscountList");%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Discount</title>
        <!-- To link css -->
        <link href="../CSS/discount.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@ include file = "sideNavForStaff.jsp" %>
        <div class="background">
            <div class="content">
                <div class="content1">
                    <form action="discountAdd.jsp" method="GET">
                        <div class="btnSearchBar">
                            <input class="tfSearch" type="text" name="searchVoucher" value="" >
                            <input  class="btnSearch" type="submit" value="Search" />
                            <input  class="btnClear" type="reset" value="Clear Text" />
                        </div>
                    </form>
                </div>
                <div class="addButton">
                    <p><button onclick="document.location = '../../ProductSelect'"><i class="fa fa-plus" aria-hidden="true"></i> Add Voucher</button></p>
                </div>
                <div class="content2">
                    <table class="discountTable">
                        <tr>
                            <th>Discount ID</th>
                            <th>Product ID</th>
                            <th>Staff Created</th>
                            <th>Discount Category</th>
                            <th>Discount Rate</th>
                            <th>Description</th>
                            <th>Date Activate</th>
                            <th>Expire Date</th>
                        </tr>

                        <%
                            if (discountList != null) {
                                for (int i = 0; i < discountList.size(); ++i) {
                                                                   Discount discount = discountList.get(i);%>


                        <tr>
                            <td><%= discount.getDiscountid()%></td>
                            <td><%= discount.getProductid().getProductid()%></td>          
                            <td><%= discount.getStaffCreated()%></td>
                            <td><%= discount.getDiscounttype()%></td>
                            <td><%= discount.getDiscountrate()%></td>
                            <td><%= discount.getDiscountDescription()%></td>
                            <%
                                Date date = discount.getActivateDate();
                                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                String activateDate = dateFormat.format(date);
                                
                                date = discount.getExpireDate();
                                dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                 String expiryDate = dateFormat.format(date);
                            %>
                            <td><%= activateDate%></td>
                            <td><%= expiryDate%></td>
                            <td><a href="../../DiscountDelete?discountid=<%= discount.getDiscountid()%>">Delete️</a></td>
                            <td><a href="../../ProductSelectEdit?discountid=<%= discount.getDiscountid()%>">Edit</a></td>
                        </tr>
                        <% }
                                                        }%> 

                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
