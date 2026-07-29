# StockIQ

StockIQ is a learning-focused Spring Boot backend project for a paper trading platform. The project is currently in an early foundation stage: it has Spring Boot configuration, PostgreSQL and Redis infrastructure, Flyway database migration, and the first trading order domain model.

## Project Overview

StockIQ will allow users to create an account, manage a virtual trading portfolio, place paper trading orders, maintain a watchlist, and review transaction history.

This repository currently implements only the initial backend foundation. It is not yet a complete trading application and does not currently expose REST APIs.

## Features

### Implemented

- Spring Boot application setup
- Maven build configuration
- PostgreSQL configuration
- Redis configuration
- Docker Compose for PostgreSQL and Redis
- Flyway migration for initial database schema
- `users` and `orders` database tables
- `Order` JPA entity
- Order enums for side, type, and status
- Spring Data JPA repository for orders
- Basic application context test

### Planned

- User entity and user management APIs
- JWT-based authentication
- Spring Security configuration
- Order placement, listing, and cancellation APIs
- Portfolio APIs
- Watchlist APIs
- Transaction history
- DTOs and request validation
- Global exception handling
- Pagination and sorting
- Redis caching for frequently accessed data
- Swagger/OpenAPI documentation
- Unit and integration tests
- Dockerfile for the Spring Boot application
- Simple Kafka-based events for order placement and cancellation
- Health checks and basic production-readiness improvements

## Tech Stack

- Java 17
- Spring Boot
- Spring Web
- Spring Data JPA
- Hibernate
- PostgreSQL
- Flyway
- Redis
- Maven
- Docker Compose
- JUnit 5
- Lombok

Kafka, Spring Security, JWT, Swagger/OpenAPI, and advanced testing are planned but not implemented yet.

## Project Structure

```text
StockIQ-main/
+-- docker-compose.yml
+-- pom.xml
+-- README.md
+-- PLAN.md
+-- QUICK_START.md
+-- run-app.bat
+-- docs/
|   +-- logs.md
|   +-- SETUP_COMPLETE.md
|   +-- SYSTEM_SPECIFICATION.md
+-- src/
    +-- main/
    |   +-- java/
    |   |   +-- com/example/StockIQ/
    |   |   |   +-- StockIQApplication.java
    |   |   +-- com/stockiq/trading/domain/
    |   |       +-- Order.java
    |   |       +-- OrderRepository.java
    |   |       +-- OrderSide.java
    |   |       +-- OrderStatus.java
    |   |       +-- OrderType.java
    |   +-- resources/
    |       +-- application.yml
    |       +-- db/migration/
    |           +-- V1__init_trading.sql
    +-- test/
        +-- java/com/example/StockIQ/
            +-- StockIQApplicationTests.java
```

## Running Locally

### Prerequisites

- Java 17 or later
- Maven or the included Maven wrapper
- Docker Desktop

### Start PostgreSQL and Redis

```bash
docker compose up -d
```

This starts:

- PostgreSQL on port `5432`
- Redis on port `6379`

### Run the Spring Boot Application

Using Maven:

```bash
mvn spring-boot:run
```

Using the Maven wrapper on Windows:

```bash
.\mvnw.cmd spring-boot:run
```

The application is configured to run on:

```text
http://localhost:8081
```

At the current stage, the application starts but does not expose business REST APIs yet.

### Run Tests

```bash
mvn test
```

or:

```bash
.\mvnw.cmd test
```

## Database

The initial Flyway migration creates the following application tables:

- `users`
- `orders`

It also creates PostgreSQL enum types for:

- `order_side`
- `order_type`
- `order_status`

The `orders` table stores basic order details such as user ID, symbol, side, type, price, quantity, filled quantity, status, and timestamps.

The Java code currently has an `Order` entity. A matching `User` entity is planned as part of the next development phase.

## Roadmap

High-level roadmap:

1. Build the foundation: user entity, authentication, security, DTOs, validation, and cleaner package structure.
2. Add core trading features: order APIs, portfolio APIs, watchlist, transaction history, pagination, and service-layer business logic.
3. Improve backend quality: Redis caching, Dockerized app, Swagger/OpenAPI, tests, logging, and environment-based configuration.
4. Add simple event-driven features: Kafka events for order placement and cancellation, plus basic async notification processing.
5. Polish for resume and interviews: documentation, GitHub Actions, health checks, rate limiting, optimistic locking, and production-ready Docker Compose.

See [PLAN.md](PLAN.md) for the detailed development plan.

## Future Improvements

- Add proper authentication and authorization
- Add production-safe configuration profiles
- Move credentials to environment variables
- Add API documentation with Swagger/OpenAPI
- Add unit, integration, and repository tests
- Add Dockerfile for the backend application
- Add Kafka for simple asynchronous workflows
- Add observability with health checks, metrics, and structured logs
- Add rate limiting for public APIs
- Add optimistic locking for safer concurrent updates
- Add CI/CD using GitHub Actions
