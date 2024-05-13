/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Staff;
import model.StaffService;
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
@WebServlet(name = "StaffLogin", urlPatterns = {"/StaffLogin", "/View/Admin/StaffLogin"})
public class StaffLogin extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String staffid = request.getParameter("staffid");
        String password = request.getParameter("password");

        StaffService staffService = new StaffService(em);
        Staff staff = staffService.findStaffByID(staffid);

        if (staff != null && staff.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("staff", staff);
            response.sendRedirect("ViewAdmin");
        }
        
        else if ("M0001".equals(staffid) && "manager12345".equals(password)){
            HttpSession session = request.getSession();
            session.setAttribute("manager", "This is manager login");
            response.sendRedirect("ViewStaff");
        }
        
        else if (staff == null) {
            HttpSession session = request.getSession();
            session.setAttribute("validationError", "Staff not found!");
            response.sendRedirect("staffLogin.jsp?error=empty");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("validationError", "Password incorrect!");
            response.sendRedirect("staffLogin.jsp?error=empty");
        }
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
