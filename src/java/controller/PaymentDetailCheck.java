/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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

/**
 *
 * @author User
 */
@WebServlet(name = "PaymentDetailCheck", urlPatterns = {"/PaymentDetailCheck"})
public class PaymentDetailCheck extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String url = "jdbc:derby://localhost:1527/GUI";
        String username = "users";
        String password = "12345";

        String cardType, cardName, cardNum, cardExpDate, cardCvv, walletType;
        int cardcvv = 0;
        try {
            // Format the current date to a string
            String formattedDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Convert String into LocaDate
            LocalDate parsedDate = LocalDate.parse(formattedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            // Convert LocalDate to Date
            Date paymentDate = java.sql.Date.valueOf(parsedDate);

            String paymentMethod = request.getParameter("paymentMethod");
            if (paymentMethod.equals("creditCard")) {
                cardType = request.getParameter("cardType");
                cardName = request.getParameter("cardName");
                cardNum = request.getParameter("cardNum");
                cardExpDate = request.getParameter("expDate");
                cardCvv = request.getParameter("cvv");
                walletType = "none";
            } else if (paymentMethod.equals("ewallet")) {
                walletType = request.getParameter("walletType");
                cardType = "none";
                cardName = "none";
                cardNum = "none";
                cardExpDate = "none";
                cardCvv = "0";
            } else {
                walletType = "none";
                cardType = "none";
                cardName = "none";
                cardNum = "none";
                cardExpDate = "none";
                cardCvv = "0";
            }

            String email = request.getParameter("email");
            String fullname = request.getParameter("fullname");
            String street1 = request.getParameter("street1");
            String street2 = request.getParameter("street2");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip = request.getParameter("zip");
            String shipaddress = (street1 + " \n" + street2 + " \n" + zip + ", " + state + ", " + city);
            Double totalprice = (Double)session.getAttribute("total");
            BigDecimal total = BigDecimal.valueOf(totalprice);
            String status = "SUCCESS";

            OrdersService os = new OrdersService(em);
            String orderid = (String)session.getAttribute("findOrderID");
            Orders order = os.findOrdersById(orderid);

            //verification of user input data
            String[] errorList = new String[10];
            errorList[0] = checkPaymentMethod(paymentMethod);
            if (paymentMethod.equals("creditCard") && errorList[0].equals("none")) {
                errorList[1] = checkCardName(cardName);
                errorList[2] = checkCardNum(cardNum);
                errorList[3] = checkCardExpDate(cardExpDate);
                errorList[4] = checkCardCvv(cardCvv);
                errorList[5] = checkFullname(fullname);
                errorList[6] = checkStreet(street1, street2);
                errorList[7] = checkCity(city);
                errorList[8] = checkState(state);
                errorList[9] = checkZip(zip);

            } else {
                errorList[1] = "none";
                errorList[2] = "none";
                errorList[3] = "none";
                errorList[4] = "none";
                errorList[5] = checkFullname(fullname);
                errorList[6] = checkStreet(street1, street2);
                errorList[7] = checkCity(city);
                errorList[8] = checkState(state);
                errorList[9] = checkZip(zip);

            }

            int errorCount = 0;
            for (String error : errorList) {
                if (!error.equals("none")) {
                    errorCount++;
                }
            }

            // check whether it have any error or not.
            // if not, it will create the payment id and payment object to store the value
            if (errorCount != 0) {

                session.removeAttribute("paymentError");
                session.setAttribute("paymentError", errorList);
                response.sendRedirect("View/Client/CheckOut.jsp");

            } else {
                session.removeAttribute("paymentError");

                try {
                    cardcvv = Integer.parseInt(cardCvv);
                } catch (NumberFormatException e) {
                    out.println("<p>" + e.getMessage() + "</p>");
                }

                StringBuilder result = new StringBuilder();
                for (int i = 0; i < cardNum.length(); i++) {
                    if (i % 4 == 0 && i != 0) {
                        result.append(" ");
                    }

                    result.append(cardNum.charAt(i));
                }

                Payment payment = new Payment(order, paymentDate, paymentMethod, walletType, cardType, cardName, cardNum, cardExpDate, cardcvv, total, shipaddress, status, email);

                try {
                    Connection connection = DriverManager.getConnection(url, username, password);
                    Statement statement = connection.createStatement();

                    String sql = "SELECT * FROM PAYMENT WHERE PAYMENTID = (SELECT MAX(PAYMENTID) FROM PAYMENT)";
                    ResultSet resultSet = statement.executeQuery(sql);

                    if (resultSet.next()) {
                        String paymentId = resultSet.getString("PAYMENTID");
                        int lastid = Integer.parseInt(paymentId);
                        lastid++;
                        payment.setPaymentid(Integer.toString(lastid));

                    } else {
                        payment.setPaymentid("3001");

                    }

                    resultSet.close();
                    statement.close();
                    connection.close();

                } catch (SQLException sqle) {
                    out.println("<p>" + sqle.getMessage() + "</p><p> error</p>");
                }

                session.setAttribute("paymentRecord", payment);

//                out.println(payment.getCardcvv());
//                out.println(payment.getCardexpdate());
//                out.println(payment.getCardname());
//                out.println(payment.getCardnum());
//                out.println(payment.getCardtype());
//                out.println(payment.getEmail());
//                out.println(payment.getPaymentdate());
//                out.println(payment.getPaymentmethod());
//                out.println(payment.getPaymentstatus());
//                out.println(payment.getShipaddress());
//                out.println(payment.getTotalamount());
//                out.println(payment.getWallettype());
                response.sendRedirect("View/Client/Review.jsp");
            }

        } catch (Exception e) {
            out.println("<p>" + e.getMessage() + "</p>");
        }

    }

    public String checkPaymentMethod(String paymentMethod) {

        if (paymentMethod.equals("none")) {
            return "Please choose a payment method.";
        } else {
            return "none";
        }
    }

    public String checkCardName(String cardName) {
        String error = "none";

        if (cardName.equals("")) {
            error = "The Card Name should not be null";
        } else if (!cardName.matches("[a-zA-Z ]+")) {
            error = "The Card Name contain invalid character.";
        }

        return error;
    }

    public String checkCardNum(String cardNum) {
        String error = "none";

        if (cardNum.equals("")) {
            error = "The Card Number should not be null";
        } else if (!cardNum.matches("[0-9]{16}")) {
            error = "The card number should not contain other character.";
        } else if (cardNum.length() < 16) {
            error = "The card number should contain 16 numbers.";
        }

        return error;
    }

    public String checkCardExpDate(String cardExpDate) {
        String error = "none";
        if (cardExpDate.equals("")) {
            error = "The Card Expiry Date should not be null";
        } else if (!cardExpDate.matches("(?:0[1-9]|1[0-2])/[2-9][4-9]")) {
            error = "Invalid expiry date";
        }

        return error;
    }

    public String checkCardCvv(String cardCvv) {
        String error = "none";

        if (cardCvv.equals("")) {
            error = "The Card Cvv should not be null";
        } else if (cardCvv.length() != 3) {
            error = "The Card Cvv should contain three numbers";
        } else if (!cardCvv.matches("[0-9]+")) {
            error = "Invalid character found in Card Cvv";
        }

        return error;
    }

    public String checkFullname(String fullname) {
        String error = "none";

        if (!fullname.matches("[a-zA-Z ]+")) {
            error = "The Full name contain invalid character.";
        }

        return error;
    }

    public String checkStreet(String street1, String street2) {
        String error = "none";

        if (!street1.matches("[A-Za-z0-9 ,-]+")) {
            error = "Invalid character found in street";
        }

        if (!street2.matches("[A-Za-z0-9 ,-]+")) {
            error = "Invalid character found in street";
        }

        return error;
    }

    public String checkCity(String city) {
        String error = "none";

        if (!city.matches("[a-zA-Z ]+")) {
            error = "Invalid character in City found";
        }

        return error;
    }

    public String checkState(String state) {
        String error = "none";

        if (!state.matches("[a-zA-Z ]+")) {
            error = "Invalid character in State found";
        }

        return error;
    }

    public String checkZip(String zipcode) {
        String error = "none";

        try {
            int zip = Integer.parseInt(zipcode);
        } catch (NumberFormatException nfe) {
            error = "Invalid character found in zip code";
        }

        return error;
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
