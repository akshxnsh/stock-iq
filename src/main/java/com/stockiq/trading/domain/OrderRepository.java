package com.stockiq.trading.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repository for Order entity
 * Spring Data JPA provides implementation automatically
 */
@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {

    /**
     * Find all orders for a given user, sorted by creation date (newest first)
     *
     * Query is derived from method name:
     * - findBy -> SELECT * FROM orders WHERE
     * - UserId -> user_id = ?
     * - OrderBy -> ORDER BY
     * - CreatedAt -> created_at
     * - Desc -> DESC
     *
     * Equivalent SQL:
     * SELECT * FROM orders
     * WHERE user_id = ?
     * ORDER BY created_at DESC
     *
     * @param userId The user's UUID
     * @return List of orders for that user, newest first
     */
    List<Order> findByUserIdOrderByCreatedAtDesc(UUID userId);

    /**
     * Find orders by symbol
     * Useful for market data aggregation
     *
     * @param symbol Trading symbol (e.g., "AAPL")
     * @return List of all orders for that symbol
     */
    List<Order> findBySymbol(String symbol);

    /**
     * Find orders by user and status
     * Useful for showing "open orders" (status = NEW or PARTIALLY_FILLED)
     *
     * @param userId User's UUID
     * @param status Order status
     * @return List of matching orders
     */
    List<Order> findByUserIdAndStatus(UUID userId, OrderStatus status);
}
