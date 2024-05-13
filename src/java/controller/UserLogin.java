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
import javax.servlet.http.Cookie;

/**
 *
 * @author Rong
 */
@WebServlet(name = "UserLogin", urlPatterns = {"/UserLogin", "/View/Client/UserLogin"})
public class UserLogin extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        boolean rememberMe = request.getParameter("rememberMe") != null;

        CustomerService customerService = new CustomerService(em);
        Customer customer = customerService.findCustomerByEmail(email);

        if (customer != null && customer.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("loggedIn", true);
            
            if(rememberMe){
                Cookie rememberMeCookie = new Cookie("rememberMe", "true");
                rememberMeCookie.setMaxAge(1 * 24 * 60 * 60);
                response.addCookie(rememberMeCookie);
            }
            
            response.sendRedirect("../../HomePageDisplay");
        }
        else if (customer == null) {
            HttpSession session = request.getSession();
            session.setAttribute("validationError", "Email not found!");
            response.sendRedirect("login.jsp?error=empty");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("validationError", "Email or password incorrect!");
            response.sendRedirect("login.jsp?error=empty");
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
