<%-- 
    Document   : categoryList
    Created on : 9 May 2024, 11:20:46 am
    Author     : Lee
--%>

<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body>
        <%
            List<Category> categoryList = (List) session.getAttribute("categoryAdminList");
        %>

        <div>
            <%@ include file = "sideNavForStaff.jsp" %>
        </div>
        <div style="background-color:rgb(128, 128, 128); height: 100vh; ">
            <div class="w-4/5 ml-56 flex h-screen justify-center items-start">
                <div class="bg-white py-8 px-20 w-full my-16 rounded-xl">
                    <h1 class="text-2xl font-bold">Category List</h1>

                    <div>
                        <a href="../../AddCategory" class="inline-block bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                            <i class="fa fa-plus" aria-hidden="true"></i> 
                        </a>
                    </div>

                    <div class="border border-gray-500 border-solid rounded my-3">
                        <table class="min-w-full">
                            <tr class="bg-slate-400">
                                <th class="border border-gray-500 border-solid py-4">Category ID</th>
                                <th class="border border-gray-500 border-solid py-4">Category Type</th>
                                <th class="border border-gray-500 border-solid py-4">Update</th>
                                <th class="border border-gray-500 border-solid py-4">Delete</th>
                            </tr>
                            <%
                                if (categoryList != null) {
                                    for (Category c : categoryList) {
                            %>
                            <tr class="bg-slate-200">
                                <th class="border border-gray-500 border-solid py-4"><%=c.getCategoryid()%></th>
                                <th class="border border-gray-500 border-solid py-4"><%= c.getCategorytype()%></th>
                                    <%
                                        String updateBox = "<th class=\"border border-gray-500 border-solid py-4\">"
                                                + "<a href=\"../../UpdateCategory?categoryID=" + c.getCategoryid()
                                                + "\" class=\"inline-block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded\">"
                                                + "Update</a>"
                                                + "</th>";
                                        String deleteBox = "<th class=\"border border-gray-500 border-solid py-4\">"
                                                + "<a href=\"../../DeleteCategory?categoryID=" + c.getCategoryid() + "\""
                                                + "class=\"inline-block bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded\">"
                                                + "Delete</a></th>";

                                        out.print(updateBox);
                                    %>
                                <th class="border border-gray-500 border-solid py-4">
                                    <form action="../../DeleteCategory" method="post" onsubmit="return window.confirm('Are you sure you want to delete this item?')">
                                        <input type="hidden" name="categoryID" value="<%= c.getCategoryid()%>">
                                        <input type="submit" value="Delete" 
                                               class="inline-block bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"/>
                                    </form>
                                </th>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>
        </div> 
    </body>
</html>
