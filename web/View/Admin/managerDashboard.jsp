<%-- 
    Document   : adminDashboard
    Created on : 16 Apr 2024, 11:41:29 pm
    Author     : Rong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Staff"%>
<%@page import="model.StaffService"%>
<%@page import="model.Payment"%>
<%@page import="model.PaymentService"%>
<%@page import="model.Discount"%>
<%@page import="model.DiscountService"%>
<!DOCTYPE html>
<html>  
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Page</title>
        <%@ include file = "sideNavForManager.jsp" %>
        <link rel="stylesheet" href="../CSS/sideNavManager.css">
        <link rel="stylesheet" href="../CSS/dashboard.css"
              <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <% if (session.getAttribute("staffRegistration") != null && (Boolean) session.getAttribute("staffRegistration")) { %>
        <script>
            alert('Staff registration successful!');
        </script>
        <%
                session.removeAttribute("staffRegistration");
            }
        %>

        <% if (session.getAttribute("staffUpdated") != null && (Boolean) session.getAttribute("staffUpdated")) { %>
        <script>
            alert('Staff updated successful!');
        </script>
        <%
                session.removeAttribute("staffUpdated");
            }
        %>

        <% if (session.getAttribute("staffDeleted") != null && (Boolean) session.getAttribute("staffDeleted")) { %>
        <script>
            alert('Staff deleted successful!');
        </script>
        <%
                session.removeAttribute("staffDeleted");
            }
        %>

        <div class="content">
            <div class="wrapper">
                <h2>
                    Admin Dashboard
                </h2>
            </div>



            <div class="discountData">
                <h3 class="discountTitle">
                    Sales Data
                </h3>
                <div class="discountTable">
                    <table>
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Date</th>
                                <th>Payment Method</th>
                                <th>Amount</th>
                                <th>Payment Status</th>
                                <th>Order ID</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach var="payment" items="${requestScope.paymentList}">
                                <tr>
                                    <td>${payment.paymentid}</td>
                                    <td>${payment.paymentdate}</td>
                                    <td>${payment.paymentmethod}</td>
                                    <td>${payment.totalamount}</td>
                                    <td>${payment.paymentstatus}</td>
                                    <td>${payment.orderid.orderid}</td>
                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tableData">
                <h3 class="financeTitle">
                    Discount Data
                </h3>
                <div class="financeTable">
                    <table>
                        <thead>
                            <tr>
                                <th>Discount ID</th>
                                <th>Discount Type</th>
                                <th>Discount Rate</th>
                                <th>Discount Description</th>
                                <th>Prepared By</th>
                                <th>Starting Date</th>
                                <th>Expiry Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="discount" items="${requestScope.discountList}">
                                <tr>
                                    <td>${discount.discountid}</td>
                                    <td>${discount.discounttype}</td>
                                    <td>${discount.discountrate}</td>
                                    <td>${discount.discountDescription}</td>
                                    <td>${discount.staffCreated}</td>
                                    <td>${discount.activateDate}</td>
                                    <td>${discount.expireDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="tableData">
                <h3 class="financeTitle">
                    Staff Details
                </h3>
                <div class="financeTable">
                    <table>
                        <thead>
                            <tr>
                                <th>Staff ID</th>
                                <th>Staff Name</th>
                                <th>Staff Contact</th>
                                <th>Staff Address</th>
                                <th>Date Created</th>
                                <th>Edit</th>
                                <th style="padding-right: 20px;">Delete</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="staff" items="${requestScope.staffList}">
                                <tr>
                                    <td>${staff.staffId}</td>
                                    <td>${staff.name}</td>
                                    <td>${staff.contactNumber}</td>
                                    <td>${staff.address}</td>
                                    <td>${staff.dateCreated}</td>
                                    <td><a href="../Admin/getEditStaff?staffId=${staff.staffId}"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a></td>
                                    <td><a href="../Admin/getDeleteStaff?staffId=${staff.staffId}"><i class="fa fa-trash" aria-hidden="true"></i></a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </body>
</html>
