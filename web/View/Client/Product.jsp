<%-- 
    Document   : ProductPage
    Created on : 28 Mar 2024, 1:08:11 pm
    Author     : Lee
--%>

<%@page import="java.util.Date"%>
<%@page import="model.Discount"%>
<%@page import="controller.ProductList"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Page</title>
        <link href="../CSS/ProductCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <%
            List<Category> categoryList = (List) session.getAttribute("categoryList");
            List<Product> productList = (List) session.getAttribute("productList");
            String category = (String) (session.getAttribute("category") != null ? session.getAttribute("category") : "All");
            String searchProduct = (String) (session.getAttribute("searchProduct") != null ? session.getAttribute("searchProduct") : "");
            List<Discount> discountList = (List) session.getAttribute("discountList");

            boolean productsFound = false;

            Date currentDate = new Date();
        %>
        <div class="bg-gray-100">
            <!--Header-->
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <div class="w-5/6 mx-auto py-5">

                <!--Product Header-->
                <div class="ml-20 mr-20">
                    <div class="flex"> 
                        <!--category 1-->
                        <div class="w-1/6 category1"> 
                            <p class="font-bold text-3xl font-sans">All Product</p>
                        </div>

                        <!--category 2-->
                        <div class="w-5/6 text-right h-fit my-auto text-md category 2 font-semibold">
                            <div class="lg:hidden xl:hidden smallCategory text-xl">
                                <i class='fa fa-list'>
                                </i>

                            </div> 
                            <div class="w-full lg:flex xl:flex 2xl:flex justify-end items-center productCategory text-center">



                                <% if (categoryList != null) {%>

                                <form action="../../ProductCategory" method="post">
                                    <p class="w-32">
                                        <input type="submit" value="All" name="category" 
                                               class="${category != null && category != "All" ? 'text-black py-1 px-4 rounded-3xl hover:underline active:no-underline active:bg-green-500 active:text-white cursor-pointer' : 'text-white bg-green-500 py-1 px-4 rounded-3xl'}" />
                                    </p>
                                </form>    
                                <% for (Category c : categoryList) {
                                        if (category.equals(c.getCategorytype())) {
                                %>
                                <form action="../../ProductCategory" method="post">
                                    <p class="w-44">
                                        <input class="text-white bg-green-500  py-1 px-4 rounded-3xl"
                                               value="<%= c.getCategorytype()%>" type="submit" name="category"/> 
                                    </p>
                                </form>

                                <%} else {%>
                                <form action="../../ProductCategory" method="post">
                                    <p class="w-44">
                                        <input class="text-black px-4 rounded-3xl 
                                               hover:underline active:no-underline  py-1 px-4 active:bg-green-500 active:text-white cursor-pointer"
                                               value="<%= c.getCategorytype()%>" type="submit" name="category"/> 
                                    </p>
                                </form>

                                <%}
                                        }//end for
                                    } //end if
                                %>

                            </div>
                        </div>
                    </div>
                    <hr class="border-black mt-3"/>
                </div>
                <!--End Header-->

                <!--Search Bar-->
                <div class="text-center mt-8">
                    <form action="../../serachBar" method="post">
                        <input name="searchProduct" type="text" class="xl:w-1/3 lg:w-1/2 py-3 px-4 rounded-xl border-2 border-black/20 searchBar hover:border-slate-500"
                               placeholder="Search By Product Name"
                               value="<%= (!searchProduct.equals("") ? searchProduct : "")%>"
                               />
                        <input 
                            class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 mx-4 rounded"
                            type="submit" 
                            value="Search"/>

                    </form>
                </div>
                <!--End Search Bar-->

                <!--Product List-->
                <div class="grid gap-2 mx-auto w-fit 2xl:grid-cols-4 xl:grid-cols-3 lg:grid-cols-2 md:grid-cols-2 sm:grid-cols-1 productList" id="productLists">
                    <% if (productList != null && productList.size() != 0 && discountList != null && discountList.size() != 0) {
                            // Loop through the products
                            for (Product product : productList) {
                    %>

                    <!-- Search Product -->        
                    <% if ((product.getProductname().toLowerCase().contains(searchProduct.toLowerCase()) || searchProduct.equals(""))) {
                            if (category.equals("All") || product.getCategoryid().getCategorytype().equals(category)) {
                    %>        
                    <% productsFound = true;
                        int countProduct = 0;
                        double discountPrice = 0;
                    %>

                    <%
                        for (Discount discount : discountList) {
                    %>


                    <% if (discount.getProductid().getProductid().equals(product.getProductid()) && currentDate.after(discount.getActivateDate()) && currentDate.before(discount.getExpireDate())) {
                                countProduct++;
                                Discount d = new Discount();
                                discountPrice = d.calculateDiscountTotalPrice(product.getPrice(), discount.getDiscountrate());
                            }
                        } //discount for
                    %>
                    <div class="w-80 h-96 flex flex-col justify-center items-center">
                        <div class="bg-white w-fit p-5 rounded-2xl 
                             hover:scale-110 transition ease-in-out delay-150 duration-200 cursor-pointer
                             hover:shadow-2xl hover:shadow-gray-500 shadow-sm shadow-gray-900">
                            <% if (countProduct > 0) {%>


                            <a href="../../ProductInformation?id=<%= product.getProductid()%>" 
                               class="flex flex-col justify-center items-center">
                                <img class="imageProduct" src="../image/<%= product.getImagepath()%>" alt="alt" width="230"/>
                                <p class="font-bold py-1"><%= product.getProductname()%></p>
                                <p class="font-bold py-0.5 px-3 relative bg-green-300 rounded-xl text-black/70">
                                    RM <%= product.getPrice()%>
                                    <b class="text-6xl rotate-45 absolute left-14 -top-1 bottom-16 font-semibold text-red-500">/</b>
                                    <b class="absolute -top-2 left-24 bg-red-500 py-2 px-1 rounded-2xl text-white w-28 text-center">
                                        RM <%= String.format("%.2f", discountPrice)%>
                                    </b>
                                </p> 
                            </a>
                            <% } else {%>
                            <a href="../../ProductInformation?id=<%= product.getProductid()%>" 
                               class="flex flex-col justify-center items-center">
                                <img class="imageProduct" src="../image/<%= product.getImagepath()%>" alt="alt" width="230"/>
                                <p class="font-bold py-1 text-center "><%= product.getProductname()%></p>
                                <p class="font-bold py-0.5 px-3 bg-green-300 rounded-xl text-black/70">RM <%= product.getPrice()%></p> 
                            </a>
                            <% } %>
                        </div>
                    </div>
                    <%

                                    } //category 
                                } // search 
                            } //product list for
                        } //if product and category list is null

                    %>


                    <% if (!productsFound) { %>
                    <div class="col-span-4 my-20">
                        <h1 class="text-2xl bg-white w-fit p-20 rounded-2xl shadow-sm shadow-gray-900">No Products in This Category</h1>
                    </div>
                    <% }%> 
                </div>
                <!--End Product List-->

            </div><!--All Content-->
            <footer>
                <%@ include file = "footer.jsp" %>
            </footer>
        </div>
        <!--End ALL Body-->
    </body>
