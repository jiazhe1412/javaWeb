/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
import model.Customer;
import model.Orders;
import model.OrdersService;
import model.Placeorder;
import model.PlaceorderService;

@WebServlet(name = "DisplayCart", urlPatterns = {"/DisplayCart"})
public class DisplayCart extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            OrdersService ordersService = new OrdersService(em);
            PlaceorderService ps = new PlaceorderService(em);
            Customer customerID = (Customer) session.getAttribute("customer");
            //Customer setCustomerID = new Customer(customerID);
            Customer setCustomerID = new Customer(customerID.getCustomerId());

            String findOrderID = ordersService.findOrdersByCustomerIdAndStatus(setCustomerID, "PENDING");
            session.setAttribute("findOrderID", findOrderID);

            String orderID = (String) session.getAttribute("findOrderID");
            Orders setOrderID = new Orders(orderID);

            utx.begin();
            List<Placeorder> placeorderList = ps.findPlaceorderByOrderId(setOrderID, setCustomerID);
            out.println(placeorderList);
            utx.commit();
            session.setAttribute("cartList", placeorderList);
            response.sendRedirect("View/Client/Cart.jsp");
        } catch (Exception ex) {
            out.println("<p>" + ex.getMessage() + "</p>");
//            Logger.getLogger(DisplayCart.class.getName()).log(Level.SEVERE, null, ex);
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
