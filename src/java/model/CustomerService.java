/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;

public class CustomerService {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;

    public CustomerService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addCustomer(Customer customer) {
        mgr.persist(customer);
        return true;
    }

    public Customer findCustomerByID(String customerid) {
        Customer customer = mgr.find(Customer.class, customerid);
        return customer;
    }

    public Customer findCustomerByEmail(String email) {
        TypedQuery<Customer> query = mgr.createQuery(
                "SELECT c FROM Customer c WHERE c.email = :email", Customer.class);
        query.setParameter("email", email);

        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public boolean deleteCustomer(String customerid) {
        Customer customer = findCustomerByID(customerid);
        if (customer != null) {
            mgr.remove(customer);
            return true;
        }
        return false;
    }

    public List<Customer> findAll() {
        List customerList = mgr.createNamedQuery("Customer.findAll").getResultList();
        return customerList;
    }

    public boolean updateCustomer(Customer customer) {
        Customer tempCustomer = findCustomerByID(customer.getCustomerId());
        if (tempCustomer != null) {
            tempCustomer.setCustomerName(customer.getCustomerName());
            tempCustomer.setEmail(customer.getEmail());
            tempCustomer.setAddress(customer.getAddress());
            tempCustomer.setContactnumber(customer.getContactnumber());
            tempCustomer.setBirthdate(customer.getBirthdate());
            tempCustomer.setPassword(customer.getPassword());
            return true;
        }
        return false;
    }

}
