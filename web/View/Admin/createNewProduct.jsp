<%-- 
    Document   : createNewProduct
    Created on : 10 Apr 2024, 8:12:56 pm
    Author     : Thomas Cheam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page import="model.CategoryService"%>

<%
    
    List<Category> categoryList = (List) session.getAttribute("categoryList");
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/createNewProduct.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Product</title>
    </head>
    <body>
        <%@ include file = "sideNavForStaff.jsp" %>
        <div class="createProductBg">
            <div class="createProductInfo">
                <div  style="position: relative;">
                    <h1 style="text-align:center; font-size: 1.875rem; line-height:2.25rem; font-weight: 700;">Create New Product</h1>
                    <div style="position: absolute; right: -10px; top: 5px;">
                        <a href="staffProductPg.jsp" class="closeBtn">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="createProductContent">

                    <form action="AddProductServlet" method="POST">

                        <div class="productFlex">
                            <p class="p1">Category ID: </p>
                            <p class="p2">
                                <select name="categoryid">
                                    <% for (Category category : categoryList) {%>
                                    <option value="<%= category.getCategoryid() %>"><%= category.getCategorytype() %></option>
                                    <% }%>
                                </select>
                            </p>
                        </div>

                        <div class="productFlex">
                            <p class="p1">Product Name: </p>
                            <p class="p2"><input type="text" name="productname" required></p>
                        </div>
                        <div class="productFlex">
                            <p class="p1">Product Info: </p>
                            <p class="p2"><input type="text" name="productinfo" required></p>
                        </div>
                        <div class="productFlex">
                            <p class="p1">Price(RM): </p>
                            <p class="p2"><input type="text" name="price" required></p>
                        </div>
                        <div class="productFlex">
                            <p class="p1">Stock: </p>
                            <p class="p2"><input type="number" name="stock" min="1" max="1000" required></p>
                        </div>


                        <div style="width: fit-content; margin: auto;">
                            <input class="createBtn" type="submit" value="Create" />

                        </div>
                    </form>

                </div>


            </div>
        </div>      
    </body>
</html>
