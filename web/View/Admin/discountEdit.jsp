<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@page import="controller.*"%>
<% List<Product> productList = (List<Product>) session.getAttribute("ProductList");
    Staff staff = (Staff) session.getAttribute("staff");
    String discountid = (String)request.getAttribute("discountid");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Voucher</title>
        <link href="../CSS/discountEdit.css" rel="stylesheet" type="text/css"/>

    </head>

    <body>   
        <div>
            <%@ include file = "sideNavForStaff.jsp" %>
        </div>
        <div class="discountContent">
            <form action="../../DiscountEdit" method="POST">
                <div>
                    <h1 class="title"><strong><u>Edit Voucher</u></strong></h1>
                    <table>
                        <tr>
                            <td>Staff Create :</td>
                            <td><input class="text" type="text" name="staffCreate" value="<%= staff.getName()%>" readonly>
                                <input type="hidden" value="<%= discountid %>" name="discountid">
                            </td>
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
                            <td><select class="text" name="selectCategory">
                                    <option value="Toys">Toys</option>
                                    <option value="Dog Foods">Dog Foods</option>
                                    <option value="Cat Foods">Cat Foods</option>
                                    <option value="Beds and Furnitures">Beds and Furnitures</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>Product :</td>
                            <td><select class="text" name="selectProductEdit">
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
                            <td><input class="text" type="text" name="discountRate" value="" placeholder="Discount Rate..." ></td>
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
                            <td><input class="text" type="text" name="decriptionofDiscountEdit" value="" placeholder="Describe uses of this voucher..." ></td>
                        </tr>
                        <tr>
                            <td>Date Activate Select :</td>
                            <td><input class="text" type="date" ></td>
                        </tr>
                        <tr>
                            <td>Expire Date Select :</td>
                            <td><input class="text" type="date"  name="ExpireDate"></td>
                        </tr>
                    </table>
                    <div class="absolute2">
                        <input class="btnEdit" type="submit" value="Edit" />
                        <input class="btnClear" type="reset" value="Clear" />
                        <button class="btnCancel" onclick="discount.jsp">Cancel</button>
                    </div>
                </div>      
            </form>

        </div>
    </body>
</html>
