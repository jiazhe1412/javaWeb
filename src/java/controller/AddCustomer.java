/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Customer;
import model.CustomerService;
import java.util.Date;
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
 * @author Rong
 */
@WebServlet(name = "AddCustomer", urlPatterns = {"/AddCustomer", "/View/Client/AddCustomer"})
public class AddCustomer extends HttpServlet {

    private static int customerIdCounter = 1;

    private static String getCustomerID() {
        String customerid = "C" + String.format("%04d", customerIdCounter);
        customerIdCounter++;
        return customerid;
    }

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerid = getCustomerID();
        String custname = request.getParameter("custname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String contactnumber = request.getParameter("contactnumber");
        String birthdate = request.getParameter("birthdate");
        String password = request.getParameter("password");
        String repeatpassword = request.getParameter("repeatpassword");

        Date bday = java.sql.Date.valueOf(birthdate);

        // Validations
        boolean isValid = true;
        String nameErr = "";
        String emailErr = "";
        String contactNumberErr = "";
        String birthDateErr = "";
        String passwordErr = "";
        String repeatPasswordErr = "";

        if (!validateName(custname)) {
            nameErr = "Invalid name format.";
            isValid = false;
        }
        if (!validateEmail(email)) {
            emailErr = "Invalid email format.";
            isValid = false;
        }
        if (!validateContactNumber(contactnumber)) {
            contactNumberErr = "Invalid contact number, must be numbers.";
            isValid = false;
        }
        
        if (!validateBirthdate(bday)){
            birthDateErr = "Birthday cannot be in the future.";
            isValid = false;
        }
        
        if (!validatePassword(password)) {
            passwordErr = "Password must be at least 8 characters long.";
            isValid = false;
        }
        if (!validateRepeatPassword(password, repeatpassword)) {
            repeatPasswordErr = "Passwords do not match.";
            isValid = false;
        }

        HttpSession session = request.getSession();
        if (isValid == true) {
            try {
                Customer customer = new Customer(customerid, custname, email, address, contactnumber, bday, password);

                CustomerService customerService = new CustomerService(em);
                utx.begin();
                boolean success = customerService.addCustomer(customer);
                utx.commit();
                session.setAttribute("RegistrationSuccess", success);
                response.sendRedirect("View/Client/login.jsp?success=true&name=" + custname);

            } catch (Exception ex) {
                Logger.getLogger(AddCustomer.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            request.setAttribute("nameErr", nameErr);
            request.setAttribute("emailErr", emailErr);
            request.setAttribute("contactNumberErr", contactNumberErr);
            request.setAttribute("birthDateErr", birthDateErr);
            request.setAttribute("passwordErr", passwordErr);
            request.setAttribute("repeatPasswordErr", repeatPasswordErr);

            RequestDispatcher rd = request.getRequestDispatcher("register.jsp?error");
            rd.forward(request, response);
        }
    }

    private boolean validateName(String custname) {
        return custname.matches("[a-zA-Z ]+");
    }

    private boolean validateEmail(String email) {
        return email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}");
    }

    private boolean validateContactNumber(String contactnumber) {
        return contactnumber.matches("\\d{10,11}");
    }
    
    private boolean validateBirthdate(Date bday) {
        Date currentDate = new Date(); 
        return bday.before(currentDate);
    }

    private boolean validatePassword(String password) {
        return password.length() >= 8;
    }

    private boolean validateRepeatPassword(String password, String repeatpassword) {
        return password.equals(repeatpassword);
    }

    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
