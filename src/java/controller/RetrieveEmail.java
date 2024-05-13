package controller;

import model.Customer;
import model.CustomerService;
import java.io.*;
import java.util.*;
import java.util.logging.*;
import java.security.*;
import javax.annotation.Resource;
import javax.servlet.annotation.WebServlet;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.transaction.UserTransaction;

@WebServlet(name = "RetrieveEmail", urlPatterns = {"/RetrieveEmail", "/View/Client/RetrieveEmail"})
public class RetrieveEmail extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("resend".equals(action)) {
            String email = request.getParameter("email");
            resendOTP(email, request, response);
        } else {

            String email = request.getParameter("email");

            CustomerService customerService = new CustomerService(em);
            Customer customer = customerService.findCustomerByEmail(email);
            HttpSession session = request.getSession();
            if (customer != null) {
                String otp = generateOTP();

                String hashedOTP = null;
                try {
                    MessageDigest digest = MessageDigest.getInstance("SHA-256");
                    byte[] hashBytes = digest.digest(otp.getBytes());
                    StringBuilder hexString = new StringBuilder();
                    for (byte hashByte : hashBytes) {
                        String hex = Integer.toHexString(0xff & hashByte);
                        if (hex.length() == 1) {
                            hexString.append('0');
                        }
                        hexString.append(hex);
                    }
                    hashedOTP = hexString.toString();
                } catch (NoSuchAlgorithmException e) {
                    // Handle the case where SHA-256 algorithm is not available
                    e.printStackTrace();
                }

                session.setAttribute("email", email);
                session.setAttribute("otp", otp);
                response.sendRedirect("otp.jsp?" + "&email=" + email + "&hashedOTP=" + hashedOTP);
            } else {
                session.setAttribute("validationError", "Email not found!");
                response.sendRedirect("login.jsp?error=empty");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    // Removed sendEmail() method
    private String generateOTP() {
        int otpLength = 6;
        int min = (int) Math.pow(10, otpLength - 1);
        int max = (int) Math.pow(10, otpLength) - 1;

        Random random = new Random();
        int otp = random.nextInt(max - min + 1) + min;
        return Integer.toString(otp);
    }

    private void resendOTP(String email, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerService customerService = new CustomerService(em);
        Customer customer = customerService.findCustomerByEmail(email);
        HttpSession session = request.getSession();

        if (customer != null) {
            String otp = generateOTP();

            String hashedOTP = null;
            try {
                MessageDigest digest = MessageDigest.getInstance("SHA-256");
                byte[] hashBytes = digest.digest(otp.getBytes());
                StringBuilder hexString = new StringBuilder();
                for (byte hashByte : hashBytes) {
                    String hex = Integer.toHexString(0xff & hashByte);
                    if (hex.length() == 1) {
                        hexString.append('0');
                    }
                    hexString.append(hex);
                }
                hashedOTP = hexString.toString();
            } catch (NoSuchAlgorithmException e) {
                // Handle the case where SHA-256 algorithm is not available
                e.printStackTrace();
            }
            session.setAttribute("email", email);
            session.setAttribute("otp", otp);
            response.sendRedirect("otp.jsp?email=" + email + "&hashedOTP=" + hashedOTP);
        } else {
            session.setAttribute("validationError", "Email not found!");
            response.sendRedirect("login.jsp?error=empty");
        }
    }
}
