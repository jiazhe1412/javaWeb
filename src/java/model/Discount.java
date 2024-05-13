/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author User
 */
@Entity
@Table(name = "DISCOUNT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Discount.findAll", query = "SELECT d FROM Discount d"),
    @NamedQuery(name = "Discount.findByDiscountid", query = "SELECT d FROM Discount d WHERE d.discountid = :discountid"),
    @NamedQuery(name = "Discount.findByStaffCreated", query = "SELECT d FROM Discount d WHERE d.staffCreated = :staffCreated"),
    @NamedQuery(name = "Discount.findByDiscounttype", query = "SELECT d FROM Discount d WHERE d.discounttype = :discounttype"),
    @NamedQuery(name = "Discount.findByDiscountrate", query = "SELECT d FROM Discount d WHERE d.discountrate = :discountrate"),
    @NamedQuery(name = "Discount.findByDiscountDescription", query = "SELECT d FROM Discount d WHERE d.discountDescription = :discountDescription"),
    @NamedQuery(name = "Discount.findByActivateDate", query = "SELECT d FROM Discount d WHERE d.activateDate = :activateDate"),
    @NamedQuery(name = "Discount.findByExpireDate", query = "SELECT d FROM Discount d WHERE d.expireDate = :expireDate")})
public class Discount implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "STAFF_CREATED")
    private String staffCreated;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "DISCOUNTTYPE")
    private String discounttype;
    @Size(max = 200)
    @Column(name = "DISCOUNT_DESCRIPTION")
    private String discountDescription;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ACTIVATE_DATE")
    @Temporal(TemporalType.DATE)
    private Date activateDate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "EXPIRE_DATE")
    @Temporal(TemporalType.DATE)
    private Date expireDate;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5)
    @Column(name = "DISCOUNTID")
    private String discountid;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "DISCOUNTRATE")
    private Double discountrate;
    @JoinColumn(name = "PRODUCTID", referencedColumnName = "PRODUCTID")
    @ManyToOne(optional = false)
    private Product productid;

    private List<Discount> discountList;

    public Discount() {
    }

    public Discount(String discountid) {
        this.discountid = discountid;
    }

    public Discount(String discountid, String staffCreated, String discounttype, double discountrate, String discountDesciption, Date activateDate, Date expireDate, Product productid) {
        this.discountid = discountid;
        this.staffCreated = staffCreated;
        this.discounttype = discounttype;
        this.discountrate = discountrate;
        this.discountDescription = discountDesciption;
        this.activateDate = activateDate;
        this.expireDate = expireDate;
        this.productid = productid;
    }
    
    public List<Discount> findAll(){
        System.out.println("discountList: "+discountList.size());
        return this.discountList;
    }
    public void AddDiscount(List<Discount> dislist){
        this.discountList = new ArrayList<Discount>(dislist);
        System.out.println("added"+discountList.size());
    }

    public String getDiscountid() {
        return discountid;
    }

    public void setDiscountid(String discountid) {
        this.discountid = discountid;
    }

    public String getStaffCreated() {
        return staffCreated;
    }

    public void setStaffCreated(String staffCreated) {
        this.staffCreated = staffCreated;
    }

    public Double getDiscountrate() {
        return discountrate;
    }

    public void setDiscountrate(Double discountrate) {
        this.discountrate = discountrate;
    }

    public String getDiscountDescription() {
        return discountDescription;
    }

    public void setDiscountDescription(String discountDescription) {
        this.discountDescription = discountDescription;
    }

    public Date getActivateDate() {
        return activateDate;
    }

    public void setActivateDate(Date activateDate) {
        this.activateDate = activateDate;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public Product getProductid() {
        return productid;
    }

    public void setProductid(Product productid) {
        this.productid = productid;
    }

    public double calculateDiscountTotalPrice(BigDecimal price, double discountrate) {
        double productPrice = Double.parseDouble(String.valueOf(price));
        double rate = discountrate;
        double totalPrice;

        totalPrice = productPrice * ((100 - rate) / 100);
        totalPrice = Math.round(totalPrice * 100.0) / 100.0;

        return totalPrice;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (discountid != null ? discountid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Discount)) {
            return false;
        }
        Discount other = (Discount) object;
        if ((this.discountid == null && other.discountid != null) || (this.discountid != null && !this.discountid.equals(other.discountid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Discount[ discountid=" + discountid + " ]";
    }

   

   

    public String getDiscounttype() {
        return discounttype;
    }

    public void setDiscounttype(String discounttype) {
        this.discounttype = discounttype;
    }

}
