-- V1: Initialize Trading Service Schema
-- Creates users table, order enums, and orders table

-- =========================================
-- 1. USERS TABLE
-- =========================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- =========================================
-- 2. ORDER ENUMS
-- =========================================

-- Side: Buy or Sell
CREATE TYPE order_side AS ENUM ('BUY', 'SELL');

-- Type: Market or Limit order
CREATE TYPE order_type AS ENUM ('MARKET', 'LIMIT');

-- Status: Order lifecycle states
CREATE TYPE order_status AS ENUM (
    'NEW',
    'PARTIALLY_FILLED',
    'FILLED',
    'CANCELLED',
    'REJECTED'
);

-- =========================================
-- 3. ORDERS TABLE
-- =========================================
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    symbol VARCHAR(32) NOT NULL,
    side order_side NOT NULL,
    type order_type NOT NULL,
    price NUMERIC(18, 8),
    quantity NUMERIC(18, 8) NOT NULL,
    filled_qty NUMERIC(18, 8) NOT NULL DEFAULT 0,
    status order_status NOT NULL DEFAULT 'NEW',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for common queries
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_symbol ON orders(symbol);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);
CREATE INDEX idx_orders_user_created ON orders(user_id, created_at DESC);

