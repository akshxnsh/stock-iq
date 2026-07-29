package com.stockiq.trading.domain;

/**
 * Order lifecycle status
 * Maps to Postgres ENUM order_status
 */
public enum OrderStatus {
    NEW,
    PARTIALLY_FILLED,
    FILLED,
    CANCELLED,
    REJECTED
}
