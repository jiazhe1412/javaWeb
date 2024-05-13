<%-- 
    Document   : staffPPasswdChg
    Created on : 4 Apr 2024, 7:53:05 pm
    Author     : Thomas Cheam
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@page import="model.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/updateProductCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <%
            Product product = (Product) session.getAttribute("productinfo");
            if (product != null) {
        %>

        <div class="updProdBg">
            <div class="updProdInfo">
                <h1 style="text-align:center; font-size: 1.875rem; line-height:2.25rem; font-weight: 700; position: relative;">Product Info Delete
                    <a href="staffProductPg.jsp" style="position:absolute; right: 0; top: -5px;">
                        <button class="closeBtn">
                            <i class="fa fa-times"></i>
                        </button>
                    </a>
                </h1>

                <form action="DeleteProduct" method="post">
                    <div class="updProdContent  ">
                        <div>
                            <p>Product ID:<span><input type="text" name="productid" value="<%=product.getProductid()%>" readonly/></span></p>
                        </div>

                        <div>
                            <p>Product Name:<span><input type="text" name="productname" value="<%=product.getProductname()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Product Info:<span><input type="text"  name="productinfo" value="<%=product.getProductinfo()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Price(RM):
                                <span>
                                    <input type="text" name="price" value="<%=product.getPrice()%>" readonly>
                                </span>

                            </p>
                        </div>
                        <div>
                            <p>Stock:
                                <span>
                                    <input type="text" name="stock" value="<%=product.getStockqty()%>" readonly>
                                </span>
                            </p>
                        </div>
                        <div>
                            <p><label>Category ID:</label>
                                <select name="categoryid">
                                    <option value="1001">1001</option>
                                    <option value="1002">1002</option>
                                    <option value="1003">1003</option>
                                    <option value="1004">1004</option>

                                </select>
                            </p>
                        </div>
                        <div>
                            <p>Staff ID:<span><input type="text" name="staffid"
                                                     value="<%=product.getStaffid()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Date Created:<span><input type="text" name="lastCreate" 
                                                         value="<%=product.getLastcreate()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Last Modified:<span><input type="text" name="lastModify"
                                                          value="<%=product.getLastmodify()%>" readonly></span></p>
                        </div>
                    </div>

                    <div style="width: fit-content; margin: auto;">
                        <button class="udBtn deleteBtn" type="submit">Delete Product</button>
                    </div>
                </form>
                <% } else {%>
                <p>Product not found</p>
                <p><a href="ViewProduct">Back to Product Page.</a></p>
                <% }%>

            </div>
        </div>

    </body>
</html>
