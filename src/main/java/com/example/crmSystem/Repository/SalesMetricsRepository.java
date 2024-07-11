package com.example.crmSystem.Repository;


import com.example.crmSystem.model.SalesMetrics;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalesMetricsRepository extends CrudRepository<SalesMetrics, Long> {

    @Query(value = "SELECT user_id, total_sales, monthly_sales, quarterly_sales FROM sales_metrics", nativeQuery = true)
    List<SalesMetrics> findAllSalesMetrics();

    @Query(value = "SELECT user_id, total_sales, monthly_sales, quarterly_sales FROM sales_metrics where user_id=?", nativeQuery = true)
    SalesMetrics findByUserId(Long userId);
}

