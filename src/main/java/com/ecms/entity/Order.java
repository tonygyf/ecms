package com.ecms.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Data // 使用 Lombok 提供的 @Data 注解来自动生成 getters 和 setters
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderId;

    @Column(nullable = false)
    private Integer merchantId;

    @Column(nullable = false)
    private Integer customerId;

    @Column(nullable = false, unique = true)
    private String orderNumber;

    @Column(nullable = false)
    private Double totalAmount;

    // 使用字符串表示订单状态
    @Column(nullable = false)
    private String orderStatus; // "pending", "shipped", "completed", "refunded"

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    // Getters and Setters (可选，如果使用 @Data 注解则不需要手动定义)
}
