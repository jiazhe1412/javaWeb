<%-- 
    Document   : DeleteInformation
    Created on : 10 May 2024, 9:58:31 am
    Author     : Lee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.tailwindcss.com"></script>

    </head>
    <body>
        <div>
            <%@ include file = "sideNavForStaff.jsp" %>
        </div>
        <div style="background-color:rgb(128, 128, 128); height: 100vh; ">
            <div class="w-4/5 ml-56 flex h-screen justify-center items-center">
                <div class="bg-white py-20 px-28 w-full rounded-xl">
                    <h1 class="text-2xl font-bold">Delete Category</h1>
                    <div class=" rounded my-3">
                        <%
                            boolean success = (Boolean) session.getAttribute("success");
                            if (success)
                                out.println("Category deleted successfully.");
                            else
                                out.println("Error: Unable to delete Category. Product Exist");
                        %>
                    </div>
                    <p><a href="../../CategoryList">Back to category home page</a></p>
                </div>
            </div>
        </div> 

    </body>
</html>
