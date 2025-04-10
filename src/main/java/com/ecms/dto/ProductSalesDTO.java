package com.ecms.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
@AllArgsConstructor
public class ProductSalesDTO {
    private Date salesDate;       // 销售日期
    private BigDecimal totalSalesAmount; // 总销售额
    private Integer orderCount;   // 订单数量
    private BigDecimal averageOrderValue; // 平均订单价值

    // 处理除零异常的构造函数
    public ProductSalesDTO(Date salesDate, BigDecimal totalSalesAmount, Integer orderCount) {
        this.salesDate = salesDate;
        this.totalSalesAmount = totalSalesAmount;
        this.orderCount = orderCount;
        this.averageOrderValue = orderCount == 0 ? BigDecimal.ZERO
                : totalSalesAmount.divide(new BigDecimal(orderCount), 2, BigDecimal.ROUND_HALF_UP);
    }
}
