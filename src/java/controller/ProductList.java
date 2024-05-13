/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.List;
import java.util.logging.*;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.Category;
import model.CategoryService;
import model.Discount;
import model.DiscountService;
import model.Product;
import model.ProductService;

/**
 *
 * @author Lee
 */
@WebServlet(name = "ProductList", urlPatterns = {"/ProductList"})
public class ProductList extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            PrintWriter out = response.getWriter();
            
            //Retrieve Category Data in database
            CategoryService categoryService = new CategoryService(em);
            List<Category> categoryList = categoryService.findAll();
            session.setAttribute("categoryList", categoryList);

            //Retrieve Product List in database
            ProductService productService = new ProductService(em);
            List<Product> productList = productService.findAll();
            session.setAttribute("productList", productList);
            
            //retrieve Discount in Database
            DiscountService discountService = new DiscountService(em);
            List<Discount> discountList = discountService.findAll();
            session.setAttribute("discountList", discountList);
           

            response.sendRedirect("View/Client/Product.jsp");
        } catch (Exception ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
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
