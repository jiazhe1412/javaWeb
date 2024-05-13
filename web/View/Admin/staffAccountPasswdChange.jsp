<%-- 
    Document   : staffAccountPasswdChange
    Created on : May 10, 2024, 6:58:30 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/staffAccountPasswdChange.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Staff staff = (Staff) session.getAttribute("staff");
            if (staff != null) {
        %>
        <div class="staffAccountPasswdChgBg">
            <div class="chgPasswdInfo">
                <h1 style="text-align: center; font-family: sans-serif; position: relative; font-size: 1.875rem; line-height: 2.25rem;">Change Your Password
                    <a href="staffAccount.jsp" class="closeBtn">
                        <i class="fa fa-times"></i>
                    </a>
                </h1>
                <form action="../../StaffAccountPasswdChange" method="POST">

                    <div style="font-size: 15px;">

                        <div>
                            <p style="font-weight: bold;">Existing Password: 
                                <input type="password" name="ExistingPassword" placeholder="Enter Your Extisting Password" required></p>
                        </div>
                        <div style="background-color:rgb(198, 198, 235); color:rgb(66, 66, 189); font-weight: bold;">
                            <span>
                                <b>*Tips to Generate a Strong Password!</b>
                                <i>
                                    Use both upper and lowercase characters<br>
                                    Include at least one symbol (# $ ! % & etc...)<br>
                                    Don't use dictionary words
                                </i>
                            </span>

                        </div>
                    </div>
                    <div class="chgPasswdContent">
                        <div>

                            <p>New Password: <input type="password" name="NewPassword"  required></p>
                        </div>
                        <div>
                            <p>Confirm New Password: <input type="password" name="ConfirmPassword" required></p>
                        </div>

                    </div>
                    <div style="margin: auto; width: fit-content;">
                        <button type="submit" class="saveBtn">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
        <% } %>
    </body>
</html>

