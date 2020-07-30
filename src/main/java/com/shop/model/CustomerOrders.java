package com.shop.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="customerorders")
public class CustomerOrders {
	
	public CustomerOrders() {
		super();
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private int qty;
	private double amount;
	private String full_name;
	private String street;
	private String city;
	private String state;
	private String zip;
	private String email;
	private String phone;
	private String status;
	@Column(name="created_on")
	private Date createdon =new Date();
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.REMOVE )
    @JoinColumn(name = "customerorders_id")
    private List<ShoppingCart> cart = new ArrayList<>();
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getCreatedon() {
		return createdon;
	}
	public void setCreatedon(Date createdon) {
		this.createdon = createdon;
	}
	
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public List<ShoppingCart> getCart() {
		return cart;
	}
	public void setCart(List<ShoppingCart> cart) {
		this.cart = cart;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "CustomerOrders [id=" + id + ", qty=" + qty + ", amount=" + amount + ", full_name=" + full_name
				+ ", street=" + street + ", city=" + city + ", state=" + state + ", zip=" + zip + ", email=" + email
				+ ", phone=" + phone + ", status=" + status + ", createdon=" + createdon + ", cart=" + cart + "]";
	}
	
	
}
