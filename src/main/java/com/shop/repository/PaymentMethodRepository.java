package com.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.model.PaymentMethod;

public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Long> {

}
