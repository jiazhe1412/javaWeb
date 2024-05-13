/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;

public class OrdersService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public OrdersService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public Orders findOrdersById(String orderid) {
        Orders order = mgr.find(Orders.class, orderid);
        return order;
    }

//    public Orders findOrder() {
//        Query query = mgr.createNamedQuery("Orders.findByCustomerAndStatus").getResultList();
//        return itemList;
//    }
    public List<Orders> findOrderListByCustomerId(Customer customerId) {
        Query query = mgr.createQuery("SELECT o FROM Orders o WHERE o.customerid = :customerid");
        query.setParameter("customerid", customerId);
        List<Orders> orderList = query.getResultList();
        return orderList;
    }
    
    
    public List<Orders> findOrderListByCustIdAndStatus(Customer customerId, String status) {
        Query query = mgr.createQuery("SELECT o FROM Orders o WHERE o.customerid = :customerid AND o.status = :status");
        query.setParameter("customerid", customerId);
        query.setParameter("status", status);
        List<Orders> orderList = query.getResultList();
        return orderList;
    }

    public String findOrdersByCustomerIdAndStatus(Customer customerId, String status) {
        Query query = mgr.createQuery("SELECT o.orderid FROM Orders o WHERE o.customerid = :customerid AND o.status = :status");
        query.setParameter("customerid", customerId);
        query.setParameter("status", status);
        List<String> orderIDs = query.getResultList();
        if (orderIDs.isEmpty()) {
            return null;
        } else {
            return orderIDs.get(0);
        }
    }

    //Find the orderNum to generate orderID
    public Integer getMaxOrderNum() {
        Query query = mgr.createQuery("SELECT MAX(o.ordernum) FROM Orders o");
        Integer maxOrderNum = (Integer) query.getSingleResult();
        if (maxOrderNum == null || maxOrderNum == 0) {
            return 1001; // Return 1 as the next order number if there are no existing orders or maxOrderNum is 0.
        } else {
            return maxOrderNum + 1;
        }
    }

    public String generateID() {
        // Get current date and time
        Date now = new Date();

        // Define the format for date and time
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

        // Format the current date and time
        String formattedDateTime = dateFormat.format(now);

        // Generate a unique identifier (e.g., 1001++)
        int uniqueOrderID = getMaxOrderNum();

        // Concatenate date/time and unique identifier to form the final ID
        String generatedID = formattedDateTime + uniqueOrderID;
        return generatedID;
    }

    public boolean addOrder(Orders order) {
        try {
            mgr.persist(order);
            return true; // Indicates the persistence operation didn't throw an exception
        } catch (Exception ex) {
            // Log the exception or handle it appropriately
            ex.printStackTrace();
            return false; // Indicates failure due to exception
        }
    }

}
