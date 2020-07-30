package com.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.model.ShoppingCart;

public interface ShoppingCartRepository extends JpaRepository<ShoppingCart, Long> {

	@Query("FROM ShoppingCart WHERE cartsnId =?1")
	List<ShoppingCart> getCart(String session);
	
	@Query("FROM ShoppingCart WHERE refid =?1 AND cartId=?2")
	List<ShoppingCart> findUnique(Long refID, Long long1);
	
}
