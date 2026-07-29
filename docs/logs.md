# StockIQ - Development Log

A running log of what I implemented on which day, for my own tracking and future case-study.

> Format:
> - Date (YYYY-MM-DD)
> - Service / area
> - Changes
> - Notes / learnings

---

## 2025-11-30

### Area: Infrastructure Setup & Database Foundation (trading-service)

**Infrastructure:**
- [x] Added `docker-compose.yml` with Postgres 15 + Redis 7 containers
- [x] Configured `application.yml` with datasource, JPA, Flyway, Redis settings
- [x] Fixed Docker authentication and timezone configuration conflicts
- [x] Resolved port conflicts (moved app to 8081)
- [x] Added component scanning for `com.stockiq` package

**Database Schema & Migrations:**
- [x] Added Flyway migration `V1__init_trading.sql`:
  - `users` table with email, username, hashed_password
  - ENUMs: `order_side`, `order_type`, `order_status`
  - `orders` table linked to `users` with ON DELETE CASCADE
  - Indexes for common query patterns (user_id, symbol, status, created_at)
- [x] Verified Flyway applied migrations successfully
- [x] Confirmed `users`, `orders`, and `flyway_schema_history` tables exist in Postgres

**Domain Model & Repository:**
- [x] Created Java enums: `OrderSide`, `OrderType`, `OrderStatus` matching Postgres ENUMs
- [x] Created `Order` JPA entity in `com.stockiq.trading.domain`
  - Mapped all fields with proper annotations (@Id, @Column, @Enumerated)
  - Used UUID, BigDecimal, OffsetDateTime for type safety
  - Added `@PrePersist` and `@PreUpdate` lifecycle callbacks for timestamps
- [x] Created `OrderRepository` extending `JpaRepository<Order, UUID>`
  - Added `findByUserIdOrderByCreatedAtDesc(UUID userId)`
  - Added `findBySymbol(String symbol)`
  - Added `findByUserIdAndStatus(UUID userId, OrderStatus status)`

**Troubleshooting & Fixes:**
- [x] Resolved "Cannot load driver class: org.postgresql.Driver" error
  - Root cause: PostgreSQL driver dependency not resolving from Spring Boot parent POM
  - Solution: Added explicit version `42.7.4` to `org.postgresql:postgresql` dependency
  - Verification: Driver successfully downloaded (1.1 MB) and appears in runtime dependency tree
- [x] Application successfully started with all components operational
  - PostgreSQL driver loaded correctly
  - Flyway migrations applied
  - Hibernate EntityManagerFactory initialized
  - Tomcat running on port 8081
  - Total startup time: ~3.5 seconds

---

### Area: 💡 Architecture Deep Dive — Senior Developer Explanation

**Component Deep Dive Completed:**

- **PostgreSQL 15**: Core transactional database with UUIDs, enums, strong ACID guarantees. Configured with explicit dialect, UTC timezone handling, and validation-only DDL mode for Flyway-first schema management.

- **Flyway**: Database version control ensuring schema consistency across environments. Tracks applied migrations via `flyway_schema_history`, uses versioned naming convention (V1__description.sql), and prevents accidental schema drift.

- **Hibernate/JPA**: Maps domain objects to relational tables, validates schema at startup. Entity lifecycle callbacks (`@PrePersist`, `@PreUpdate`) manage timestamps automatically. Uses `ddl-auto=validate` to fail fast on schema mismatches.

- **Data Types**: 
  - UUID for distributed identity (avoids sequential ID guessing, supports multi-region scaling)
  - BigDecimal for precise finance math (NUMERIC(18,8) prevents floating-point rounding errors)
  - OffsetDateTime for global timestamp accuracy (TIMESTAMPTZ preserves timezone info)
  - DB enums for domain integrity (order_side, order_type, order_status enforce valid states at database level)

- **Spring Data JPA**: Auto-generated query implementation from method names (e.g., `findByUserIdOrderByCreatedAtDesc`). Repository interfaces extend `JpaRepository<Order, UUID>` providing CRUD + custom queries. Indexes aligned with query patterns (idx_orders_user_created supports ordered user queries).

- **Redis 7**: In-memory cache and session foundation for future low-latency features. Currently configured but unused—ready for `@EnableCaching` + session storage when traffic patterns justify it.

**Configuration Files Reviewed:**
- `application.yml`: Datasource, JPA/Hibernate, Flyway, Redis settings
- `docker-compose.yml`: PostgreSQL 15 + Redis 7 containers
- `V1__init_trading.sql`: Initial schema with users, orders, enums, indexes
- `Order.java`: Entity with proper type mapping (UUID, BigDecimal, OffsetDateTime)
- `OrderRepository.java`: Spring Data JPA derived query methods

**Critical Configuration Decisions:**
- `ddl-auto: validate` prevents schema drift (Flyway-first approach)
- `open-in-view: false` avoids lazy loading issues outside transactions
- `hibernate.jdbc.time_zone: UTC` ensures consistent timestamp handling
- `baseline-on-migrate: true` for safe Flyway adoption on existing schemas

**Next Enhancements:**
- [ ] Add optimistic locking (`@Version` column) for concurrent order updates
- [ ] Introduce caching on high-traffic reads (enable Spring Cache + Redis)
- [ ] Add DB extension migration for pgcrypto (`V2__enable_pgcrypto.sql`)
- [ ] Add pagination for repository read endpoints (`Pageable` parameter support)
- [ ] Consider partial index for open orders: `WHERE status IN ('NEW','PARTIALLY_FILLED')`
- [ ] Add Bean Validation annotations (`@Positive`, `@NotNull`) to entity fields
- [ ] Configure Redis serialization (Jackson2Json instead of JDK default)
- [ ] Implement service layer to encapsulate business logic and status transitions

**Notes / Learnings:**
- Understood the "magic" behind Spring Boot auto-configuration (DataSource → Flyway → JPA → Repositories)
- Learned trade-offs: PostgreSQL strong consistency vs NoSQL horizontal scaling
- Saw how JPA lifecycle callbacks and database defaults can create dual sources of truth
- Recognized importance of index alignment with query patterns for performance
- Understood enum mapping: Java `@Enumerated(STRING)` + Postgres custom types = type safety at both layers
- Realized Redis is "wired but idle" until explicit caching/session config added

---

## Future Entries

Use this structure for future work:

### YYYY-MM-DD

### Area: <Service or Feature Name>

- [ ] Changes made
- [ ] More changes...

**Notes / Learnings:**
- Key takeaways...
- Gotchas, issues, decisions...
