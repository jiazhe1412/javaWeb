/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Staff;
import model.StaffService;

/**
 *
 * @author Thomas Cheam
 */
@WebServlet(name = "StaffAccountPasswdChange", urlPatterns = {"/StaffAccountPasswdChange", "/View/Admin/StaffAccountPasswdChange"})
public class StaffAccountPasswdChange extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            StaffService staffService = new StaffService(em);
            String existingPassword = request.getParameter("ExistingPassword");
            String newPassword = request.getParameter("NewPassword");
            String confirmPassword = request.getParameter("ConfirmPassword");
            Staff staff = (Staff)session.getAttribute("staff");
            
            if (staff.getPassword().equals(existingPassword)) {
                if (newPassword.length() >= 8 && newPassword.equals(confirmPassword)) {
                    staff.setPassword(newPassword);
                    utx.begin();
                    em.merge(staff);
                    utx.commit();
                    session.setAttribute("staffPasswordUpdated", true);
                    response.sendRedirect("View/Admin/staffAccount.jsp");
                } else {
                    out.println("<b>New Password</b> and <b>Confirm Password</b> not match! Please Try again!");
                }
            } else {
                out.println("Incorret input of your <b>Existing Password!</b>");
            }

        } catch (Exception ex) {
            out.println("<p>" + ex.getMessage() + "</p><p> error</p>");
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
