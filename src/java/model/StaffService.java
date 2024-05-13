/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;
import javax.annotation.Resource;
import javax.persistence.*;


public class StaffService {
    
    @PersistenceContext
    EntityManager mgr;
    @Resource
    Query query;
    
    public StaffService(EntityManager mgr) {
        this.mgr = mgr;
    }

    public boolean addStaff(Staff staff) {
        mgr.persist(staff);
        return true;
    }

    public Staff findStaffByID(String staffid) {
        Staff staff = mgr.find(Staff.class, staffid);
        return staff;
    }
    
    public boolean deleteStaff(String staffid) {
        Staff staff = findStaffByID(staffid);
        if (staff != null) {
            mgr.remove(staff);
            return true;
        }
        return false;
    }
    
    public List<Staff> findAll() {
        List staffList = mgr.createNamedQuery("Staff.findAll").getResultList();
        return staffList;
    }
    
    
    
    public boolean updateStaff(Staff staff) {
        Staff tempStaff = findStaffByID(staff.getStaffId());
        if (tempStaff != null) {
            tempStaff.setName(staff.getName());
            tempStaff.setContactNumber(staff.getContactNumber());
            tempStaff.setAddress(staff.getAddress());
            tempStaff.setPassword(staff.getPassword());
            tempStaff.setDateCreated(staff.getDateCreated());
            return true;
        }
        return false;
    }
    
}
