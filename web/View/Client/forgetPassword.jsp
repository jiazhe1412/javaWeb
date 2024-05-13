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
        <title>Forget Password</title>
        <!-- CSS -->
        <link href="../CSS/forgetPassword.css" rel="stylesheet" type="text/css"/>
        <!-- Remix Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">


    </head>

    <body>
        <div style="width:100%">
            <div style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div>
            <div class="forgetPassword">

                <p>
                    Enter your email address associated with your password. We will send you a link to reset your password.
                </p>
                <div class="fp-card">
                    <form action="RetrieveEmail" method="POST">
                        <div class="form-item">
                            <span class="email"><i class="fa fa-envelope-o" aria-hidden="true"></i></span>
                            <input type="text" placeholder="Email" name="email" required autofocus>
                        </div>
                        <button type="submit">Continue</button>
                        <div class="login">
                            <p>
                                Remember your password? <a href="login.jsp">Login here</a>.
                            </p>
                        </div>
                    </form>
                </div>
            </div>
            <%@ include file = "footer.jsp" %>
        </div>
    </body>

</html>
