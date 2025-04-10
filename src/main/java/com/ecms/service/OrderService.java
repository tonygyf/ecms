package com.ecms.service;

import com.ecms.entity.Order;
import com.ecms.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order createOrder(Order order) {
        return orderRepository.save(order);
    }

    public List<Order> getOrdersByMerchant(Integer merchantId) {
        return orderRepository.findByMerchantId(merchantId);
    }

    public Order updateOrder(Integer id, Order order) {
        order.setOrderId(id);
        return orderRepository.save(order);
    }

    public void deleteOrder(Integer id) {
        orderRepository.deleteById(id);
    }

    public List<Order> searchOrders(String keyword) {
        return orderRepository.findAll((root, query, criteriaBuilder) -> {
            if (keyword == null || keyword.isEmpty()) {
                return criteriaBuilder.conjunction(); // 如果没有关键词，返回所有记录
            }
            return criteriaBuilder.or(
                    criteriaBuilder.like(root.get("orderNumber"), "%" + keyword + "%")
            );
        });
    }
}
