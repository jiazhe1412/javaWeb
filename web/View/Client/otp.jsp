<%-- 
    Document   : otp
    Created on : 7 Apr 2024, 9:47:01 pm
    Author     : Rong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../CSS/otp.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>OTP Verification</title>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const inputs = document.querySelectorAll('.number input');
                const otpVerifyBtn = document.querySelector('.otpVerifyBtn');
                function restrictInput(event) {
                    const key = event.keyCode || event.which;
                    if (!(key >= 48 && key <= 57) && key !== 8 && key !== 46) {
                        event.preventDefault();
                    }
                }

                inputs.forEach(function (input) {
                    input.addEventListener('keypress', restrictInput);
                });
                function checkInputs() {
                    let allFilled = true;
                    inputs.forEach(function (input) {
                        if (input.value === '') {
                            allFilled = false;
                        }
                    });
                    return allFilled;
                }

                inputs.forEach(function (input) {
                    input.addEventListener('input', function () {
                        otpVerifyBtn.disabled = !checkInputs();
                    });
                });
                otpVerifyBtn.addEventListener('click', function () {
                    let userOTP = '';
                    const otpInputs = document.querySelectorAll('.number input');
                    otpInputs.forEach(function (input) {
                        userOTP += input.value;
                    });
                    document.getElementById('userOTP').value = userOTP;
                });
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js">
        </script>


    </head>
    <body>
        <%
            String email = request.getParameter("email");
        %>

        <script>
            window.onload = function () {
                // Initialize EmailJS
                emailjs.init("H9xlNbSFpzrGk4Hfq");

                // Define parameters for the email
                var params = {
                    sendername: "Pet Supplies GUI",
                    to: "<%= email%>",
                    subject: "OTP Verification",
                    replyto: "noreply@gmail.com",
                    message: "Your OTP Password is ${otp}"
                };

                // Define service ID and template ID
                var serviceID = "service_unywyla";
                var templateID = "template_nn64qhr";

                // Send email using EmailJS
                emailjs.send(serviceID, templateID, params)
                        .then(function (response) {
                            alert("Email sent successfully.");
                        })
                        .catch(function (error) {
                            console.error("Error sending email:", error);
                        });
            };
        </script>


        <div style="width:100%">
            <div style="position: sticky ;top: 0; z-index: 999" >
                <%@ include file = "header.jsp" %>
            </div> 
            <div class="otp">
                <span class="btl">
                    <a href="../Client/login.jsp">Back To Login <i class="fa fa-arrow-circle-left" aria-hidden="true"></i></a>
                </span>  
                <form action="CheckOTP" method="POST">
                    <%
                        String otpErr = (String) request.getAttribute("otpErr");
                        if (otpErr != null) {
                    %>
                    <div class="errorMessage">
                        <%= otpErr%>
                    </div>
                    <%
                            session.removeAttribute("otpErr");
                        }
                    %>
                    <input type="hidden" name="email" value="<%= email%>">
                    <input type="hidden" name="generatedOTP" value= ${otp}>
                    <input type="hidden" id="userOTP" name="userOTP">
                    <h1>OTP Verification</h1>
                    <p>Code has been sent to your email.</p>
                    <div class="number">
                        <input type="text" maxlength="1" name="digit1" id="digit1" autofocus>
                        <input type="text" maxlength="1" name="digit2" id="digit2">
                        <input type="text" maxlength="1" name="digit3" id="digit3">
                        <input type="text" maxlength="1" name="digit4" id="digit4">
                        <input type="text" maxlength="1" name="digit5" id="digit5">
                        <input type="text" maxlength="1" name="digit6" id="digit6">
                    </div>

                    <p class="resend">
                        <a href="../Client/RetrieveEmail?action=resend&email=<%= email%>">Resend OTP here <i class="fa fa-undo" aria-hidden="true"></i></a>
                    </p>

                    <button type="submit" class="otpVerifyBtn" disabled>Verify</button>
                </form>
            </div>
            <%@ include file = "footer.jsp" %>
        </div>
    </body>
</html>
