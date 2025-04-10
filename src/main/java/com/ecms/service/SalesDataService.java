package com.ecms.service;

import com.ecms.dto.ProductSalesDTO;
import com.ecms.entity.SalesData;
import com.ecms.repository.SalesDataRepository;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesDataService {

    @Autowired
    private SalesDataRepository salesDataRepository;

    public List<SalesData> getSalesDataByMerchant(Integer merchantId) {
        return salesDataRepository.findByMerchantId(merchantId);
    }

    public SalesData createSalesData(SalesData salesData) {
        return salesDataRepository.save(salesData);
    }
}
