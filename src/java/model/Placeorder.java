/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Lee
 */
@Entity
@Table(name = "PLACEORDER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Placeorder.findAll", query = "SELECT p FROM Placeorder p"),
    @NamedQuery(name = "Placeorder.findByPlaceorderid", query = "SELECT p FROM Placeorder p WHERE p.placeorderid = :placeorderid"),
    @NamedQuery(name = "Placeorder.findByQuantity", query = "SELECT p FROM Placeorder p WHERE p.quantity = :quantity")})
public class Placeorder implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "PLACEORDERNUM")
    private int placeordernum;
    @Basic(optional = false)
    @NotNull
    @Column(name = "QUANTITY")
    private int quantity;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 16)
    @Column(name = "PLACEORDERID")
    private String placeorderid;
    @JoinColumn(name = "ORDERID", referencedColumnName = "ORDERID")
    @ManyToOne(optional = false)
    private Orders orderid;
    @JoinColumn(name = "PRODUCTID", referencedColumnName = "PRODUCTID")
    @ManyToOne(optional = false)
    private Product productid;

    public Placeorder() {
    }

    public Placeorder(String placeorderid) {
        this.placeorderid = placeorderid;
    }

    public Placeorder(String placeorderid, int quantity) {
        this.placeorderid = placeorderid;
        this.quantity = quantity;
    }

    public Placeorder(String placeorderid, Product productid, Orders orderid, int placeordernum, int quantity) {
        this.placeorderid = placeorderid;
        this.productid = productid;
        this.orderid = orderid;
        this.placeordernum = placeordernum;
        this.quantity = quantity;
    }

    public String getPlaceorderid() {
        return placeorderid;
    }

    public void setPlaceorderid(String placeorderid) {
        this.placeorderid = placeorderid;
    }

    public Orders getOrderid() {
        return orderid;
    }

    public void setOrderid(Orders orderid) {
        this.orderid = orderid;
    }

    public Product getProductid() {
        return productid;
    }

    public void setProductid(Product productid) {
        this.productid = productid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (placeorderid != null ? placeorderid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Placeorder)) {
            return false;
        }
        Placeorder other = (Placeorder) object;
        if ((this.placeorderid == null && other.placeorderid != null) || (this.placeorderid != null && !this.placeorderid.equals(other.placeorderid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Placeorder[ placeorderid=" + placeorderid + " ]";
    }

    public int getPlaceordernum() {
        return placeordernum;
    }

    public void setPlaceordernum(int placeordernum) {
        this.placeordernum = placeordernum;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

}
