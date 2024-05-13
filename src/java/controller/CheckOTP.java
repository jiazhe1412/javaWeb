/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Customer;
import model.CustomerService;
import java.io.*;
import java.util.logging.*;
import javax.annotation.Resource;
import javax.servlet.annotation.WebServlet;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.transaction.UserTransaction;

/**
 *
 * @author User
 */
@WebServlet(name = "CheckOTP", urlPatterns = {"/CheckOTP", "/View/Client/CheckOTP"})
public class CheckOTP extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String generatedOTP = request.getParameter("generatedOTP");
        String userOTP = request.getParameter("userOTP");

        CustomerService customerService = new CustomerService(em);
        Customer customerPassword = customerService.findCustomerByEmail(email);

        boolean isValid = true;
        String otpErr = "";

        try {
            if (!validateOTP(generatedOTP, userOTP)) {
                otpErr = "OTP Incorrect!!";
                isValid = false;
            }
        } catch (Exception e) {
            // Log the exception or handle it accordingly
            e.printStackTrace();
            otpErr = "Error validating OTP!";
            isValid = false;
        }

        if (customerPassword != null && generatedOTP.equals(userOTP) && isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customerPassword);
            session.setAttribute("otpVerification", true);

            response.sendRedirect("updatePassword.jsp?success=true");
        } else {
            request.setAttribute("otpErr", otpErr);

            RequestDispatcher rd = request.getRequestDispatcher("otp.jsp?error");
            rd.forward(request, response);
        }
    }

    private boolean validateOTP(String generatedOTP, String userOTP) {
        // Your OTP validation logic
        return generatedOTP.equals(userOTP);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
