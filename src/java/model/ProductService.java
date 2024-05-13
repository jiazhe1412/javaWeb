package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;

public class ProductService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public ProductService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addItem(Product product) {
        mgr.persist(product);
        return true;
    }
    
    public boolean addProduct(Product product) {
        if (product != null) {
            mgr.persist(product);//uses persist method to add Product entity to the database
            return true;//Process successful return true
        }else{
            return false;
        }
    }

    public Product findProductById(String id) {
        Product product = mgr.find(Product.class, id);
        return product;
    }
    
    public Product findProductId(String productid) {
        Product product = mgr.find(Product.class, productid);
        return product;
    }

    public boolean deleteProduct(String id) {
        Product product = findProductById(id);
        if (product != null) {
            mgr.remove(product);
            return true;
        }
        return false;
    }

    public List<Product> findAll() {
        List productList = mgr.createNamedQuery("Product.findAll").getResultList();
        return productList;
    }

     public boolean updateProduct(Product product) {
        Product tempProduct = findProductId(product.getProductid());
        if (tempProduct != null) {
            tempProduct.setProductname(product.getProductname());
            tempProduct.setProductinfo(product.getProductinfo());
            tempProduct.setPrice(product.getPrice());
            tempProduct.setStockqty(product.getStockqty());
            tempProduct.setCategoryid(product.getCategoryid());
            tempProduct.setStaffid(product.getStaffid());
            tempProduct.setLastcreate(product.getLastcreate());
            tempProduct.setLastmodify(product.getLastmodify());
            return true;
        }
        return false;
    }
}
