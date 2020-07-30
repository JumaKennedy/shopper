package com.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.model.CustomerOrders;

public interface CustomerOrdersRepository extends JpaRepository<CustomerOrders, Long> {
	
	@Query("FROM CustomerOrders WHERE email=?1")
	List<CustomerOrders> myOrders(String email);

}
