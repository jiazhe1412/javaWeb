<%-- 
    Document   : ProductInformation
    Created on : 28 Mar 2024, 10:07:27 pm
    Author     : Lee
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Discount"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Information</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="../CSS/ProductCss.css" rel="stylesheet" type="text/css"/>
        <script>
            function addToCart() {
                // Check if the add to cart was successful
            <% if (session.getAttribute("placeordersuccess") != null) { %>
                // Show the success message box
                let successMessage = document.getElementById("successMessage");
                successMessage.style.display = "block";

                // Hide the success message box after 3 seconds
                setTimeout(function () {
                    successMessage.style.display = "none";
                }, 3000);
            <% session.removeAttribute("placeordersuccess"); %>
            <% } else if (session.getAttribute("placeorderUnsuccess") != null) {%>
                // Check if the add to cart was unsuccessful due to exceeding quantity
                let quantityExceeded = <%= (session.getAttribute("placeorderUnsuccess") != null)%>
                if (quantityExceeded) {
                    // Show the unsuccess message box
                    let unsuccessMessage = document.getElementById("unsuccessMessage");
                    unsuccessMessage.style.display = "block";

                    // Hide the unsuccess message box after 3 seconds
                    setTimeout(function () {
                        unsuccessMessage.style.display = "none";
                    }, 3000);
            <% session.removeAttribute("placeorderUnsuccess"); %>

                }
            <% }%>
            }
        </script>
    </head>
    <body>


        <%
            Product productInfo = (Product) (session.getAttribute("productInfo") != null ? session.getAttribute("productInfo") : null);
            List<Discount> discountInfo = (List<Discount>) (session.getAttribute("discountInfo") != null ? session.getAttribute("discountInfo") : null);
            String productDescription = (productInfo != null ? productInfo.getProductinfo() : null);
            String[] descriptionParts = (productInfo != null ? productDescription.split("\\|") : new String[]{""});
        %>


        <!--All Body-->
        <div class="bg-gray-100">
            <!--Header-->
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <!--Pop Up Box (Animation)-->
            <div id="successMessage" class="success-message">
                <p>Product successfully added to cart!</p>
            </div>

            <div id="unsuccessMessage" class="unsuccess-message">
                <p>Failed to add product to cart. Excess stock. </p>
            </div>
            <!--Pop Up Box End-->

            <!--Content-->
            <div class="w-2/3 mx-auto py-20">

                <!--Link Box-->
                <div class="mb-10 px-6 py-2 text-sm text-gray-500/50 font-sans border border-gray-500/50 rounded-3xl">
                    <p class="space-x-4">
                        <a href="homeUser.jsp" 
                           class="hover:underline hover:text-black">Home
                        </a>

                        ️<i class="fa fa-arrow-right"></i>
                        <a href="Product.jsp" 
                           class="hover:underline hover:text-black">Product
                        </a>

                        <i class="fa fa-arrow-right"></i> 
                        <a>
                            <%= (productInfo != null ? productInfo.getProductname() : "No Such Product")%>
                        </a>
                    </p>
                </div>

                <!--Link Box End-->

                <!--Product Information-->
                <div class="bg-white xl:p-20 rounded-xl shadow-black/20 shadow-md sm:p-10">
                    <% if (productInfo != null) {%>
                    <!--Info 1-->
                    <div class="justify-center sm:grid sm:grid-cols-1 xl:flex xl:justify-center info1">
                        <div class="xl:w-1/2 sm:w-full info1Above">
                            <h1 class="text-4xl font-bold mb-5"><%= productInfo.getProductname()%></h1>
                            <p class="text-md w-11/12 text-gray-500 text-justify mb-7">
                                <%= (descriptionParts[0] != null ? descriptionParts[0] : "")%>
                            </p>

                            <%
                                Date currentDate = new Date();
                                if (discountInfo.size() != 0) {
                                    int countProduct = 0;
                                    double discountPrice = 0;
                                    for (Discount d : discountInfo) {
                                        if (productInfo.getProductid().equals(d.getProductid().getProductid()) && currentDate.after(d.getActivateDate()) && currentDate.before(d.getExpireDate())) {
                                            countProduct++;
                                            Discount ds = new Discount();
                                            discountPrice = d.calculateDiscountTotalPrice(productInfo.getPrice(), d.getDiscountrate());
                                        }
                                    }
                            %>
                            <% if (countProduct > 0) {%>
                            <p class="relative text-2xl text-green-600 font-semibold font-mono mb-8">
                                RM <%= String.format("%.2f", productInfo.getPrice())%> 
                                <b class="text-6xl rotate-45 absolute left-14 -top-1 bottom-16 font-semibold text-red-500">/</b>
                                <b class="absolute left-32 -top-2 bg-red-500 text-white py-1 px-4 rounded-2xl">
                                    RM <%= String.format("%.2f", discountPrice)%>
                                </b>
                            </p>
                            <% } else {%>
                            <p class="text-2xl text-green-600 font-semibold font-mono mb-8">
                                RM <%= String.format("%.2f", productInfo.getPrice())%>
                            </p>
                            <%
                                } //check the discount

                            } else {
                            %>
                            <p class="text-2xl text-green-600 font-semibold font-mono mb-8">
                                RM <%= String.format("%.2f", productInfo.getPrice())%>
                            </p>
                            <%
                                }
                            %>

                            <form action="../../AddtoCart" method="post">
                                <p class="productAdd">

                                    <%
                                        String quantityTextBox = "<input class=\"bg-slate-200/30 border border-gray-300 rounded-3xl pl-7 pr-2 py-2 w-32 text-md focus:bg-white focus:outline-green-500\" type=\"number\"";

                                        if (session.getAttribute(
                                                "quantity") != null) {

                                            quantityTextBox += " value=\"" + session.getAttribute("quantity") + "\"";
                                        } else {

                                            quantityTextBox += " value=\"1\"";
                                        }

                                        quantityTextBox
                                                += " min=\"1\" max=\"" + productInfo.getStockqty()
                                                + "\" name=\"quantity\"/>";
                                    %>
                                    <%= quantityTextBox%>
                                    <input class="bg-green-500 py-2 px-4 text-white font-bold rounded-2xl mx-2 text-lg
                                           sm:mx-0 sm:my-2 md:mx-2 lg:mx-2 xl:mx-2 2xl:mx-2
                                           hover:bg-green-700" onclick="addToCart()" 
                                           type="submit" value="Add to Cart"/>
                                </p>
                                <p class="my-4 mx-2">In Stock: <%= productInfo.getStockqty()%></p>
                            </form>

                        </div>
                        <div class="xl:w-1/2 justify-center grid sm:w-full info1Above">
                            <img class="imageProduct" src="../image/<%= productInfo.getImagepath()%>" alt="alt" width="460"/>
                        </div>
                    </div>
                    <!--End Info 1-->

                    <!--Info 2-->
                    <div class="mt-20 info2below">
                        <div>
                            <h1 class="text-4xl font-bold mb-5">Product Details</h1>
                            <hr class="border border-gray-300 mb-10">
                            <div class="text-md w-11/12 text-gray-500 text-justify mb-7">
                                <p class="font-semibold mb-2 underline">Product Description</p>
                                <p class="mb-4">
                                    <%= (descriptionParts[1] != null ? descriptionParts[1] : "")%>
                                </p>
                                <ul class="list-disc pl-5">

                                    <%
                                        for (int i = 2;
                                                i < descriptionParts.length;
                                                i++) {
                                    %>
                                    <li><%= (descriptionParts[i] != null ? descriptionParts[i] : "")%></li>
                                        <% } %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--End Info 2-->
                    <%} else {%>
                    <h1 class="text-center text-2xl py-20">404 Error Occur</h1>
                    <%}%>
                </div>
                <!--End Product Information-->


            </div>
            <!--End Content-->

            <footer>
                <%@ include file = "footer.jsp" %>
            </footer>
        </div> 
        <!--End Entire Body-->
    </body>
</html>
