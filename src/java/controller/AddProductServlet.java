/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Category;
import model.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.logging.*;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Product;
import model.ProductService;

/**
 *
 * @author Thomas Cheam
 */
@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProductServlet", "/View/Admin/AddProductServlet"})
public class AddProductServlet extends HttpServlet {

    @PersistenceContext
    EntityManager emg;
    @Resource
    UserTransaction utx;

    private String getProductId() {
        Query query = emg.createQuery("SELECT MAX(p.productid) FROM Product p");
        String maxProductIdStr = (String) query.getSingleResult();
        if (maxProductIdStr == null || maxProductIdStr.isEmpty()) {
            return "1001";
        } else {
            return Integer.toString(Integer.parseInt(maxProductIdStr) + 1);
        }
    }

    private static Date getTodayDate() {
        return new Date();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();

            String productId = getProductId();
            String categoryid = request.getParameter("categoryid");

//            String staffId = session.getAttribute("staff");
//            Part filePart = request.getPart("fileChooser"); 
//                        ImageFile imgFile = null;
//                        out.println(imgFile + "9<br/>");
            String productName = request.getParameter("productname");
            String price = request.getParameter("price");
            //            BigDecimal priceDecimal = BigDecimal.valueOf(Double.valueOf(price));
            BigDecimal priceDecimal = new BigDecimal(price);
            String stockqty = request.getParameter("stock");
            int stock = Integer.parseInt(stockqty);
            String productInfo = request.getParameter("productinfo");

            // Format the current date to a string
            String formattedDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Convert String into LocaDate
            LocalDate parsedDate = LocalDate.parse(formattedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Convert LocalDate to Date
            Date lastCreate = java.sql.Date.valueOf(parsedDate);
            Date lastModify = java.sql.Date.valueOf(parsedDate);
            Category categoryStoreID = new Category(categoryid);
            out.println(categoryStoreID);

            Staff staffStoreID = (Staff) session.getAttribute("staff");

            //Image File checking
//            if(filePart != null){
//                InputStream inStream = filePart.getInputStream();  
//                imgFile = new ImageFile(inStream, filePart.getSize());   
//            }
            //temporary
            String imagepath = "logo.png";
            Product product = new Product(productId, categoryStoreID, staffStoreID, productName, priceDecimal, stock, imagepath, productInfo, lastCreate, lastModify);
            
            if (categoryid != null && staffStoreID != null && productName != null && priceDecimal != null && productInfo != null) {
                utx.begin();
                ProductService productService = new ProductService(emg);
                boolean success = productService.addProduct(product);
                utx.commit();
                session.setAttribute("success", success);
                response.sendRedirect("../../ViewProduct");
            } else {
                out.println("Please fill in all the information!");
            }

        } catch (Exception ex) {
            out.println(ex.getMessage());
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
