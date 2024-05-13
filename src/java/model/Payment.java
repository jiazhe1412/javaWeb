/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
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
@Table(name = "PAYMENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Payment.findAll", query = "SELECT p FROM Payment p"),
    @NamedQuery(name = "Payment.findByPaymentid", query = "SELECT p FROM Payment p WHERE p.paymentid = :paymentid"),
    @NamedQuery(name = "Payment.findByPaymentdate", query = "SELECT p FROM Payment p WHERE p.paymentdate = :paymentdate"),
    @NamedQuery(name = "Payment.findByPaymentmethod", query = "SELECT p FROM Payment p WHERE p.paymentmethod = :paymentmethod"),
    @NamedQuery(name = "Payment.findByWallettype", query = "SELECT p FROM Payment p WHERE p.wallettype = :wallettype"),
    @NamedQuery(name = "Payment.findByCardtype", query = "SELECT p FROM Payment p WHERE p.cardtype = :cardtype"),
    @NamedQuery(name = "Payment.findByCardname", query = "SELECT p FROM Payment p WHERE p.cardname = :cardname"),
    @NamedQuery(name = "Payment.findByCardnum", query = "SELECT p FROM Payment p WHERE p.cardnum = :cardnum"),
    @NamedQuery(name = "Payment.findByCardexpdate", query = "SELECT p FROM Payment p WHERE p.cardexpdate = :cardexpdate"),
    @NamedQuery(name = "Payment.findByCardcvv", query = "SELECT p FROM Payment p WHERE p.cardcvv = :cardcvv"),
    @NamedQuery(name = "Payment.findByTotalamount", query = "SELECT p FROM Payment p WHERE p.totalamount = :totalamount"),
    @NamedQuery(name = "Payment.findByShipaddress", query = "SELECT p FROM Payment p WHERE p.shipaddress = :shipaddress"),
    @NamedQuery(name = "Payment.findByPaymentstatus", query = "SELECT p FROM Payment p WHERE p.paymentstatus = :paymentstatus"),
    @NamedQuery(name = "Payment.findByEmail", query = "SELECT p FROM Payment p WHERE p.email = :email")})

public class Payment implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "PAYMENTDATE")
    @Temporal(TemporalType.DATE)
    private Date paymentdate;
    @Size(max = 10)
    @Column(name = "PAYMENTMETHOD")
    private String paymentmethod;
    @Size(max = 10)
    @Column(name = "WALLETTYPE")
    private String wallettype;
    @Size(max = 10)
    @Column(name = "CARDTYPE")
    private String cardtype;
    @Size(max = 100)
    @Column(name = "CARDNAME")
    private String cardname;
    @Size(max = 16)
    @Column(name = "CARDNUM")
    private String cardnum;
    @Size(max = 5)
    @Column(name = "CARDEXPDATE")
    private String cardexpdate;
    @Basic(optional = false)
    @NotNull()
    @Size(min = 1, max = 255)
    @Column(name = "SHIPADDRESS")
    private String shipaddress;
    @Size(max = 8)
    @Column(name = "PAYMENTSTATUS")
    private String paymentstatus;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "EMAIL")
    private String email;
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 4)
    @Column(name = "PAYMENTID")
    private String paymentid;
    @Column(name = "CARDCVV")
    private Integer cardcvv;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "TOTALAMOUNT")
    private BigDecimal totalamount;
    @JoinColumn(name = "ORDERID", referencedColumnName = "ORDERID")
    @ManyToOne(optional = false)
    private Orders orderid;

    public Payment() {
    }

    public Payment(String paymentid) {
        this.paymentid = paymentid;
    }

    public Payment(String paymentid, Date paymentdate, String paymentmethod, BigDecimal totalamount, String paymentstatus) {
        this.paymentid = paymentid;
        this.paymentdate = paymentdate;
        this.paymentmethod = paymentmethod;
        this.totalamount = totalamount;
        this.paymentstatus = paymentstatus;
    }
    
    public Payment(Orders orderid, Date paymentdate, String paymentmethod, String wallettype, String cardtype, String cardname, String cardnum, String cardexpdate, int cardcvv, BigDecimal totalamount, String shipaddress, String paymentstatus, String email) {
        this.orderid = orderid;
        this.paymentdate = paymentdate;
        this.paymentmethod = paymentmethod;
        this.wallettype = wallettype;
        this.cardtype = cardtype;
        this.cardname = cardname;
        this.cardnum = cardnum;
        this.cardexpdate = cardexpdate;
        this.cardcvv = cardcvv;
        this.totalamount = totalamount;
        this.shipaddress = shipaddress;
        this.paymentstatus = paymentstatus;
        this.email = email;
    }

    public String getPaymentid() {
        return paymentid;
    }

    public void setPaymentid(String paymentid) {
        this.paymentid = paymentid;
    }


    public Integer getCardcvv() {
        return cardcvv;
    }

    public void setCardcvv(Integer cardcvv) {
        this.cardcvv = cardcvv;
    }

    public BigDecimal getTotalamount() {
        return totalamount;
    }

    public void setTotalamount(BigDecimal totalamount) {
        this.totalamount = totalamount;
    }


    public Orders getOrderid() {
        return orderid;
    }

    public void setOrderid(Orders orderid) {
        this.orderid = orderid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (paymentid != null ? paymentid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Payment)) {
            return false;
        }
        Payment other = (Payment) object;
        if ((this.paymentid == null && other.paymentid != null) || (this.paymentid != null && !this.paymentid.equals(other.paymentid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Payment[ paymentid=" + paymentid + " ]";
    }

    public Date getPaymentdate() {
        return paymentdate;
    }

    public void setPaymentdate(Date paymentdate) {
        this.paymentdate = paymentdate;
    }

    public String getPaymentmethod() {
        return paymentmethod;
    }

    public void setPaymentmethod(String paymentmethod) {
        this.paymentmethod = paymentmethod;
    }

    public String getWallettype() {
        return wallettype;
    }

    public void setWallettype(String wallettype) {
        this.wallettype = wallettype;
    }

    public String getCardtype() {
        return cardtype;
    }

    public void setCardtype(String cardtype) {
        this.cardtype = cardtype;
    }

    public String getCardname() {
        return cardname;
    }

    public void setCardname(String cardname) {
        this.cardname = cardname;
    }

    public String getCardnum() {
        return cardnum;
    }

    public void setCardnum(String cardnum) {
        this.cardnum = cardnum;
    }

    public String getCardexpdate() {
        return cardexpdate;
    }

    public void setCardexpdate(String cardexpdate) {
        this.cardexpdate = cardexpdate;
    }

    public String getShipaddress() {
        return shipaddress;
    }

    public void setShipaddress(String shipaddress) {
        this.shipaddress = shipaddress;
    }

    public String getPaymentstatus() {
        return paymentstatus;
    }

    public void setPaymentstatus(String paymentstatus) {
        this.paymentstatus = paymentstatus;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
