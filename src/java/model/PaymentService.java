/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;


public class PaymentService {
    @PersistenceContext
    EntityManager manage;
    @Resource
    Query query;
    
    public PaymentService(EntityManager manage) {
        this.manage = manage;
    }

    public boolean addPaymentRecord(Payment payment) {
        manage.persist(payment);
        return true;
    }

    public Payment findByPaymentID(String paymentID) {
        Payment payment = manage.find(Payment.class, paymentID);
        return payment;
    }
    
    public Payment findPaymentByOrdersId(Orders orderid) {
        Query query = manage.createQuery("SELECT p FROM Payment p WHERE p.orderid = :orderid");
        query.setParameter("orderid", orderid);
        Payment payment = (Payment)query.getSingleResult();
        
            return payment;
        
    }

    public boolean deleteItem(String paymentID) {
        Payment payment = findByPaymentID(paymentID);
        if (payment != null) {
            manage.remove(payment);
            return true;
        }
        return false;
    }

    public List<Payment> findAll() {
        List paymentList = manage.createNamedQuery("Payment.findAll").getResultList();
        return paymentList;
    }

    public boolean updateItem(Payment payment) {
        Payment tempPay = findByPaymentID(payment.getPaymentid());
        if (tempPay != null) {
            tempPay.setPaymentmethod(payment.getPaymentmethod());
            tempPay.setPaymentdate(payment.getPaymentdate());
            tempPay.setCardname(payment.getCardname());
            tempPay.setCardnum(payment.getCardnum());
            tempPay.setCardexpdate(payment.getCardexpdate());
            tempPay.setCardcvv(payment.getCardcvv());
            tempPay.setShipaddress(payment.getShipaddress());
            tempPay.setTotalamount(payment.getTotalamount());
            tempPay.setPaymentstatus(payment.getPaymentstatus());
            return true;
        }
        return false;
    }
}


