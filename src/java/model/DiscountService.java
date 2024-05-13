/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;


public class DiscountService {
    
    @PersistenceContext
    EntityManager em;
    @Resource
    Query query;
    
    public DiscountService(EntityManager em) {
        this.em = em;
    }

    public boolean addDiscount(Discount discount) {
        em.persist(discount);
        return true;
    }

    public Discount findDiscountByID(String discountID) {
        Discount discount = em.find(Discount.class, discountID);
        return discount;
    }
    
    public boolean deleteDiscount(String discountID) {
        Discount discount= findDiscountByID(discountID);
        if (discount != null) {
            em.remove(discount);
            return true;
        }
        return false;
    }
    
    public List<Discount> findDiscountByProductID(Product productid) {
        Query query = em.createQuery("SELECT d FROM Discount d WHERE d.productid = :productid");
        query.setParameter("productid", productid);
        
        List<Discount> placeorderList = query.getResultList();

        return placeorderList;
    }
    
    public List<Discount> findAll() {
        List discountList = em.createNamedQuery("Discount.findAll").getResultList();
        return discountList;
    }
    
    
    
    public boolean updateDiscount(Discount discount) {
        Discount tempDiscount = findDiscountByID(discount.getDiscountid());
        if (tempDiscount != null) {
            tempDiscount.setStaffCreated(discount.getStaffCreated());
            tempDiscount.setDiscounttype(discount.getDiscounttype());
            tempDiscount.setDiscountrate(discount.getDiscountrate());
            tempDiscount.setDiscountDescription(discount.getDiscountDescription());
            tempDiscount.setActivateDate(discount.getActivateDate());
            tempDiscount.setExpireDate(discount.getExpireDate());
            tempDiscount.setProductid(discount.getProductid());
            return true;
        }
        return false;
    }
    
}
