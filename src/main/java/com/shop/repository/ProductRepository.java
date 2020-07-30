package com.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.model.Products;

public interface ProductRepository extends JpaRepository<Products, Long> {

}
