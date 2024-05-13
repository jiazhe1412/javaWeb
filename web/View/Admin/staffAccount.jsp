<%-- 
    Document   : staffAccount
    Created on : 4 Apr 2024, 6:11:45 pm
    Author     : Thomas Cheam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Staff"%>
<%@page import="model.StaffService"%>


<!DOCTYPE html>
<html>
    <head>
        <link href="../CSS/StaffAccount.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <%
            Staff staff = (Staff) session.getAttribute("staff");
            if (staff != null) {
        %>
        <div class="staffBackground">        
            <div class="staffInfo">
                <h1 style="text-align: center; font-family: sans-serif; font-size: 1.875rem; line-height: 2.25rem;
                    font-weight: 700; position: relative ">Your Profile</h1>

                <a href="ViewAdmin" style="position: absolute; right:0; top: -5px;">
                    <button class="closeBtn">
                        <i class="fa fa-times"></i>
                    </button>
                </a>

                <div class="staffContent">
                    <form action="staffAccountPasswdChange.jsp">

                        <div>
                            <p>Staff ID: <span><input type="text" name="staffid"
                                                      value="<%=staff.getStaffId()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Staff Name: <span><input type="text" name="name"
                                                        value="<%=staff.getName()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Contact Number: <span><input type="text" name="contactnumber"
                                                            value="<%=staff.getContactNumber()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Local Address: <span><input type="text" name="address"
                                                           value="<%=staff.getAddress()%>" readonly></span></p>
                        </div>
                        <div>
                            <p>Date Created: <span><input type="text" name="datecreated"
                                                          value="<%=staff.getDateCreated()%>" readonly></span></p>
                        </div>
                        <div class="buttonChange">
                            <button class="chgPasswdBtn" ><b>Change Password</b></button>
                        </div> 
                    </form>
                </div>

            </div>

        </div>
    </body>
    <% }%>
</html>


<!--<button class="deleteBtn" onclick="return confirm('Are you sure to terminate your Account?')">Change Password</button>-->