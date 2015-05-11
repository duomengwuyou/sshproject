package com.neusoft.logistics.bean;
// default package

import java.util.HashSet;
import java.util.Set;


/**
 * Category generated by MyEclipse Persistence Tools
 */

public class Category  implements java.io.Serializable {


    // Fields    

     private int categoryid;
     private Category LCategory;
     private String categoryname;
     private Set LCategories = new HashSet(0);
     private Set LProducts = new HashSet(0);


    // Constructors

    /** default constructor */
    public Category() {
    }

    
    /** full constructor */
    public Category(Category LCategory, String categoryname, Set LCategories, Set LProducts) {
        this.LCategory = LCategory;
        this.categoryname = categoryname;
        this.LCategories = LCategories;
        this.LProducts = LProducts;
    }

   
    // Property accessors

    public int getCategoryid() {
        return this.categoryid;
    }
    
    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public Category getLCategory() {
        return this.LCategory;
    }
    
    public void setLCategory(Category LCategory) {
        this.LCategory = LCategory;
    }

    public String getCategoryname() {
        return this.categoryname;
    }
    
    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public Set getLCategories() {
        return this.LCategories;
    }
    
    public void setLCategories(Set LCategories) {
        this.LCategories = LCategories;
    }

    public Set getLProducts() {
        return this.LProducts;
    }
    
    public void setLProducts(Set LProducts) {
        this.LProducts = LProducts;
    }
   








}