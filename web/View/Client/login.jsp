<%-- 
    Document   : LoginRegister
    Created on : 4 Apr 2024, 3:19:10 pm
    Author     : Rong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
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
            });
        </script>
    </head>

    <body>
        <% if (session.getAttribute("RegistrationSuccess") != null && (Boolean) session.getAttribute("RegistrationSuccess")) { %>
        <script>
            alert('Registration successful!');
        </script>
        <%
                session.removeAttribute("RegistrationSuccess");
            }
        %>
        
        <% if (session.getAttribute("passwordUpdated") != null && (Boolean) session.getAttribute("passwordUpdated")) { %>
        <script>
            alert('Password updated successful!');
        </script>
        <%
                session.removeAttribute("passwordUpdated");
            }
        %>

        <div style="width: 100%">
            <div class="login-container">
                <div style="position: sticky ;top: 0; z-index: 999" >
                    <%@ include file = "header.jsp" %>
                </div> 
                <div class="login-card">
                    <div class="login-header">
                        <h1>Login</h1>
                    </div>
                    <form class="login-form" action="UserLogin" method="post">

                        <%
                            String validationError = (String) session.getAttribute("validationError");
                            if (validationError != null) {
                        %>
                        <div class="errorMessage">
                            <%= validationError%>
                        </div>
                        <%
                                session.removeAttribute("validationError");
                            }
                        %>
                        <div class="form-item">
                            <span class="email"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
                            <input type="text" placeholder="Email" name="email" required autofocus>
                        </div>
                        <div class="form-item">
                            <span class="password"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
                            <input type="password" placeholder="Password" name="password" id="passwordInput" required>
                            <span class="pswcheck"><a href="#" id="togglePassword"><i class="fa fa-eye" aria-hidden="true"></i></a></span>
                        </div>
                        <div class="form-other">
                            <div class="checkbox">
                                <input type="checkbox" id="rememberMe" name="rememberMe">
                                <label for="rememberMe">Remember Me</label>
                            </div>
                            <a href="forgetPassword.jsp">Forgot Password?</a>
                        </div>
                        <button type="submit">Sign In</button>
                    </form>
                    <div class="register">
                        Don't have an account? <a href="register.jsp">Create here</a>.
                    </div>
                </div>
                <%@ include file = "footer.jsp" %>

            </div>
        </div>

    </body>

</html>
