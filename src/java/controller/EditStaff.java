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

@WebServlet(name = "EditStaff", urlPatterns = {"/EditStaff", "/View/Admin/EditStaff"})
public class EditStaff extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            StaffService staffService = new StaffService(em);
            String name = request.getParameter("name");
            String contactnumber = request.getParameter("contactnumber");
            String address = request.getParameter("address");
            String staffId = request.getParameter("staffId");

            Staff existingStaff = em.find(Staff.class, staffId);

            boolean isValid = true;
            String nameErr = "";
            String contactNumberErr = "";

            if (!validateName(name)) {
                nameErr = "Invalid name format.";
                isValid = false;
            }

            if (!validateContactNumber(contactnumber)) {
                contactNumberErr = "Invalid contact number, must be numbers.";
                isValid = false;
            }

            if (existingStaff != null && isValid) {
                existingStaff.setName(name);
                existingStaff.setContactNumber(contactnumber);
                existingStaff.setAddress(address);

                utx.begin();
                em.merge(existingStaff);
                utx.commit();

                HttpSession session = request.getSession();
                session.setAttribute("staffUpdated", true);
                response.sendRedirect("ViewStaff");

            } else {
                request.setAttribute("nameErr", nameErr);
                request.setAttribute("contactNumberErr", contactNumberErr);

                RequestDispatcher rd = request.getRequestDispatcher("editStaff.jsp?error=true");
                rd.forward(request, response);
            }

        } catch (Exception ex) {
            Logger.getLogger(EditStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean validateName(String custname) {
        return custname.matches("[a-zA-Z ]+");
    }

    private boolean validateContactNumber(String contactnumber) {
        return contactnumber.matches("\\d{10,11}");
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
