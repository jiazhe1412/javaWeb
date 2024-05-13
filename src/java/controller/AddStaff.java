/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Staff;
import model.StaffService;
import java.util.Date;
import java.io.*;
import java.util.List;
import java.util.logging.*;
import javax.annotation.Resource;
import javax.servlet.annotation.WebServlet;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.transaction.UserTransaction;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Rong
 */
@WebServlet(name = "AddStaff", urlPatterns = {"/AddStaff", "/View/Admin/AddStaff"})
public class AddStaff extends HttpServlet {

    private static int staffIdCounter = 1;

    private static String getStaffID() {
        String staffid = "S" + String.format("%04d", staffIdCounter);
        staffIdCounter++;
        return staffid;
    }

    private static Date getDateToday() {
        return new Date();
    }

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
            String staffid = getStaffID();
            String name = request.getParameter("name");
            String contactnumber = request.getParameter("contactnumber");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String repeatpassword = request.getParameter("repeatpassword");
            Date datecreated = getDateToday();

            boolean isValid = true;
            String nameErr = "";
            String contactNumberErr = "";
            String passwordErr = "";
            String repeatPasswordErr = "";

            if (!validateName(name)) {
                nameErr = "Invalid name format.";
                isValid = false;
            }

            if (!validateContactNumber(contactnumber)) {
                contactNumberErr = "Invalid contact number, must be numbers.";
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
                    Staff staff = new Staff(staffid, name, contactnumber, address, password, datecreated);

                    StaffService staffService = new StaffService(em);
                    utx.begin();
                    boolean success = staffService.addStaff(staff);
                    utx.commit();

                    session.setAttribute("staffRegistration", success);
                    response.sendRedirect("ViewStaff");
                } catch (Exception ex) {
                    Logger.getLogger(AddStaff.class.getName()).log(Level.SEVERE, null, ex);
                }

            } else {
                request.setAttribute("nameErr", nameErr);
                request.setAttribute("contactNumberErr", contactNumberErr);
                request.setAttribute("passwordErr", passwordErr);
                request.setAttribute("repeatPasswordErr", repeatPasswordErr);

                RequestDispatcher rd = request.getRequestDispatcher("staffRegister.jsp?error");
                rd.forward(request, response);
            }
        }

    

    private boolean validateName(String name) {
        return name.matches("[a-zA-Z ]+");
    }

    private boolean validateContactNumber(String contactnumber) {
        return contactnumber.matches("\\d{10,11}");
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
