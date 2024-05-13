<%-- 
    Document   : staffPPasswdChg
    Created on : 4 Apr 2024, 7:53:05 pm
    Author     : Thomas Cheam
--%>


<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
        <%
            List<Category> categoryList = (List<Category>) session.getAttribute("categoryList");
        %>

        <div class="updProdBg">
            <div class="updProdInfo">
                <h1 style="text-align:center; font-size: 1.875rem; line-height:2.25rem; font-weight: 700; position: relative;">Product Info Update
                    <a href="staffProductPg.jsp" style="position:absolute; right: 0; top: -5px;">
                        <button class="closeBtn">
                            <i class="fa fa-times"></i>
                        </button>
                    </a>
                </h1>
                <form action="UpdateProduct" method="post">
                    <div class="updProdContent  ">
                        <div>
                            <p>Product ID:<span><input type="text" name="productid" value="<%=product.getProductid()%>" readonly/></span></p>
                        </div>

                        <div>
                            <p>Product Name:<span><input type="text" name="productname" value="<%=product.getProductname()%>"></span></p>
                        </div>
                        <div>
                            <p>Product Info:<span><input type="text"  name="productinfo" value="<%=product.getProductinfo()%>"></span></p>
                        </div>
                        <div>
                            <p>Price(RM):
                                <span>
                                    <input type="text" name="price" value="<%=product.getPrice()%>">
                                </span>

                            </p>
                        </div>
                        <div>
                            <p>Stock:
                                <span>
                                    <input type="text" name="stock" value="<%=product.getStockqty()%>">
                                </span>
                            </p>
                        </div>
                        <div>
                            <p><label>Category ID:</label>
                                <select name="categoryid">
                                    <% for (Category category : categoryList) {%>
                                    <option value="<%= category.getCategoryid()%>"><%= category.getCategorytype()%></option>
                                    <% }%>
                                </select>
                            </p>
                        </div>
                        <div>
                            <p>Staff ID:<span><input type="text" name="staffid"
                                                     value="<%=product.getStaffid().getStaffId()%>" readonly></span></p>
                        </div>
                        <div>
                            <%
                                    Date date = product.getLastcreate();
                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    String lastCreate = dateFormat.format(date);
                                %>
                            <p>Date Created:<span><input type="text" name="lastCreate" 
                                                         value="<%=lastCreate%>" readonly></span></p>
                        </div>
                        <div>
                             <%
                                    date = product.getLastmodify();
                                    dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    String lastModify = dateFormat.format(date);
                                %>
                            <p>Last Modified:<span><input type="text" name="lastModify"
                                                          value="<%=lastModify%>" readonly></span></p>
                        </div>
                    </div>

                    <div style="width: fit-content; margin: auto;">
                        <input class="updBtn" type="submit" value="Save Changes" />

                    </div>
                </form>

            </div>
        </div>
        <% }%>
    </body>
</html>
