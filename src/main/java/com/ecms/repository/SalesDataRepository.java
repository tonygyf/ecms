package com.ecms.repository;

import com.ecms.entity.SalesData;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SalesDataRepository extends JpaRepository<SalesData, Integer> {
    List<SalesData> findByMerchantId(Integer merchantId);
}
