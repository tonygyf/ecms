/*
 Navicat Premium Data Transfer

 Source Server         : asd
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : ecms

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 02/04/2025 19:12:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `customer_id` int NOT NULL AUTO_INCREMENT COMMENT '顾客ID',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `registration_date` date NULL DEFAULT (curdate()) COMMENT '注册日期',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  INDEX `idx_phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES (4, '13800138000', 'customer1@example.com', '2024-01-05', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `customers` VALUES (5, '13912345678', 'customer2@test.com', '2024-02-18', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `customers` VALUES (6, '13698765432', NULL, '2024-03-22', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `customers` VALUES (7, '13800138001', 'customer3@example.com', '2024-01-10', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `customers` VALUES (8, '13912345679', 'customer4@example.com', '2024-02-20', '2025-04-02 17:47:31', '2025-04-02 17:47:31');

-- ----------------------------
-- Table structure for marketing_suggestions
-- ----------------------------
DROP TABLE IF EXISTS `marketing_suggestions`;
CREATE TABLE `marketing_suggestions`  (
  `suggestion_id` int NOT NULL AUTO_INCREMENT,
  `merchant_id` int NOT NULL,
  `suggestion_type` enum('promotion','pricing','advertising') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`suggestion_id`) USING BTREE,
  INDEX `merchant_id`(`merchant_id` ASC) USING BTREE,
  CONSTRAINT `marketing_suggestions_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of marketing_suggestions
-- ----------------------------

-- ----------------------------
-- Table structure for merchant_applications
-- ----------------------------
DROP TABLE IF EXISTS `merchant_applications`;
CREATE TABLE `merchant_applications`  (
  `application_id` int NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `merchant_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商家名称',
  `contact_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '联系方式',
  `business_scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '经营范围',
  `application_date` date NULL DEFAULT (curdate()) COMMENT '申请日期',
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending' COMMENT '审核状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchant_applications
-- ----------------------------
INSERT INTO `merchant_applications` VALUES (4, '电子商城', 'contact@electronicstore.com', '电子产品', '2025-04-02', 'approved', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchant_applications` VALUES (5, '时尚店铺', 'fashion@fashionstore.com', '服装鞋帽', '2025-04-02', 'pending', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchant_applications` VALUES (6, '健康食品商店', 'info@healthstore.com', '食品饮料', '2025-04-02', 'rejected', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchant_applications` VALUES (7, '家居用品专卖店', 'home@homestore.com', '家居用品', '2025-04-02', 'approved', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchant_applications` VALUES (8, '运动器材旗舰店', 'sports@sportsstore.com', '运动器材', '2025-04-02', 'pending', '2025-04-02 17:47:31', '2025-04-02 17:47:31');

-- ----------------------------
-- Table structure for merchants
-- ----------------------------
DROP TABLE IF EXISTS `merchants`;
CREATE TABLE `merchants`  (
  `merchant_id` int NOT NULL AUTO_INCREMENT COMMENT '商家ID',
  `application_id` int NOT NULL COMMENT '入驻申请ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资质文件路径',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`merchant_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  UNIQUE INDEX `application_id`(`application_id` ASC) USING BTREE,
  CONSTRAINT `merchants_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `merchant_applications` (`application_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `merchants_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchants
-- ----------------------------
INSERT INTO `merchants` VALUES (3, 1, 3, '/licenses/electronic_license.pdf', 'active', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchants` VALUES (4, 2, 4, '/licenses/fashion_license.pdf', 'inactive', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `merchants` VALUES (5, 3, 5, '/licenses/health_license.pdf', 'active', '2025-04-02 17:47:31', '2025-04-02 17:47:31');

-- ----------------------------
-- Table structure for operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs`  (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_type` enum('platform','merchant') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_action_time`(`action` ASC, `created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operation_logs
-- ----------------------------
INSERT INTO `operation_logs` VALUES (1, 'merchant', 1, '商品上架', '上架新品：男士休闲衬衫', '2025-04-02 12:32:45');
INSERT INTO `operation_logs` VALUES (2, 'platform', 1, '审核通过', '批准商家入驻申请：时尚服饰旗舰店', '2025-04-02 12:32:45');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `item_id` int NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` int NOT NULL COMMENT '订单ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `quantity` int NOT NULL COMMENT '购买数量',
  `unit_price` double NOT NULL,
  PRIMARY KEY (`item_id`) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_order_product`(`order_id` ASC, `product_id` ASC) USING BTREE,
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, 1, 1, 1, 299);
INSERT INTO `order_items` VALUES (2, 1, 2, 1, 599);
INSERT INTO `order_items` VALUES (3, 3, 3, 2, 45.9);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `merchant_id` int NOT NULL COMMENT '商家ID',
  `customer_id` int NOT NULL COMMENT '顾客ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total_amount` double NOT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `order_number`(`order_number` ASC) USING BTREE,
  INDEX `idx_merchant_order`(`merchant_id` ASC, `order_status` ASC) USING BTREE,
  INDEX `idx_customer`(`customer_id` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 3, 4, 'DD20240115001', 902, 'completed', '2025-04-02 12:32:45', '2025-04-02 11:02:35');
INSERT INTO `orders` VALUES (3, 5, 6, 'DD20240325003', 91.8, 'pending', '2025-04-02 12:32:45', '2025-04-02 18:09:03');
INSERT INTO `orders` VALUES (4, 3, 4, '534', 0, 'completed', '2025-04-02 10:10:32', '2025-04-02 10:10:36');
INSERT INTO `orders` VALUES (12, 3, 4, 'sad', 1, 'pending', '2025-04-02 11:02:17', '2025-04-02 11:02:17');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `product_id` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `merchant_id` int NOT NULL COMMENT '商家ID',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` double NOT NULL,
  `stock_quantity` int NOT NULL DEFAULT 0 COMMENT '库存数量',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `idx_merchant`(`merchant_id` ASC) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, '男士休闲衬衫1', '纯棉商务休闲衬衫', 301, 101, 'active', NULL, NULL);
INSERT INTO `products` VALUES (2, 1, '女士针织连衣裙', '春季新款修身连衣裙', 599, 50, 'active', '2025-04-02 12:32:44', '2025-04-02 12:32:44');
INSERT INTO `products` VALUES (3, 2, '有机燕麦片', '无添加健康食品', 45.9, 200, 'inactive', NULL, NULL);

-- ----------------------------
-- Table structure for sales_data
-- ----------------------------
DROP TABLE IF EXISTS `sales_data`;
CREATE TABLE `sales_data`  (
  `sales_id` int NOT NULL AUTO_INCREMENT COMMENT '销售数据ID',
  `merchant_id` int NOT NULL COMMENT '商家ID',
  `sales_date` date NOT NULL COMMENT '统计日期',
  `total_sales` decimal(14, 2) NOT NULL COMMENT '总销售额',
  `total_orders` int NOT NULL COMMENT '总订单数',
  `avg_order_value` decimal(10, 2) NOT NULL COMMENT '客单价',
  `region_sales` json NULL COMMENT '区域销量分布',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_id`) USING BTREE,
  UNIQUE INDEX `idx_merchant_date`(`merchant_id` ASC, `sales_date` ASC) USING BTREE,
  CONSTRAINT `sales_data_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sales_data
-- ----------------------------
INSERT INTO `sales_data` VALUES (1, 1, '2024-01-31', 15000.00, 50, 300.00, '{\"华东\": 7000, \"华北\": 6500, \"华南\": 1500}', '2025-04-02 12:32:45');
INSERT INTO `sales_data` VALUES (2, 1, '2024-02-28', 22000.00, 80, 275.00, '{\"华东\": 12000, \"华北\": 9000, \"华南\": 1000}', '2025-04-02 12:32:45');

-- ----------------------------
-- Table structure for sales_forecasts
-- ----------------------------
DROP TABLE IF EXISTS `sales_forecasts`;
CREATE TABLE `sales_forecasts`  (
  `forecast_id` int NOT NULL AUTO_INCREMENT COMMENT '预测ID',
  `merchant_id` int NOT NULL COMMENT '商家ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `forecast_date` date NOT NULL COMMENT '预测日期',
  `predicted_sales` decimal(12, 2) NOT NULL COMMENT '预测销量',
  `confidence_interval` json NULL COMMENT '置信区间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`forecast_id`) USING BTREE,
  INDEX `merchant_id`(`merchant_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_forecast_date`(`forecast_date` ASC) USING BTREE,
  CONSTRAINT `sales_forecasts_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sales_forecasts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sales_forecasts
-- ----------------------------
INSERT INTO `sales_forecasts` VALUES (1, 1, 1, '2024-04-01', 120.00, '{\"lower\": 90, \"upper\": 150}', '2025-04-02 12:32:45');
INSERT INTO `sales_forecasts` VALUES (2, 1, 2, '2024-04-01', 65.00, '{\"lower\": 50, \"upper\": 80}', '2025-04-02 12:32:45');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin1', 'password123', 'admin', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `users` VALUES (2, 'admin2', 'password123', 'admin', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `users` VALUES (3, 'merchant1', 'merchantpass', 'merchant', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `users` VALUES (4, 'merchant2', 'merchantpass', 'merchant', '2025-04-02 17:47:31', '2025-04-02 17:47:31');
INSERT INTO `users` VALUES (5, 'merchant3', 'merchantpass', 'merchant', '2025-04-02 17:47:31', '2025-04-02 17:47:31');

-- ----------------------------
-- Table structure for visualization_data
-- ----------------------------
DROP TABLE IF EXISTS `visualization_data`;
CREATE TABLE `visualization_data`  (
  `data_id` int NOT NULL AUTO_INCREMENT COMMENT '数据ID',
  `merchant_id` int NOT NULL COMMENT '商家ID',
  `chart_type` enum('line','bar','pie','heatmap') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `data_config` json NOT NULL COMMENT '图表配置',
  `data_snapshot` json NOT NULL COMMENT '数据快照',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`data_id`) USING BTREE,
  INDEX `idx_merchant_chart`(`merchant_id` ASC, `chart_type` ASC) USING BTREE,
  CONSTRAINT `visualization_data_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`merchant_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visualization_data
-- ----------------------------
INSERT INTO `visualization_data` VALUES (1, 1, 'line', '{\"title\": \"月度销售趋势\", \"xAxis\": \"月份\", \"yAxis\": \"销售额\"}', '{\"2024-01\": 15000, \"2024-02\": 22000}', '2025-04-02 12:32:45');
INSERT INTO `visualization_data` VALUES (2, 1, 'pie', '{\"title\": \"区域销售分布\", \"radius\": \"60%\"}', '{\"华东\": 55, \"华北\": 35, \"华南\": 10}', '2025-04-02 12:32:45');

SET FOREIGN_KEY_CHECKS = 1;
