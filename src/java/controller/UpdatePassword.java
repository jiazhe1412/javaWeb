package controller;

import model.*;
import java.io.*;
import java.util.logging.*;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.transaction.UserTransaction;

@WebServlet(name = "UpdatePassword", urlPatterns = {"/UpdatePassword", "/View/Client/UpdatePassword"})
public class UpdatePassword extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CustomerService customerService = new CustomerService(em);
            String password = request.getParameter("password");
            String repeatpassword = request.getParameter("repeatpassword");
            String email = request.getParameter("email");

            Customer customer = customerService.findCustomerByEmail(email);

            boolean isValid = true;
            String passwordErr = "";
            String repeatPasswordErr = "";

            if (!validatePassword(password)) {
                passwordErr = "Password must be at least 8 characters long.";
                isValid = false;
            }
            if (!validateRepeatPassword(password, repeatpassword)) {
                repeatPasswordErr = "Passwords do not match.";
                isValid = false;
            }
            
            HttpSession session = request.getSession();

            if (customer != null && isValid) {
                customer.setPassword(password);

                utx.begin();
                em.merge(customer);
                utx.commit();

                session.setAttribute("passwordUpdated", true);
                response.sendRedirect("login.jsp?updated=true");

            } else {
                request.setAttribute("passwordErr", passwordErr);
                request.setAttribute("repeatPasswordErr", repeatPasswordErr);

                RequestDispatcher rd = request.getRequestDispatcher("updatePassword.jsp?error=true");
                rd.forward(request, response);
            }

        } catch (Exception ex) {
            Logger.getLogger(EditStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
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
