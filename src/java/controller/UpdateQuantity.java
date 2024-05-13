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
import model.Placeorder;
import model.PlaceorderService;
import model.Product;

/**
 *
 * @author Lee
 */
@WebServlet(name = "UpdateQuantity", urlPatterns = {"/UpdateQuantity"})
public class UpdateQuantity extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String clickedButton = request.getParameter("button");
        int maxQuantity = Integer.parseInt(request.getParameter("maxQuantity"));
        int quantity = Integer.parseInt(request.getParameter("quantityBox"));

        String error = "";

        if (quantity == 0) {
            error = "Quantity cannot set to 0. ";
        } else if (quantity > maxQuantity) {
            error = "Insufficient Stock. ";
        } else {
            session.removeAttribute("error");

            if (clickedButton.equals("Update")) {
                PlaceorderService ps = new PlaceorderService(em);

                String customerID = (String) session.getAttribute("customerID");
                Customer setCustomerID = new Customer(customerID);

                String orderID = request.getParameter("orderID");
                Orders orderSetId = new Orders(orderID);

                String placeOrderID = request.getParameter("placeOrderID");
                String productID = request.getParameter("productID");
                Product productSetId = new Product(productID);
                int placeorderNum = Integer.parseInt(request.getParameter("placeorderNum"));
                try {
                    Placeorder pl = new Placeorder(placeOrderID, productSetId, orderSetId, placeorderNum, quantity);

                    utx.begin();
                    boolean success = ps.updatePlaceorder(pl);
                    utx.commit();

                } catch (Exception ex) {
                    Logger.getLogger(UpdateQuantity.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    session.removeAttribute("cartList");
                    List<Placeorder> placeorderList = ps.findPlaceorderByOrderId(orderSetId, setCustomerID);
                    session.setAttribute("cartList", placeorderList);
                    response.sendRedirect("View/Client/SendtoCart.jsp");
                }

            } else if (clickedButton.equals("Cancel")) {
                session.removeAttribute("editQuantity");
                response.sendRedirect("View/Client/Cart.jsp");
            }
        }

        session.setAttribute("error", error);

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
