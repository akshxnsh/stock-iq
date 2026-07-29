# StockIQ Development Plan

This plan is designed for a fresher backend developer building StockIQ over 2-3 months while learning Spring Boot and backend engineering fundamentals. The goal is not to build a complex distributed trading system immediately. The goal is to build a clean, working, resume-worthy backend project step by step.

## Phase 1 - Build the Foundation

### Goal

Create a clean backend foundation with users, authentication, security, DTOs, validation, and consistent error handling.

### Tasks

- Add a `User` JPA entity that matches the existing `users` table.
- Add a `UserRepository`.
- Create a proper package structure such as `auth`, `user`, `trading`, `portfolio`, `common`, and `config`.
- Add DTOs for API requests and responses.
- Add validation using Jakarta Bean Validation annotations.
- Add Spring Security.
- Implement JWT-based authentication.
- Add registration and login APIs.
- Hash passwords using BCrypt.
- Add user CRUD APIs for basic profile management.
- Add a global exception handler using `@ControllerAdvice`.
- Create consistent API error responses.

### Why This Matters

Most real backend systems start with identity, validation, security, and predictable error handling. These are expected skills in backend interviews and make the rest of the project easier to build correctly.

### Expected Learning Outcome

You should understand how Spring Security works, how JWT authentication fits into REST APIs, how DTOs protect your entity model, and how to return clean validation and error responses.

## Phase 2 - Core Trading Features

### Goal

Build the main business features of the paper trading platform.

### Tasks

- Add order placement API.
- Add order listing API.
- Add get order by ID API.
- Add cancel order API.
- Add pagination and sorting for order history.
- Create a service layer for trading logic.
- Add basic order validation rules: quantity must be positive, limit orders must have a price, market orders should not require a price, and users can only access their own orders.
- Add portfolio APIs.
- Track simple virtual cash balance and holdings.
- Add watchlist APIs.
- Add transaction history APIs.
- Use database transactions for operations that update multiple records.
- Avoid putting business logic directly inside controllers.

### Why This Matters

This phase turns the project from a scaffold into a usable backend application. It also demonstrates that you can model a domain, write service-layer logic, and expose clean REST APIs.

### Expected Learning Outcome

You should become comfortable designing REST APIs, writing service classes, using repositories correctly, handling transactions, and building features around real business rules.

## Phase 3 - Improve the Backend

### Goal

Improve reliability, maintainability, local development, testing, and documentation.

### Tasks

- Add Redis caching for simple use cases, such as watchlist data or frequently requested order summaries.
- Dockerize the Spring Boot application with a Dockerfile.
- Update Docker Compose to run the app with PostgreSQL and Redis.
- Add Swagger/OpenAPI documentation.
- Add unit tests for service-layer business logic.
- Add repository tests.
- Add integration tests using Testcontainers for PostgreSQL.
- Add structured logging for important workflows.
- Move database credentials and secrets to environment variables.
- Add separate configuration profiles for local and test environments.
- Keep Redis usage simple and easy to explain.

### Why This Matters

Good backend projects are not just about features. They should be testable, easy to run, observable during debugging, and safe to configure across environments.

### Expected Learning Outcome

You should learn practical testing, Docker basics, API documentation, environment-based configuration, and when caching is useful.

## Phase 4 - Event Driven Features

### Goal

Add simple asynchronous processing using Kafka without over-engineering the system.

### Tasks

- Add Kafka to Docker Compose.
- Add Spring Kafka dependency and configuration.
- Create an `OrderPlaced` event.
- Publish `OrderPlaced` when an order is created.
- Create an `OrderCancelled` event.
- Publish `OrderCancelled` when an order is cancelled.
- Add a simple notification component that consumes these events.
- Store basic notification records in the database or log them clearly.
- Add basic retry/error logging for event consumers.
- Keep event payloads small and versioned.

### Why This Matters

Many production backends use messaging for asynchronous workflows. This phase gives you interview-ready exposure to Kafka while keeping the design understandable.

### Expected Learning Outcome

You should understand producers, consumers, topics, event payloads, async processing, and the difference between synchronous REST calls and event-driven workflows.

## Phase 5 - Polish

### Goal

Make the project easier to review, run, explain, and discuss in backend interviews.

### Tasks

- Improve README and API documentation.
- Add architecture notes with the actual implemented design.
- Add GitHub Actions for build and test.
- Add performance improvements for slow queries.
- Add database indexes where query patterns justify them.
- Add optimistic locking for entities that can be updated concurrently.
- Add API rate limiting for authentication and order APIs.
- Add Spring Boot Actuator health checks.
- Add production-ready Docker Compose with app, database, Redis, and Kafka.
- Add example API requests and responses.
- Add a short resume section describing measurable project outcomes.

### Why This Matters

Interviewers look for projects that are complete enough to run, inspect, and discuss. Polish helps convert a learning project into a strong resume project.

### Expected Learning Outcome

You should learn how to present backend work professionally, automate basic quality checks, explain performance decisions, and prepare a project for realistic deployment.

## Suggested Timeline

- Weeks 1-2: Phase 1
- Weeks 3-5: Phase 2
- Weeks 6-7: Phase 3
- Weeks 8-9: Phase 4
- Weeks 10-12: Phase 5

This timeline can be adjusted based on college workload. It is better to finish fewer features cleanly than to add many incomplete features.

## Resume Target

By the end of this plan, the project should be able to honestly claim:

- Spring Boot REST backend for a paper trading platform
- JWT authentication with Spring Security
- PostgreSQL schema managed by Flyway
- Redis caching for selected read-heavy workflows
- Kafka-based async events for order workflows
- Docker Compose local development setup
- Swagger/OpenAPI documentation
- Unit and integration tests
- GitHub Actions CI
- Clean layered architecture with controllers, services, repositories, DTOs, and exception handling
