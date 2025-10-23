-- =================================================================
-- Script for: user_db (userservice)
-- Database Type: PostgreSQL
-- =================================================================

-- Drop tables in reverse order
DROP TABLE IF EXISTS "usersettings";
DROP TABLE IF EXISTS "users";

create DATABASE user_service

-- ---------------------------------
-- Table: users
-- ---------------------------------
CREATE TABLE "users" (
    "user_id" BIGSERIAL PRIMARY KEY,
    "username" VARCHAR(30) UNIQUE NOT NULL CHECK ("username" ~ '^[a-zA-Z0-9_.]+$'),
    "email" VARCHAR(100) UNIQUE NOT NULL,
    "password_hash" VARCHAR(255) NOT NULL,
    "full_name" VARCHAR(100),
    "bio" TEXT,
    "profile_picture_url" VARCHAR(255),
    "website_url" VARCHAR(255),
    "is_verified" BOOLEAN DEFAULT FALSE,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    "last_login" TIMESTAMPTZ
);

COMMENT ON TABLE "users" IS 'Nguồn chân lý (source of truth) cho thông tin người dùng.';

-- ---------------------------------
-- Table: usersettings
-- ---------------------------------
CREATE TABLE "user_settings" (
    "user_id" BIGINT PRIMARY KEY,
    "theme" VARCHAR(10) DEFAULT 'light' CHECK ("theme" IN ('light', 'dark')),
    "language" VARCHAR(5) DEFAULT 'en',
    "notifications_enabled" BOOLEAN DEFAULT TRUE,
    "last_updated" TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

COMMENT ON TABLE "user_settings" IS 'Lưu trữ các cài đặt cá nhân của người dùng.';

-- ---------------------------------
-- Indexes
-- ---------------------------------
CREATE INDEX "idx_users_username" ON "users"("username");
CREATE INDEX "idx_users_email" ON "users"("email");