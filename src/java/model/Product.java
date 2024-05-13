/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Lee
 */
@Entity
@Table(name = "PRODUCT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
    @NamedQuery(name = "Product.findByProductid", query = "SELECT p FROM Product p WHERE p.productid = :productid"),
    @NamedQuery(name = "Product.findByProductname", query = "SELECT p FROM Product p WHERE p.productname = :productname"),
    @NamedQuery(name = "Product.findByPrice", query = "SELECT p FROM Product p WHERE p.price = :price"),
    @NamedQuery(name = "Product.findByStockqty", query = "SELECT p FROM Product p WHERE p.stockqty = :stockqty"),
    @NamedQuery(name = "Product.findByImagepath", query = "SELECT p FROM Product p WHERE p.imagepath = :imagepath"),
    @NamedQuery(name = "Product.findByProductinfo", query = "SELECT p FROM Product p WHERE p.productinfo = :productinfo"),
    @NamedQuery(name = "Product.findByLastcreate", query = "SELECT p FROM Product p WHERE p.lastcreate = :lastcreate"),
    @NamedQuery(name = "Product.findByLastmodify", query = "SELECT p FROM Product p WHERE p.lastmodify = :lastmodify")})
public class Product implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "PRODUCTNAME")
    private String productname;
   
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull()
    @Column(name = "PRICE")
    private BigDecimal price;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STOCKQTY")
    private int stockqty;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "IMAGEPATH")
    private String imagepath;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2000)
    @Column(name = "PRODUCTINFO")
    private String productinfo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "LASTCREATE")
    @Temporal(TemporalType.DATE)
    private Date lastcreate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "LASTMODIFY")
    @Temporal(TemporalType.DATE)
    private Date lastmodify;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productid")
    private List<Discount> discountList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productid")
    private List<Placeorder> placeorderList;
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 4)
    @Column(name = "PRODUCTID")
    private String productid;
    @JoinColumn(name = "CATEGORYID", referencedColumnName = "CATEGORYID")
    @ManyToOne(optional = false)
    private Category categoryid;
    @JoinColumn(name = "STAFFID", referencedColumnName = "STAFFID")
    @ManyToOne(optional = false)
    private Staff staffid;

    public Product() {
    }

    public Product(String productid) {
        this.productid = productid;
    }
    
    public Product(String productid, Category categoryid, Staff staffid, String productname, BigDecimal price, int stockqty, String productinfo, Date lastcreate, Date lastmodify) {
        this.productid = productid;
        this.categoryid = categoryid;
        this.staffid = staffid;
        this.productname = productname;
        this.price = price;
        this.stockqty = stockqty;
        
        this.productinfo = productinfo;
        this.lastcreate = lastcreate;
        this.lastmodify = lastmodify;
    }

    public Product(String productid, Category categoryid, Staff staffid, String productname, BigDecimal price, int stockqty, String imagepath,  String productinfo, Date lastcreate, Date lastmodify) {
        this.productid = productid;
        this.categoryid = categoryid;
        this.staffid = staffid;
        this.productname = productname;
        this.price = price;
        this.stockqty = stockqty;
        this.imagepath = imagepath;
        this.productinfo = productinfo;
        this.lastcreate = lastcreate;
        this.lastmodify = lastmodify;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }

    public Category getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(Category categoryid) {
        this.categoryid = categoryid;
    }

    public Staff getStaffid() {
        return staffid;
    }

    public void setStaffid(Staff staffid) {
        this.staffid = staffid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productid != null ? productid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.productid == null && other.productid != null) || (this.productid != null && !this.productid.equals(other.productid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Product[ productid=" + productid + " ]";
    }

    @XmlTransient
    public List<Placeorder> getPlaceorderList() {
        return placeorderList;
    }

    public void setPlaceorderList(List<Placeorder> placeorderList) {
        this.placeorderList = placeorderList;
    }

    @XmlTransient
    public List<Discount> getDiscountList() {
        return discountList;
    }

    public void setDiscountList(List<Discount> discountList) {
        this.discountList = discountList;
    }
    public String generateUniqueFileName(String originalFileName) {
        //Get Current timestamp
        long timestamp = System.currentTimeMillis();
        
        //Format Timestamp as a String
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String timestampStr = dateFormat.format(new Date(timestamp));
        
        //Generate a random UUID to ensure uniqueness
        String uuid = UUID.randomUUID().toString();
        
        //Extract the file Extension from the original filename
        String fileExtension = "";
        int doIndex = originalFileName.lastIndexOf('.');
        if(doIndex > 0 && doIndex < originalFileName.length() - 1){
            fileExtension = originalFileName.substring(doIndex + 1);
        }
        
        //Concatenate timestamp, UUID, and file extension to form a unique file name
        String uniqueFileName = "file_" + timestampStr + "_" + uuid + "." + fileExtension;
        
        return uniqueFileName;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStockqty() {
        return stockqty;
    }

    public void setStockqty(int stockqty) {
        this.stockqty = stockqty;
    }

    public String getImagepath() {
        return imagepath;
    }

    public void setImagepath(String imagepath) {
        this.imagepath = imagepath;
    }

    public String getProductinfo() {
        return productinfo;
    }

    public void setProductinfo(String productinfo) {
        this.productinfo = productinfo;
    }

    public Date getLastcreate() {
        return lastcreate;
    }

    public void setLastcreate(Date lastcreate) {
        this.lastcreate = lastcreate;
    }

    public Date getLastmodify() {
        return lastmodify;
    }

    public void setLastmodify(Date lastmodify) {
        this.lastmodify = lastmodify;
    }



}
