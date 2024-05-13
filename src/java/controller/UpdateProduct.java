/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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
import model.Category;
import model.Product;
import model.ProductService;
import model.Staff;

/**
 *
 * @author Thomas Cheam
 */
@WebServlet(name = "UpdateProduct", urlPatterns = {"/UpdateProduct", "/View/Admin/UpdateProduct"})
public class UpdateProduct extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    private static Date getTodayDate() {
        return new Date();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            String productId = request.getParameter("productid");
//            String img = request.getParameter("imagePath");
//            String imagePath = request.getParameter("imagepath");
            String productName = request.getParameter("productname");
            String productInfo = request.getParameter("productinfo");

            String price = request.getParameter("price");
            BigDecimal priceDecimal = new BigDecimal(price);

            int stock = Integer.parseInt(request.getParameter("stock"));

            String categoryId = request.getParameter("categoryid");

            HttpSession session = request.getSession();
            Staff staff = (Staff) session.getAttribute("staff");
            
            String lastCreate = request.getParameter("lastCreate");
            String lastModify = request.getParameter("lastModify");
            
            // Format the current date to a string
            String formattedDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Convert String into LocaDate
            LocalDate parsedDate = LocalDate.parse(formattedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate LCparsedDate = LocalDate.parse(lastCreate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            // Convert LocalDate to Date
            
            Date lastModifyDate = java.sql.Date.valueOf(parsedDate);
            Date lastCreateDate = java.sql.Date.valueOf(LCparsedDate);

           

            Category categoryStoreID = new Category(categoryId);

            String imagepath = "logo.png";

            Product product = new Product(productId, categoryStoreID, staff, productName, priceDecimal, stock, imagepath, productInfo, lastCreateDate, lastModifyDate);
            utx.begin();
            ProductService productService = new ProductService(em);
            boolean success = productService.updateProduct(product);
            utx.commit();
            session.setAttribute("success", success);
            response.sendRedirect("../../ViewProduct");

        } catch (Exception ex) {
            out.println(ex.getMessage());
            Logger.getLogger(ProductService.class.getName()).log(Level.SEVERE, null, ex);

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
