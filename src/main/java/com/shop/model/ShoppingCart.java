package com.shop.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name="cart")
@Entity
public class ShoppingCart {
	
	 @Id
	    @GeneratedValue(strategy=GenerationType.AUTO)
	    private Long id;
	    
	    @Transient
	    private Long prod_id;	    
	    @Transient
	    private Long o_id;	 
	    
	    @ManyToOne(fetch=FetchType.LAZY, cascade = CascadeType.DETACH )
		@JoinColumn(name="customerorders_id")
		private CustomerOrders customerOrders;
	    
	    private Date cart_date =new Date();
		
		@ManyToOne(fetch=FetchType.LAZY, optional=false, cascade = CascadeType.DETACH)
	    @JoinColumn(name="products_id", nullable=false) 
		private Products product;		 
	    
	    @Column(name = "size", nullable = true)
	    private String size;
	    
	    @Column(name = "color", nullable = true)
	    private String color;
	 
	    @Column(name = "Quantity", nullable = false)
	    private int qty;
	 
	    @Column(name = "Price", nullable = false)
	    private double price;
	 
	    @Column(name = "Amount", nullable = false)
	    private double amount;

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public Long getProd_id() {
			return prod_id;
		}

		public void setProd_id(Long prod_id) {
			this.prod_id = prod_id;
		}

		public Long getO_id() {
			return o_id;
		}

		public void setO_id(Long o_id) {
			this.o_id = o_id;
		}

		
		public CustomerOrders getCustomerOrders() {
			return customerOrders;
		}

		public void setCustomerOrders(CustomerOrders customerOrders) {
			this.customerOrders = customerOrders;
		}

		public Date getCart_date() {
			return cart_date;
		}

		public void setCart_date(Date cart_date) {
			this.cart_date = cart_date;
		}

		public Products getProduct() {
			return product;
		}

		public void setProduct(Products product) {
			this.product = product;
		}

		public String getSize() {
			return size;
		}

		public void setSize(String size) {
			this.size = size;
		}

		public String getColor() {
			return color;
		}

		public void setColor(String color) {
			this.color = color;
		}

		public int getQty() {
			return qty;
		}

		public void setQty(int qty) {
			this.qty = qty;
		}

		public double getPrice() {
			return price;
		}

		public void setPrice(double price) {
			this.price = price;
		}

		public double getAmount() {
			return amount;
		}

		public void setAmount(double amount) {
			this.amount = amount;
		}

		@Override
		public String toString() {
			return "ShoppingCart [id=" + id + ", prod_id=" + prod_id + ", o_id=" + o_id + ", cart=" + customerOrders
					+ ", cart_date=" + cart_date + ", product=" + product + ", size=" + size + ", color=" + color
					+ ", qty=" + qty + ", price=" + price + ", amount=" + amount + "]";
		}

		

		
	    
	}