</html>


<!--<p class="w-32">
    <a href="Product.jsp" class="text-white bg-green-500 py-1 px-4 rounded-3xl">
        All
    </a> 
</p>-->

<!--<p class="w-32">
    <button class="text-black py-1 px-4 rounded-3xl 
            hover:underline active:no-underline active:bg-green-500 active:text-white">
        Toys
    </button> 
</p>-->

<!--Content
<div class="w-80 h-96 flex flex-col justify-center items-center">
    <div class="bg-white w-fit p-5 rounded-2xl 
         hover:scale-110 transition ease-in-out delay-150 duration-200 cursor-pointer
         hover:shadow-2xl hover:shadow-gray-500 shadow-sm shadow-gray-900">
        <a href="ProductInformation.jsp" 
           class="flex flex-col justify-center items-center">
            <img class="imageProduct" src="../image/logo.png" alt="alt" width="230"/>
            <p class="font-bold py-1">Product Name</p>
            <p class="font-bold py-1">Price</p> 
        </a>
    </div>
</div>
End Content

Discount Content
<div class="w-80 h-96 flex flex-col justify-center items-center">
    <div class="bg-white w-fit p-5 rounded-2xl 
         hover:scale-110 transition ease-in-out delay-150 duration-200 cursor-pointer
         hover:shadow-2xl hover:shadow-gray-500 shadow-sm shadow-gray-900">
        <a href="ProductInformation.jsp" 
           class="flex flex-col justify-center items-center">
            <img class="imageProduct" src="../image/logo2.png" alt="alt" width="230"/>
            <p class="font-bold py-1">Product Name</p>
            <p class="font-bold py-1 relative">
                Price
                <b class="text-5xl rotate-45 absolute left-7 -top-1 bottom-16 font-semibold text-red-500">/</b>
                <b class="absolute -top-1 left-12 bg-red-500 py-2 px-3 rounded-2xl
                   text-white">Discount
                </b>
            </p> 
        </a>
    </div>
</div>
End Content-->



