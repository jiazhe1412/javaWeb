<%-- 
    Document   : LoginRegister
    Created on : 4 Apr 2024, 3:19:10 pm
    Author     : Rong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<%@ page import="model.CustomerService" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Password</title>
        <!-- CSS -->
        <link href="../CSS/login.css" rel="stylesheet" type="text/css"/>
        <!-- Remix Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('togglePassword').addEventListener('click', function () {
                    var passwordInput = document.getElementById('passwordInput');
                    var icon = this.querySelector('i');

                    if (passwordInput.type === 'password') {
                        passwordInput.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        passwordInput.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
                document.getElementById('toggleRepeatPassword').addEventListener('click', function () {
                    var passwordInput = document.getElementById('repeatPasswordInput');
                    var icon = this.querySelector('i');

                    if (passwordInput.type === 'password') {
                        passwordInput.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        passwordInput.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            });
        </script>
    </head>

    <body>
        <%
            Customer customer = (Customer) session.getAttribute("customer");
        %>

        <div style="width: 100%">
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <h1>Update Password</h1>
                    </div>
                    <form class="login-form" action="UpdatePassword" method="post">    
                        <div class="form-item">
                            <input type="email" placeholder="Email" name="email" value="<%= customer.getEmail()%>" id="email" required readonly>
                        </div>
                        <%
                            String passwordErr = (String) request.getAttribute("passwordErr");
                            if (passwordErr != null) {
                        %>
                        <div class="errorMessage">
                            <%= passwordErr%>
                        </div>
                        <%
                                session.removeAttribute("passwordErr");
                            }
                        %>
                        <div class="form-item">
                            <input type="password" placeholder="Password" name="password" id="passwordInput" required>
                            <span class="pswcheck"><a href="#" id="togglePassword"><i class="fa fa-eye" aria-hidden="true"></i></a></span>
                        </div>
                        <%
                            String repeatPasswordErr = (String) request.getAttribute("repeatPasswordErr");
                            if (repeatPasswordErr != null) {
                        %>
                        <div class="errorMessage">
                            <%= repeatPasswordErr%>
                        </div>
                        <%
                                session.removeAttribute("repeatPasswordErr");
                            }
                        %>
                        <div class="form-item">
                            <input type="password" placeholder="Repeat Password" name="repeatpassword" id="repeatPasswordInput" required>
                            <span class="pswcheck"><a href="#" id="toggleRepeatPassword"><i class="fa fa-eye" aria-hidden="true"></i></a></span>
                        </div>
                        <button type="submit">Update Password</button>
                    </form>
                </div>

            </div>
        </div>

    </body>

</html>
