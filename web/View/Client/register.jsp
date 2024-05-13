<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <!-- CSS -->
        <link href="../CSS/register.css" rel="stylesheet" type="text/css"/>
        <!-- Remix Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

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
        <div class="register-container">
            <div class="register-card">
                <div class="register-header">
                    <h1>Register</h1>
                </div>
                <form class="register-form" action="../../AddCustomer" method="post">
                    <%
                        String nameErr = (String) request.getAttribute("nameErr");
                        if (nameErr != null) {
                    %>
                    <div class="errorMessage">
                        <%= nameErr%>
                    </div>
                    <%
                            session.removeAttribute("nameErr");
                        }
                    %>
                    <div class="form-item">    

                        <span class="usericon"><i class="fa fa-user" aria-hidden="true"></i></span>
                        <input type="text" class="firstname" placeholder="Name" name="custname" required autofocus>
                    </div>
                    <%
                        String emailError = (String) request.getAttribute("emailErr");
                        if (emailError != null) {
                    %>
                    <div class="errorMessage">
                        <%= emailError%>
                    </div>
                    <%
                            session.removeAttribute("emailError");
                        }
                    %>
                    <div class="form-item">

                        <span class="emailicon"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
                        <input type="email" placeholder="Email" name="email" required>
                    </div>
                    <div class="form-item">
                        <span class="addressicon"><i class="fa fa-home" aria-hidden="true"></i></span>
                        <input type="text" placeholder="Address" name="address" required>
                    </div>
                    <%
                        String contactNumberError = (String) request.getAttribute("contactNumberErr");
                        if (contactNumberError != null) {
                    %>
                    <div class="errorMessage">
                        <%= contactNumberError%>
                    </div>
                    <%
                            session.removeAttribute("contactNumberError");
                        }
                    %>
                    <div class="form-item">

                        <span class="contacticon"><i class="fa fa-phone" aria-hidden="true"></i></span>
                        <input type="text" placeholder="Contact Number" name="contactnumber" required>
                    </div>
                    <%
                        String birthDateError = (String) request.getAttribute("birthDateErr");
                        if (birthDateError != null) {
                    %>
                    <div class="errorMessage">
                        <%= birthDateError%>
                    </div>
                    <%
                            session.removeAttribute("birthDateError");
                        }
                    %>
                    <div class="form-item">
                        <span class="birthdateicon"><i class="fa fa-birthday-cake" aria-hidden="true"></i></span>
                        <input type="date" name="birthdate" required>
                    </div>
                    <%
                        String passwordError = (String) request.getAttribute("passwordErr");
                        if (passwordError != null) {
                    %>
                    <div class="errorMessage">
                        <%= passwordError%>
                    </div>
                    <%
                            session.removeAttribute("passwordError");
                        }
                    %>
                    <div class="form-item">

                        <span class="passwordicon"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
                        <input type="password" placeholder="Password" name="password" id="passwordInput" required>
                        <span class="pswcheck"><a href="#"><i class="fa fa-eye" id="togglePassword" aria-hidden="true"></i></a></span>
                    </div>
                    <%
                        String repeatPasswordError = (String) request.getAttribute("repeatPasswordErr");
                        if (repeatPasswordError != null) {
                    %>
                    <div class="errorMessage">
                        <%= repeatPasswordError%>
                    </div>
                    <%
                            session.removeAttribute("repeatPasswordError");
                        }
                    %>
                    <div class="form-item">

                        <span class="passwordicon"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
                        <input type="password" placeholder="Repeat Password" name="repeatpassword" id="repeatPasswordInput" required>
                        <span class="pswcheck"><a href="#"><i class="fa fa-eye" id="toggleRepeatPassword" aria-hidden="true"></i></a></span>
                    </div>
                    <div class="form-other">
                        <div class="checkbox">
                            <input type="checkbox" id="agreeTerms" name="agreeTerms" required>
                            <label for="agreeTerms">I agree to the <a href="#">terms and conditions</a>.</label>
                        </div>
                    </div>
                    <button type="submit">Register</button>
                </form>
                <div class="login">
                    Already have an account? <a href="login.jsp">Login here</a>.
                </div>
            </div>
        </div>

    </body>

</html>