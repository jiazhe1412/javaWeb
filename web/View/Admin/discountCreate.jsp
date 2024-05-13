<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<% List<Product> productList = (List<Product>) session.getAttribute("ProductList");
    Staff staff = (Staff) session.getAttribute("staff");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Voucher</title>
        <link href="../CSS/discountAdd.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>     
        <div>
            <%@ include file = "sideNavForStaff.jsp" %>
        </div>
        <div class="discountContent">
            <form action="../../DiscountCreate" method="GET">
                <div>
                    <h1 class="title"><strong><u>Create Voucher</u></strong></h1>
                    <table>
                        <tr>
                            <td>Staff Create :</td>
                            <td><input class="text" type="text" name="discountAddStaffCreate" value="<%= staff.getName()%>" readonly></td>
                            <td style="color:red">
                                <%
                                    String staffError = (String) request.getAttribute("staffError");
                                    if (staffError != null) {
                                %>
                                <%=staffError%>
                            </td>
                            <%
                                    session.removeAttribute("staffError");
                                }
                            %>
                        </tr>
                        <tr>
                            <td>Discount Category :</td>
                            <td>
                                <select class="text" name="discountAddSelectCategory">
                                    <option value="Toys">Toys</option>
                                    <option value="Dog Foods">Dog Foods</option>
                                    <option value="Cat Foods">Cat Foods</option>
                                    <option value="Beds and Furnitures">Beds and Furnitures</option>
                                </select>
                            </td>
                        </tr>   
                        <tr>
                            <td>Product :</td>
                            <td><select class="text" name="selectProduct">
                                    <%
                                        if (productList != null) {
                                            for (int i = 0; i < productList.size(); ++i) {
                                                Product product = productList.get(i);
                                    %>

                                    <option value="<%= product.getProductid()%>"><%= product.getProductid()%></option>
                                    <% }
                                        }%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Discount Rate :</td>
                            <td><input class="text" type="text" name="discountAddRate" value="" placeholder="Discount rate..." ></td>
                            <td style="color:red">
                                <%
                                    String discountRateError = (String) request.getAttribute("discountRateError");
                                    if (discountRateError != null) {
                                %>
                                <%=discountRateError%>
                            </td>
                            <%
                                    session.removeAttribute("discountRateError");
                                }
                            %>
                        </tr>
                        <tr>
                            <td>Description :</td>
                            <td><input class="text" type="text" name="decriptionofAddDiscount" value="" placeholder="Describe uses of this voucher..." ></td>
                        </tr>
                        <tr>
                            <td>Date Activate Select :</td>
                            <td><input class="text" type="date" ></td>
                        </tr>
                        <tr>
                            <td>Expire Date Select :</td>
                            <td><input class="text" type="date" name="discountAddExpireDate"></td>
                        </tr>
                    </table>
                    <div class="absolute2">
                        <input class="btnCreate" type="submit" value="Create" />
                        <input class="btnClear" type="reset" value="Clear" />
                        <button class="btnCancel"><a href="discount.jsp">Cancel</a></button>
                    </div>
                </div>      
            </form>
        </div>
    </body>
</html>
