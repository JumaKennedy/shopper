package com.shop.model;

import java.util.List;
import java.util.Set;

import javax.persistence.*;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name="users")
public class Users {
	
	public Users(Long id, String lname, String email, String fname, String comment) {
		super();
		this.id = id;
		this.lname = lname;
		this.email = email;
		this.fname = fname;
		this.comment = comment;
	}
		
	public Users() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	@Column(name="lname")	
	private String lname;
	private String fname;
	
    @Column(name = "password")
    private String password;
    private String email;
    
    private int active;
    
    private String resetToken;
    
    @ManyToMany(cascade = CascadeType.DETACH )
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"),
    inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;
    
    @Transient
	private String password2;
	
	private String image;
	private String comment;
	
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private Addressess address;
	
	@OneToMany(mappedBy="users_id", cascade=CascadeType.ALL)
	private List<Products> products;
		
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<PaymentMethod> paymentMethod;
	
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private Set<PhoneBook> PhoneBook;
	
	@Transient
	private MultipartFile file;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
		
	
	
	public Addressess getAddress() {
		return address;
	}

	public void setAddress(Addressess address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	
	
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	public List<Products> getProducts() {
		return products;
	}

	public void setProducts(List<Products> products) {
		this.products = products;
	}

	
	public List<PaymentMethod> getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(List<PaymentMethod> paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public Set<PhoneBook> getPhoneBook() {
		return PhoneBook;
	}

	public void setPhoneBook(Set<PhoneBook> phoneBook) {
		PhoneBook = phoneBook;
	}	

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getResetToken() {
		return resetToken;
	}

	public void setResetToken(String resetToken) {
		this.resetToken = resetToken;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Users other = (Users) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Users [id=" + id + ", lname=" + lname + ", fname=" + fname + ", password=" + password
				+ " active=" + active + ", resetToken=" + resetToken
				+ ", roles=" + roles + ", email=" + email + ", password2=" + password2 + ", image="
				+ image + ", comment=" + comment + ", address=" + address + ", products=" + products
				+ ", paymentMethod=" + paymentMethod + ", PhoneBook=" + PhoneBook + ", file=" + file + "]";
	}

	
}
