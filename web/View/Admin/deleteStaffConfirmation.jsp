<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Staff"%>
<%@page import="model.StaffService"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <!-- CSS -->
        <link rel="stylesheet" href="../CSS/staffRegister.css">
        <!-- Remix Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">



    </head>

    <body>
        <div class="register-container">
            <div class="register-card">
                <a href="../Admin/ViewStaff"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                <div class="register-header">
                    <h1>Staff Deletion Confirmation</h1>
                </div>
                <%
                    Staff staff = (Staff) session.getAttribute("staffInformation");
                    if (staff != null) {
                %>
                <form class="register-form" action="DeleteStaff" method="post">

                    <div class="form-item">    
                        <span class="usericon"><i class="fa fa-user" aria-hidden="true"></i></span>
                        <input type="text" class="firstname" placeholder="Name" name="staffId" value="<%= staff.getStaffId()%>" required autofocus readonly>
                    </div>

                    <div class="form-item">    
                        <span class="usericon"><i class="fa fa-user" aria-hidden="true"></i></span>
                        <input type="text" class="firstname" placeholder="Name" name="name" value="<%= staff.getName()%>" required autofocus readonly>
                    </div>

                    <div class="form-item">
                        <span class="contacticon"><i class="fa fa-phone" aria-hidden="true"></i></span>
                        <input type="text" placeholder="Contact Number" name="contactnumber" value="<%= staff.getContactNumber()%>" required readonly>
                    </div>
                    <div class="form-item">
                        <span class="addressicon"><i class="fa fa-home" aria-hidden="true"></i></span>
                        <input type="text" placeholder="Address" name="address" value="<%= staff.getAddress()%>" required readonly>
                    </div>

                    <div class="form-item">
                        <span class="passwordicon"><i class="fa fa-unlock-alt" aria-hidden="true"></i></span>
                        <input type="text" placeholder="Password" name="password" id="passwordInput" value="<%= staff.getPassword()%>" required readonly>
                    </div>

                    <button type="submit">Delete Staff</button>
                </form>
                <%
                } else {
                %>
                <p>Staff not found</p>
                <p><a href="../Admin/ViewStaff">Back to manager dashboard.</a></p>
                <% }%>
            </div>
        </div>

    </body>

</html>