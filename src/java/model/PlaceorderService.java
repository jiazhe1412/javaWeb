package model;

import javax.persistence.Query;
import java.util.List;
import javax.persistence.*;

public class PlaceorderService {

    @PersistenceContext
    EntityManager mgr;

    public PlaceorderService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public List<Placeorder> findAll() {
        List<Placeorder> placeorderList = null;

        try {
            Query query = mgr.createQuery("SELECT p FROM Placeorder p");
            placeorderList = query.getResultList();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return placeorderList;
    }

    public List<Placeorder> findPlaceorderByOrderId(Orders orderID, Customer customerID) {
        List<Placeorder> placeorderList = null;

        try {
            Query query = mgr.createQuery("SELECT DISTINCT p FROM Placeorder p JOIN Orders o WHERE p.orderid = :orderid AND o.customerid = :customerid");
            query.setParameter("orderid", orderID);
            query.setParameter("customerid", customerID);

            placeorderList = query.getResultList();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return placeorderList;
    }

    public Integer getMaxPlaceOrderNum() {
        Query query = mgr.createQuery("SELECT MAX(p.placeordernum) FROM Placeorder p");
        Integer maxPlaceOrderNum = (Integer) query.getSingleResult();
        if (maxPlaceOrderNum == null || maxPlaceOrderNum == 0) {
            return 1001; // Return 1 as the next order number if there are no existing orders or maxOrderNum is 0.
        } else {
            return maxPlaceOrderNum + 1;
        }
    }

    public boolean addPlaceorder(Placeorder placeOrder) {
        try {
            mgr.persist(placeOrder);
            return true; // Indicates the persistence operation didn't throw an exception
        } catch (Exception ex) {
            // Log the exception or handle it appropriately
            ex.printStackTrace();
            return false; // Indicates failure due to exception
        }
    }

    public Integer getTotalQuantityByProductIdAndOrderId(Product productid, Orders orderid) {
        // Assuming mgr is an EntityManager
        Query query = mgr.createQuery("SELECT p.quantity FROM Placeorder p WHERE p.productid = :productid AND p.orderid = :orderid");

        // Set the parameter with the fetched Product object
        query.setParameter("productid", productid);
        query.setParameter("orderid", orderid);

        Integer quantity = (Integer) query.getSingleResult();

        return quantity;
    }

    public Placeorder getPlaceOrderListByProductIdAndOrderId(Product productid, Orders orderid) {
        Query query = mgr.createQuery("SELECT p FROM Placeorder p WHERE p.productid.productid = :productid AND p.orderid.orderid = :orderid");

        query.setParameter("productid", productid.getProductid());
        query.setParameter("orderid", orderid.getOrderid());

        Placeorder placeorderList = null;
        try {
            placeorderList = (Placeorder) query.getSingleResult();
        } catch (NoResultException | NonUniqueResultException ex) {
            // Handle the exception, e.g., log it or return null
            ex.printStackTrace(); // for demonstration, replace with appropriate handling
        }

        return placeorderList;
    }

    public Placeorder findPlaceorderById(String placeorderID) {
        Placeorder placeorder = mgr.find(Placeorder.class, placeorderID);
        return placeorder;
    }

    public boolean updatePlaceorder(Placeorder placeorder) {
        Placeorder tempPlaceorder = findPlaceorderById(placeorder.getPlaceorderid());
        if (tempPlaceorder != null) {
            tempPlaceorder.setQuantity(placeorder.getQuantity());
            return true;
        }
        return false;
    }

    public boolean deleteOrder(String placeorderID) {
        Placeorder placeorder = findPlaceorderById(placeorderID);
        if (placeorder != null) {
            mgr.remove(placeorder);
            return true;
        }
        return false;
    }

    public boolean deleteAllOrder(Orders orderID) {
        try {
            Query query = mgr.createQuery("DELETE FROM Placeorder p WHERE p.orderid = :orderid");
            query.setParameter("orderid", orderID);
            query.executeUpdate();
            return true;

        } catch (Exception e) {
            // Handle exception if any
            e.printStackTrace();
            return false;
        }
    }

}
