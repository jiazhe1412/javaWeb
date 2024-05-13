<%-- 
    Document   : sideNav
    Created on : 13 Apr 2024, 9:00:49 pm
    Author     : Rong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../CSS/sideNavManager.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="navbar">
            <div class="main">
                <div class="selected">
                    <a href="ViewStaff" class="bar">
                        <i class="fa fa-globe" aria-hidden="true"></i>
                        <p>Dashboard</p>
                    </a>
                </div>
                <div>
                    <a href="../../CategoryList" class="bar">
                        <i class="fa fa-tasks" aria-hidden="true"></i>
                        <p>Category</p>
                    </a>
                </div>
                <div>
                    <a href="staffProductPg.jsp" class="bar">
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                        <p>Products</p>
                    </a>
                </div>
                <div>
                    <a href="../../OrderStatusDisplay" class="bar">
                        <i class="fa fa-shopping-bag" aria-hidden="true"></i>
                        <p>Order</p>
                    </a>
                </div>
                <div>
                    <a href="../../DiscountView" class="bar">
                        <i class="fa fa-usd" aria-hidden="true"></i>
                        <p>Discount</p>
                    </a>
                </div>
                <div>
                    <a href="report.jsp" class="bar">
                        <i class="fa fa-file" aria-hidden="true"></i>
                        <p>Report</p>
                    </a>
                </div>
                <div>
                    <a href="staffRegister.jsp" class="bar">
                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                        <p>Register</p>
                    </a>
                </div>
                <div>
                    <a href="../../View/Admin/staffLogin.jsp" class="bar">
                        <i class="fa fa-sign-out" aria-hidden="true"></i>
                        <p>Logout</p>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>

