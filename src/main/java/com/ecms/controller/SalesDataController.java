package com.ecms.controller;

import com.ecms.dto.ProductSalesDTO;
import com.ecms.entity.SalesData;
import com.ecms.service.SalesDataService;
import org.springframework.web.bind.annotation.*;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sales")
@CrossOrigin(origins = "http://localhost:8081") // 允许来自 http://localhost:8081 的请求
public class SalesDataController {

    @Autowired
    private SalesDataService salesDataService;

    @GetMapping("/{merchantId}")
    public List<SalesData> getSalesDataByMerchant(@PathVariable Integer merchantId) {
        return salesDataService.getSalesDataByMerchant(merchantId);
    }

    @PostMapping
    public SalesData createSalesData(@RequestBody SalesData salesData) {
        return salesDataService.createSalesData(salesData);
    }
}
