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
import model.Customer;
import model.Orders;
import model.OrdersService;
import model.Placeorder;
import model.PlaceorderService;
import model.Product;

/**
 *
 * @author Lee
 */
@WebServlet(name = "AddtoCart", urlPatterns = {"/AddtoCart"})
public class AddtoCart extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        //Declare session and writer
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        //The request value
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        //Get the login customer ID
        Customer customerID = (Customer) session.getAttribute("customer");

        Customer customer = new Customer(customerID.getCustomerId());

        //Get the product that selected
        Product productInfo = (Product) session.getAttribute("productInfo");

        OrdersService ordersService = new OrdersService(em);
        PlaceorderService placeorderService = new PlaceorderService(em);

        //Find OrderID Exist
        String findOrderID = ordersService.findOrdersByCustomerIdAndStatus(customer, "PENDING");
        session.setAttribute("findOrderID", findOrderID);

        //Order Exist
        if (findOrderID != null) {
            out.print("Exist" + "<br/>");
            Orders orderID = new Orders(findOrderID);
            Product productID = new Product(productInfo.getProductid());

            try {
                Placeorder placeorderList = placeorderService.getPlaceOrderListByProductIdAndOrderId(
                        productID, orderID);

                if (placeorderList != null) {
                    String placeorderID = placeorderList.getPlaceorderid();
                    int placeorderNum = placeorderList.getPlaceordernum();
                    int retrieveQuantity = placeorderList.getQuantity();
                    int totalQuantity = quantity + retrieveQuantity;

                    if (totalQuantity <= productInfo.getStockqty()) {
                        Placeorder placeorder = new Placeorder(placeorderID, productID,
                                orderID, placeorderNum, totalQuantity);
                        utx.begin();
                        boolean success = placeorderService.updatePlaceorder(placeorder);
                        utx.commit();

                        if (success) {
                            out.print("Place Order added successfully<br/>");
                            session.setAttribute("placeordersuccess", true);
                        } else {
                            out.print("Failed to add place order<br/>");
                            session.setAttribute("placeorderUnsuccess", true);
                        }
                    } else {
                        session.setAttribute("placeorderUnsuccess", true);
                    }
                } else {
                    //New Placeorder
                    String newPlaceorderID = "P" + placeorderService.getMaxPlaceOrderNum();
                    int newPlaceorderNum = placeorderService.getMaxPlaceOrderNum();

                    if (quantity <= productInfo.getStockqty()) {
                        Placeorder placeNewOrder = new Placeorder(newPlaceorderID, productID, orderID, newPlaceorderNum, quantity);

                        utx.begin();
                        boolean success = placeorderService.addPlaceorder(placeNewOrder);
                        utx.commit();

                        if (success) {
                            out.print("Place Order added successfully<br/>");
                            session.setAttribute("placeordersuccess", true);
                        } else {
                            out.print("Failed to add place order<br/>");
                            session.setAttribute("placeorderUnsuccess", true);
                        }
                    } else {
                        session.setAttribute("placeorderUnsuccess", true);
                    }
                }
            } catch (Exception ex) {
                // Log the exception or handle it appropriately
                Logger.getLogger(AddtoCart.class.getName()).log(Level.SEVERE, "An error occurred while adding order: " + ex.getMessage(), ex);
            }

        } //order Not exist
        else {
            //Insert the order
            //order ID
            String orderID = ordersService.generateID();
            int uniqueOrderID = ordersService.getMaxOrderNum();

            try {
                Orders order = new Orders(orderID, uniqueOrderID, customer, "PENDING");
                out.print(order.getCustomerid().getCustomerId() + "<br>");
                OrdersService ordersService2 = new OrdersService(em);
                utx.begin();
                boolean success = ordersService2.addOrder(order);
                utx.commit();
//                out.print(success + "</br>");

                if (success) {
                    out.print("Order added successfully<br/>");
                    session.setAttribute("order", order);
                } else {
                    out.print("Failed to add order<br/>");
                }
            } catch (Exception ex) {
                // Log the exception or handle it appropriately
                Logger.getLogger(AddtoCart.class.getName()).log(Level.SEVERE, "An error occurred while adding order: " + ex.getMessage(), ex);
            }

            //Insert the place order
            PlaceorderService placeService = new PlaceorderService(em);

            //Get Placeorder ID
            String placeorderID = "P" + String.valueOf(placeService.getMaxPlaceOrderNum());
            int placeorderNum = placeService.getMaxPlaceOrderNum();
            out.print(placeorderID);

            Product storeProductID = new Product(productInfo.getProductid());
            Orders storeOrderID = new Orders(orderID);

            try {
                Placeorder placeOrder = new Placeorder(placeorderID, storeProductID, storeOrderID, placeorderNum, quantity);

                utx.begin();
                boolean success = placeService.addPlaceorder(placeOrder);
                utx.commit();
//                out.print(success + "</br>");

                if (success) {
                    out.print("Place order added successfully<br/>");
                    session.setAttribute("placeordersuccess", true);
                } else {
                    out.print("Failed to add place order<br/>");
                    session.setAttribute("placeorderUnsuccess", true);
                }
            } catch (Exception ex) {
                // Log the exception or handle it appropriately
                Logger.getLogger(AddtoCart.class.getName()).log(Level.SEVERE, "An error occurred while adding order: " + ex.getMessage(), ex);
            }
        }
        session.setAttribute("quantity", quantity);
        response.sendRedirect("View/Client/ProductInformation.jsp");
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
