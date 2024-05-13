<%-- 
    Document   : newStaffPet
    Created on : 6 Apr 2024, 9:23:21?pm
    Author     : Thomas Cheam
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.ProductService"%>

<%
    List<Product> productList = (List) session.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/staffProductPgCss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Staff Product Page</title>

    </head>
    <body>


        <% if (session.getAttribute("productDelete") != null && (Boolean) session.getAttribute("productDelete")) { %>
        <script>
            alert('Product deleted successful!');
        </script>
        <%
                session.removeAttribute("productDelete");
            }
        %>
        <% if (session.getAttribute("discountDelete") != null && (Boolean) session.getAttribute("discountDelete")) { %>
        <script>
            alert('Product deleted successful!');
        </script>
        <%
                session.removeAttribute("discountDelete");
            }
        %>
        <%@ include file = "sideNavForStaff.jsp" %>
        <div class="staffPetBg">
            <div class="productPage">
                <div>
                    <div class="header">
                        <h1 style="text-align: center; color: black; font-family: sans-serif;">Product Management CRUDs</h1>
                    </div>

                    <div class="content">
                        <div style="width:80%; margin:0 auto; padding: 40px 0; display:grid; grid-template-rows:repeat(3, minmax(0, 1fr)); row-gap: 15px">
                            <div>
                                <a href="createNewProduct.jsp">
                                    <input class="addBtn" type="submit" value="CREATE New Item" >
                                </a>
                            </div>
                            <div class="searchContainer">
                                <a href="SearchProduct">
                                    <input class="searchBar" type="submit" value="Search" form="search">
                                </a>
                            </div>
                            <div>
                                <form  id="search" method="post" action="../../SearchProduct">
                                    <input class="searchBar" type="text" name="searchProduct" placeholder="product Id">
                                </form>

                            </div>

                            <div class="productRecord">
                                <div>
                                    <section class="tableHead">
                                        <h1>Product Details</h1>
                                    </section>
                                </div>
                                <div>
                                    <section class="tableContent">
                                        <table>
                                            <tr>
                                                <th>Product ID</th>
                                                <th>Product Name</th>
                                                <th>Price(RM)</th>
                                                <th>Stock</th>
                                                <th>Category Id</th>
                                                <th>Staff Id</th>
                                                <th>Date Created</th>
                                                <th>Last Modified</th>
                                                <th>Update</th>
                                                <th>Delete</th>
                                            </tr>
                                            <% for (Product product : productList) {%>
                                            <tr>
                                                <td><%= product.getProductid()%></td>
                                                <td><%= product.getProductname()%></td>
                                                <td><%= product.getPrice()%></td>
                                                <td><%= product.getStockqty()%></td>
                                                <td><%= product.getCategoryid().getCategoryid()%></td>
                                                <td><%= product.getStaffid().getStaffId()%></td>
                                                <%
                                                    Date date = product.getLastcreate();
                                                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                    String lastCreate = dateFormat.format(date);
                                                %>
                                                <td> <%=lastCreate%></td>
                                                <%
                                                    date = product.getLastmodify();
                                                    dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                    String lastModify = dateFormat.format(date);
                                                %>
                                                <td><%= lastModify%></td>
                                                <td><a href="../../getUpdateProduct?productId=<%= product.getProductid()%>" class="udBtn updateBtn" >Update</a></td>
                                                <td><a href="../../getDeleteProduct?productId=<%= product.getProductid()%>" class="udBtn deleteBtn" >Delete</a>
                                            </tr>
                                            <% }%>
                                        </table> 
                                    </section> 
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>