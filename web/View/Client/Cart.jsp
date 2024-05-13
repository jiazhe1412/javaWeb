<%-- 
    Document   : ProductPage
    Created on : 28 Mar 2024, 1:08:11 pm
    Author     : Lee
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
        <title>Cart</title>
        <link href="../CSS/ProductCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>


    <body>
        <%
            List<Placeorder> placeorderList = (List<Placeorder>) session.getAttribute("cartList");
            List<Discount> discountInfo = (List<Discount>) (session.getAttribute("discountList") != null ? session.getAttribute("discountList") : null);
        %>
        <div class="bg-gray-100">
            <!--Header-->
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>

            <div class="py-20">
                <!--Link Box-->
                <div class="w-2/3 mx-auto mb-10 px-6 py-2 text-sm text-gray-500/50 font-sans border border-gray-500/50 rounded-3xl">
                    <p class="space-x-4">
                        <a href="" 
                           class="hover:underline hover:text-black">Home
                        </a>

                        ️<i class="fa fa-arrow-right"></i>
                        <a>Cart</a>

                    </p>
                </div>
                <!--Link Box End-->

                <!--Content-->
                <div class="w-2/3 mx-auto bg-white xl:p-20 rounded-xl shadow-black/20 shadow-md sm:p-10 cartContent">
                    <h1 class="text-4xl font-bold mb-5">Your Cart</h1>
                    <hr class="border border-gray-300 mb-1">
                    <!--Cart Product-->
                    <table class="min-w-full text-center text-md">
                        <tr class="text-lg">
                            <th class="w-1/3">Item</th>
                            <th class="w-1/3">&nbsp;</th>
                            <th class="w-1/3">Quantity</th>
                        </tr>

                        <%                            if (placeorderList != null) {
                                for (Placeorder p : placeorderList) {
                        %>

                        <tr class="text-lg text-gray-500 font-semibold">
                            <td colspan="2" class="w-1/2">
                                <div class="xl:flex justify-center items-center sm:grid sm:grid-cols-1">
                                    <img class="imageProduct" src="../image/<%= p.getProductid().getImagepath()%>" alt="Product" width="250"/>
                                    <div class="text-left w-2/3 mx-auto">
                                        <p><%= p.getProductid().getProductname()%></p>

                                        <%
                                            Date currentDate = new Date();
                                            if (discountInfo.size() != 0) {
                                                int countProduct = 0;
                                                double discountPrice = 0;
                                                for (Discount d : discountInfo) {
                                                    if (p.getProductid().getProductid().equals(d.getProductid().getProductid()) && currentDate.after(d.getActivateDate()) && currentDate.before(d.getExpireDate())) {
                                                        countProduct++;
                                                        Discount ds = new Discount();
                                                        discountPrice = d.calculateDiscountTotalPrice(p.getProductid().getPrice(), d.getDiscountrate());

                                                    }
                                                }
                                        %>
                                        <% if (countProduct > 0) {%>
                                        <p>
                                            RM <%= String.format("%.2f", discountPrice)%>
                                        </p>
                                        <% } else {

                                        %>
                                        <p>
                                            RM <%= String.format("%.2f", p.getProductid().getPrice())%>
                                        </p>
                                        <%
                                                }
                                            }
                                        %>

                                        <%
                                            if (session.getAttribute("editQuantity") == null) {
                                                String editLink = "<a href=\"../../EditQuantity?placeorderID=" + p.getPlaceorderid() + "\"" + "class=\"text-blue-500 font-bold underline hover:text-blue-700 active:text-blue-900 mr-2\">Edit</a>";
                                                out.print(editLink);
                                            }

                                            String deleteButton = "<a href=\"../../DeletePlaceOrder?placeorderID=" + p.getPlaceorderid() + "\" class=\"text-red-500 font-bold underline hover:text-red-700 active:text-red-900\" onclick=\"return window.confirm('Are you sure you want to delete this item?')\">Remove</a>";
                                            out.print(deleteButton);
                                        %>
                                    </div>
                                </div> 
                            </td>
                            <td class="w-1/2">
                                <form action="../../UpdateQuantity" method="post">
                                    <%
                                        String placeorderID = (String) session.getAttribute("placeorderID");

                                        String quantityTextBox = "<input  ";
                                        quantityTextBox += "type=\"number\" value=\"" + p.getQuantity() + "\" name=\"quantityBox\"";

                                        if (session.getAttribute("editQuantity") != null && placeorderID.equals(p.getPlaceorderid())) {
                                            if (session.getAttribute("error") != null) {
                                                out.print("<p class=\"text-red-500 bg-red-100 px-2 rounded-md mb-2\">" + session.getAttribute("error") + "</p>");
                                            }
                                            quantityTextBox += " class=\"bg-slate-200/20 border border-gray-300 rounded-2xl pl-7 pr-2 py-2 w-28 text-md focus:bg-white focus:outline-green-500\" />";
                                        } else {
                                            quantityTextBox += " readonly class=\"bg-slate-200/20 border border-gray-300 rounded-2xl pl-7 pr-2 py-2 w-28 text-md \"/>";
                                        }

                                        out.print("" + quantityTextBox + "<br/>");
                                    %>

                                    <%
                                        if (session.getAttribute("editQuantity") != null && placeorderID.equals(p.getPlaceorderid())) {
                                    %>
                                    <p class="mt-3">
                                        <% out.print("<input type=\"hidden\" value=\"" + p.getProductid().getStockqty() + "\" name=\"maxQuantity\" />");%>

                                        <% out.print("<input type=\"hidden\" value=\"" + p.getPlaceorderid() + "\" name=\"placeOrderID\" />");%>
                                        <% out.print("<input type=\"hidden\" value=\"" + p.getProductid().getProductid() + "\" name=\"productID\" />");%>
                                        <% out.print("<input type=\"hidden\" value=\"" + p.getOrderid() + "\" name=\"orderID\" />");%>
                                        <% out.print("<input type=\"hidden\" value=\"" + p.getPlaceordernum() + "\" name=\"placeorderNum\" />");%>
                                        <input class="bg-red-500 font-bold
                                               hover:bg-red-700 active:bg-red-900 text-white py-2 px-4 rounded-xl" 
                                               type="submit" name="button" value="Cancel"/>
                                        <input class="bg-blue-500 font-bold
                                               hover:bg-blue-700 active:bg-blue-900 text-white py-2 px-4 rounded-xl"
                                               type="submit" name="button" value="Update"/>
                                    </p>

                                    <% } %>
                                </form>
                            </td>
                        </tr>

                        <%
                                }
                            }
                        %>
                    </table>
                    <!--End Cart Product-->
                    <div class="grid xl:grid-cols-2 w-fit mx-auto text-white font-bold justify-center cartButton
                         sm:grid-cols-1 sm:mt-10 sm:space-y-3 xl:space-y-0
                         ">
                        <form action="../../ClearAllCart" method="post" class="py-4 px-6 bg-red-300 rounded-xl
                                   hover:bg-red-500 active:bg-red-800 mx-4 text-right" >
                            <input type="submit" value="Clear Cart"  class="text-center"/>
                        </form>

                        <a href="CheckOut.jsp">
                            <button class="py-4 px-6 bg-green-300 rounded-xl
                                    hover:bg-green-500 active:bg-green-800 mx-4">
                                Proceed to Payment
                            </button>
                        </a>
                    </div>
                </div>
            </div>
            <!--End Content-->
            <footer>
                <%@ include file = "footer.jsp" %>
            </footer>
        </div>
    </body>
</html>

