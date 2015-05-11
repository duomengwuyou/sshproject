package com.neusoft.logistics.bean;

import java.util.Date;

/**
 * 用于配送中心生产购货单时，获取缺货信息
 * ShortProductTotal
 * @author 龚玉斌
 *
 */
public class ShortProductTotal {
private int productId;
private int shortQuantityTotal;
private int remainQuantity;
private int warningQuantity;
private int maxQuantity;
private Date date;
private Product product;
public int getProductId() {
	return productId;
}
public void setProductId(int productId) {
	this.productId = productId;
}
public int getShortQuantityTotal() {
	return shortQuantityTotal;
}
public void setShortQuantityTotal(int shortQuantityTotal) {
	this.shortQuantityTotal = shortQuantityTotal;
}
public int getRemainQuantity() {
	return remainQuantity;
}
public void setRemainQuantity(int remainQuantity) {
	this.remainQuantity = remainQuantity;
}
public int getWarningQuantity() {
	return warningQuantity;
}
public void setWarningQuantity(int warningQuantity) {
	this.warningQuantity = warningQuantity;
}
public int getMaxQuantity() {
	return maxQuantity;
}
public void setMaxQuantity(int maxQuantity) {
	this.maxQuantity = maxQuantity;
}
public Product getProduct() {
	return product;
}
public void setProduct(Product product) {
	this.product = product;
}
public Date getDate() {
	return date;
}
public void setDate(Date date) {
	this.date = date;
}


}
