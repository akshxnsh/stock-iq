# Quick Start Guide - StockIQ Trading Service

## ✅ What's Been Set Up

**Steps 1 & 2 are COMPLETE:**
- ✅ Docker Compose with Postgres 15 + Redis 7
- ✅ Spring Boot project with all dependencies
- ✅ Database configuration
- ✅ Flyway migration V1 (users + orders tables)
- ✅ JPA entities (Order, enums)
- ✅ Spring Data repository

---

## 🚀 Starting the Application

### Run with Batch File
Double-click `run-app.bat` in the project root, or run:
```cmd
run-app.bat
```

### Run with Maven
```cmd
cd path\to\StockIQ
mvn spring-boot:run
```

The application will:
1. Connect to Postgres on localhost:5432
2. Run Flyway migrations (create tables)
3. Start Tomcat on port 8081

---

## 🔍 Manual Verification

### 1. Check Docker Containers
Open a new PowerShell/CMD window:
```cmd
docker ps
```

You should see:
- `stockiq-postgres` (healthy)
- `stockiq-redis` (healthy)

### 2. Check Database Tables
```cmd
docker exec -it stockiq-postgres psql -U stockiq -d stockiq
```

Then in psql:
```sql
\dt

SELECT * FROM flyway_schema_history;

\d orders

\q
```

Expected tables:
- `users`
- `orders`
- `flyway_schema_history`

### 3. Verify Application Started
Look for these lines in the startup output:
```
Flyway Community Edition 11.14.1
Successfully applied 1 migration to schema "public"
Started StockIQApplication in X.XXX seconds
Tomcat started on port(s): 8081 (http)
```

---

## 📁 Key Files Created

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Postgres + Redis containers |
| `pom.xml` | Maven dependencies (updated) |
| `application.yml` | Spring Boot configuration |
| `V1__init_trading.sql` | Database schema migration |
| `Order.java` | JPA entity for orders |
| `OrderRepository.java` | Spring Data repository |
| `run-app.bat` | Quick start script |

---

## 🛠️ Troubleshooting

### Port Already in Use
If you see "Port 8081 was already in use":
```cmd
# Kill existing Java processes
taskkill /F /IM java.exe

# Or change port in application.yml:
server:
  port: 8082
```

### Database Connection Failed
```cmd
# Restart Docker containers
docker compose down
docker compose up -d

# Wait 10 seconds then try again
```

### Flyway Migration Errors
If migration fails, check:
1. Postgres is running: `docker ps`
2. Can connect: `docker exec stockiq-postgres psql -U stockiq -d stockiq -c "SELECT 1;"`
3. Migration file exists: `src/main/resources/db/migration/V1__init_trading.sql`

---

## 📊 Database Schema

### users table
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### orders table
```sql
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    symbol VARCHAR(32) NOT NULL,
    side order_side NOT NULL,  -- BUY, SELL
    type order_type NOT NULL,  -- MARKET, LIMIT
    price NUMERIC(18,8),
    quantity NUMERIC(18,8) NOT NULL,
    filled_qty NUMERIC(18,8) NOT NULL DEFAULT 0,
    status order_status NOT NULL DEFAULT 'NEW',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

---

## 🎯 What's Next

Future steps (NOT implemented yet):
1. Service layer with business logic
2. REST controllers for APIs
3. Kafka integration for events
4. Unit and integration tests

---

## 📝 Configuration Reference

### application.yml
- **Server Port:** 8081
- **Database:** jdbc:postgresql://localhost:5432/stockiq
- **Redis:** localhost:6379
- **Flyway:** Enabled, baseline-on-migrate
- **JPA:** ddl-auto=validate, show-sql=true

### Docker Services
- **Postgres:** postgres:15, port 5432
- **Redis:** redis:7, port 6379

---

**Ready to develop!** Run `run-app.bat` and start building features. 🚀
