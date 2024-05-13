<%-- 
    Document   : createNewProduct
    Created on : 10 Apr 2024, 3:38:15 pm
    Author     : Thomas Cheam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/customerDetails.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="custDetailsOutlineBg">
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <div class="customerDetailsBg">

                <div class="customerInfo">
                    <h1 style="text-align: center; font-family: sans-serif; position: relative; font-size: 1.875rem; line-height: 2.25rem; font-weight: 700">
                        Profile Info
                        <form action="customerDetails.jsp" style="position: absolute; right: 0; top: -5px">
                            <button class="closeBtn">
                                <i class="fa fa-times"></i>
                            </button>
                        </form>
                    </h1>
                    <div class="customerDetails">
                        <div class="customerContentDetails">
                            <p class="p1">Customer ID: </p>
                            <p class="p2">C0001</p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Customer Name: </p>
                            <p class="p2"><input type="text" value="Cream" maxlength="50"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Birth Date: </p>
                            <p class="p2"><input type="date" name="birthday"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Contact Number: </p>
                            <p class="p2"><input type="tel" value="018-1688888" pattern="[0-1]{2}[0-9]{1}-[0-9]{7}"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Email: </p>
                            <p class="p2"><input type="email" value="cream@gmail.com"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Address: </p>
                            <p class="p2"><input type="text" value="666,JALAN THOMAS"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Username: </p>
                            <p class="p2"><input type="text" value="Tom" min="3" max="50"></p>
                        </div>
                        <div class="customerContentDetails">
                            <p class="p1">Password: </p>
                            <p class="p2"><input type="password" value="nbuser12345"></p>
                        </div>
                    </div>
                    <div style="width: fit-content; margin: 20px auto;">
                        <form action="customerDetails.jsp">
                            <button class="editDetailsBtn">Edit Personal Details</button>
                        </form>
                    </div>
                </div>
            </div>
            <%@ include file = "footer.jsp" %>

        </div>
    </body>
</html>
