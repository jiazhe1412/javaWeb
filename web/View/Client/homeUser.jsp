<%@page import="model.*,java.util.*"%>

<%
    List<Category> categoryList = (List) session.getAttribute("categoryList");
    List<Product> productList = (List) session.getAttribute("productList");
    List<Discount> discountList = (List) session.getAttribute("discountList");
    Date currentDate = new Date();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Homepage</title>
        <link rel="stylesheet" href="../CSS/homeUser.css">
        <script src="https://cdn.tailwindcss.com"></script>

    </head>
    <body>
        <% if (session.getAttribute("customer") != null) {
                Customer customer = (Customer) session.getAttribute("customer");
                boolean loggedIn = customer != null;

        %>
        <script>
            alert('Welcome back, <%= customer.getCustomerName()%>!');
        </script>
        <% }%>
        <div>

            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <!--Header End-->

            <div class="openprod">
                <p>Say Hello to PetStore</p>
                <h1>All you need at Here!</h1>
                <button type="button"><a href="../../ProductList" style="text-decoration: none;color:white;">Open Product</a></button>
            </div>
            <div class="sayhello">
                <img src="../image/sayhello.jpg">
            </div>
            <div class="product-container">
                <div class="product1">
                    <img src="../image/petfood.png" alt="Product 1" width="200">
                    <p>Pet Food</p>
                    <button type="button" ><a href="../../ProductList" style="text-decoration: none;color:black;">Shop Now</a></button>
                </div>
                <div class="product2">
                    <img src="../image/pettoys.png" alt="Product 2" width="200">
                    <p>Pet Toys</p>
                    <button type="button"><a href="../../ProductList" style="text-decoration: none;color:black;">Shop Now</a></button>
                </div>
            </div>

            <% if (categoryList != null) {
                    for (int i = 0; i < 2; i++) {
            %>
            <div class="productList">
                <div style="width: 90%; margin: 0 auto; font-weight: 800; font-size:18px;" class="foodHeader ">
                    <div style="display: flex">
                        <p style="margin: 0; width: 50%"><%= categoryList.get(i).getCategorytype()%></p>
                        <a style="" href="Product.jsp" >
                            See All <%= categoryList.get(i).getCategorytype()%>
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </a>
                    </div>
                    <hr style="color:black; border: 1px solid black">
                </div>


                <div class="food-list">
                    <!--Food List-->
                    <% if (productList != null && productList.size() != 0 && discountList != null && discountList.size() != 0) {
                            // Loop through the products
                            for (Product product : productList) {
                    %>

                    <!-- Search Product -->        
                    <%
                        if (product.getCategoryid().getCategorytype().equals(categoryList.get(i).getCategorytype())) {
                    %>        
                    <%
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

                    <% if (countProduct > 0) {%>
                    <div class="food-content-all">
                        <div class="food-content">
                            <a href="../../ProductList" style="text-decoration: none; color: black;"
                               class="food-product">
                                <img src="../image/<%= product.getImagepath()%>" alt="alt" width="230"/>
                                <p style="font-weight: 600; margin: 4px 0px; "><%= product.getProductname()%></p>
                                <p class="font-bold py-0.5 px-3 relative bg-green-300 rounded-xl text-black/70">
                                    RM <%= product.getPrice()%>
                                    <b class="text-6xl rotate-45 absolute left-14 -top-1 bottom-16 font-semibold text-red-500">/</b>
                                    <b class="absolute -top-2 left-24 bg-red-500 py-2 px-1 rounded-2xl text-white w-28 text-center">
                                        RM <%= String.format("%.2f", discountPrice)%>
                                    </b>
                                </p> 
                            </a>
                        </div>
                    </div>
                    <% } else {%>
                    <div class="food-content-all">
                        <div class="food-content">
                            <a href="../../ProductList" style="text-decoration: none; color: black;"
                               class="food-product">
                                <img src="../image/<%= product.getImagepath()%>" alt="alt" width="230"/>
                                <p style="font-weight: 600; margin: 4px 0px; "><%= product.getProductname()%></p>
                                <p class="font-bold py-0.5 px-3 bg-green-300 rounded-xl text-black/70">RM <%= product.getPrice()%></p>
                            </a>
                        </div>
                    </div>
                    <% } %>



                    <%
                            } //category 
                        } //product list for
                    } //if product and category list is null %>
                    </div>
                    <%
                            }//end for
                        }//end if

                    %>

                
                <div class="bgimg">
                    <div class="fixedImg">
                        <p class="about">About The Shop</p>
                        <h1>Watch Our Story</h1>
                        <p class="desc">
                            There is no magic formula to write perfect ad copy. It is based on a number of factors, including ad placement,<br> demographic, even the consumer’s mood.
                        <p>
                            <button><i class="fa fa-play" aria-hidden="true"></i></button>
                    </div>
                </div>

                <div class="dis">
                    <div class="discount">
                        <div class="telegram">
                            <i class="fa fa-telegram" aria-hidden="true"></i>
                        </div>
                        <h1>
                            Subscribe to our newsletter<br>
                            & get <span style="color: #72c248">10% discount!</span>
                        </h1>
                        <input type="text" placeholder="Enter Your Email Address">
                        <a href="#">Subscribe</a>
                    </div>
                </div>
            </div>
            <footer>
                <%@ include file = "footer.jsp" %>
            </footer>

    </body>
</html>


<!-- <div class="food-list">
                <span>Pet Food
                    <a href="#">See All Food <i class="fa fa-arrow-right" aria-hidden="true"></i></a>
                </span>
                <hr style="height:3px;width: 88%; border-width:0;color:gray;background-color:gray; margin-left: 6%;">
                <div class="food" style="margin-left: 6%;"> 
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 1">
                        <p>Product 1</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="food">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 2">
                        <p>Product 2</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="food">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 3">
                        <p>Product 3</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="food">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 4">
                        <p>Product 4</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
            </div>

            <div class="toy-list">
                <span>Pet Toys
                    <a href="#">See All Toys <i class="fa fa-arrow-right" aria-hidden="true"></i></a>
                </span>
                <hr style="height:3px;width: 86%; border-width:0;color:gray;background-color:gray; margin-left: 6%;">
                <div class="toy" style="margin-left: 6%;"> 
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 1">
                        <p>Product 1</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="toy">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 2">
                        <p>Product 2</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="toy">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 3">
                        <p>Product 3</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
                <div class="toy">
                    <a href="#">
                        <img src="../image/jiazhe.jpg" alt="Product 4">
                        <p>Product 4</p>
                        <button>Jia Zhe</button>
                    </a>
                </div>
            </div>-->