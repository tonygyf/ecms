package com.ecms.controller;

import com.ecms.entity.Order;
import com.ecms.service.OrderService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@CrossOrigin(origins = "http://localhost:8081") // 允许来自 http://localhost:8081 的请求
@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public List<Order> getAllOrders() {
        return orderService.getAllOrders();
    }

    @PostMapping
    public Order createOrder(@RequestBody Order order) {
        return orderService.createOrder(order);
    }

    @GetMapping("/{merchantId}")
    public List<Order> getOrdersByMerchant(@PathVariable Integer merchantId) {
        return orderService.getOrdersByMerchant(merchantId);
    }

    @PutMapping("/{id}")
    public Order updateOrder(@PathVariable Integer id, @RequestBody Order order) {
        return orderService.updateOrder(id, order);
    }

    @DeleteMapping("/{id}")
    public void deleteOrder(@PathVariable Integer id) {
        orderService.deleteOrder(id);
    }

    // 新增模糊查询方法
    @GetMapping("/search")
    public List<Order> searchOrders(@RequestParam String keyword) {
        return orderService.searchOrders(keyword);
    }
}
