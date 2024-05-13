<%-- 
    Document   : createNewProduct
    Created on : 10 Apr 2024, 3:38:15 pm
    Author     : Thomas Cheam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.Customer"%>
<%@page import="model.CustomerService"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/customerDetails.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Customer customer = (Customer) session.getAttribute("customer");
            if (customer != null) {
        %>
        <div class="custDetailsOutlineBg">
            <div class="sticky" style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <div class="customerDetailsBg">

                <div class="customerInfo">
                    <h1 style="text-align: center; font-family: sans-serif; position: relative; font-size: 1.875rem; line-height: 2.25rem; font-weight: 700">
                        Profile Info

                        <a href="customerDetails.jsp" class="closeBtn">
                            <i class="fa fa-times"></i>
                        </a>
                    </h1>
                    <form action="UpdateCustomerDetails" style="position: absolute; right: 0; top: -5px">
                        <div class="customerDetails">
                            <div class="customerContentDetails">
                                <p class="p1">Customer ID: </p>
                                <p class="p2"><input type="text" name="customerid"
                                                     value="<%=customer.getCustomerId()%>" readonly></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Customer Name: </p>
                                <p class="p2"><input type="text" name="customername"
                                                     value="<%=customer.getCustomerName()%>" ></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Birth Date: </p>
                                <p class="p2"><input type="text" name="birthdate" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(customer.getBirthDate())%>"></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Contact Number: </p>
                                <p class="p2"><input type="text" name="contactnumber" value="<%=customer.getContactNumber()%>" ></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Email: </p>
                                <p class="p2"><input type="text" name="email" value="<%=customer.getEmail()%>"></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Address: </p>
                                <p class="p2"><input type="text" name="address" value="<%=customer.getAddress()%>"></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Existing Password: </p>
                                <p class="p2"><input type="text" name="ExistingPassword"></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">New Password: </p>
                                <p class="p2"><input type="text" name="NewPassword"></p>
                            </div>
                            <div class="customerContentDetails">
                                <p class="p1">Confirm Password </p>
                                <p class="p2"><input type="text" name="ConfirmPassword"></p>
                            </div>
                        </div>
                        <div style="width: fit-content; margin: 20px auto;">
                            <button class="editDetailsBtn">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
            <%@ include file = "footer.jsp" %>

        </div>
    </body>
</html>
