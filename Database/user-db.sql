-- =================================================================
-- Script for: user_db (UserService) - PHIÊN BẢN UUID
-- Database Type: PostgreSQL
--
-- *** BƯỚC 1: Chạy lệnh này một mình ***
-- CREATE DATABASE user_service;
--
-- *** BƯỚC 2: Kết nối với database 'user_service' (ví dụ: \c user_service)
-- *** VÀ CHẠY PHẦN CÒN LẠI CỦA SCRIPT NÀY ***
-- =================================================================

-- Drop tables in reverse order
DROP TABLE IF EXISTS "user_settings";
DROP TABLE IF EXISTS "users";

-- ---------------------------------
-- Table: users
-- ---------------------------------
CREATE TABLE "users" (
    "user_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- <<< THAY ĐỔI
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
COMMENT ON COLUMN "users"."user_id" IS 'Khóa chính UUID, tự động tạo.';

-- ---------------------------------
-- Table: user_settings
-- ---------------------------------
CREATE TABLE "user_settings" (
    "setting_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- <<< THAY ĐỔI
    "user_id" UUID UNIQUE NOT NULL,                          -- <<< THAY ĐỔI (từ BIGINT sang UUID)
    "theme" VARCHAR(10) DEFAULT 'light' CHECK ("theme" IN ('light', 'dark')),
    "language" VARCHAR(5) DEFAULT 'en',
    "notifications_enabled" BOOLEAN DEFAULT TRUE,
    "last_updated" TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "users"("user_id") ON DELETE CASCADE
);

COMMENT ON TABLE "user_settings" IS 'Lưu trữ các cài đặt cá nhân của người dùng. Mỗi user là UNIQUE.';
COMMENT ON COLUMN "user_settings"."setting_id" IS 'Khóa chính UUID (surrogate key).';
COMMENT ON COLUMN "user_settings"."user_id" IS 'Khóa ngoại trỏ đến users(user_id). Ràng buộc UNIQUE để đảm bảo 1-1.';


-- ---------------------------------
-- Indexes
-- ---------------------------------
CREATE INDEX "idx_users_username" ON "users"("username");
CREATE INDEX "idx_users_email" ON "users"("email");
CREATE INDEX "idx_user_settings_user_id" ON "user_settings"("user_id");


-- =================================================================
-- Seed Data for: user_db (UserService)
-- (Script seed không cần thay đổi logic, vì nó tra cứu bằng 'username')
-- =================================================================

-- ---------------------------------
-- Seed Table: "users"
-- ---------------------------------
INSERT INTO "users" 
    ("username", "email", "password_hash", "full_name", "bio", "is_verified")
VALUES 
    (
        'admin_user', 
        'admin@example.com', 
        '$2a$12$R.P.F.S/3.A.B.C.D.E.F.G.H.I.J.K.L.M.N.O.P.Q.R.S.T.U.V.W', 
        'Quản Trị Viên', 
        'Đây là tài khoản quản trị hệ thống.',
        true
    ),
    (
        'john_doe', 
        'john.doe@example.com', 
        '$2a$12$R.P.F.S/3.A.B.C.D.E.F.G.H.I.J.K.L.M.N.O.P.Q.R.S.T.U.V.W',
        'John Doe', 
        'Xin chào! Tôi là người dùng mới.',
        false
    ),
    (
        'jane_creative', 
        'jane@creative.com', 
        '$2a$12$R.P.F.S/3.A.B.C.D.E.F.G.H.I.J.K.L.M.N.O.P.Q.R.S.T.U.V.W',
        'Jane Smith', 
        'Nhà thiết kế & Sáng tạo nội dung. Theo dõi tôi nhé!',
        true
    );

-- ---------------------------------
-- Seed Table: "user_settings"
-- ---------------------------------
INSERT INTO "user_settings" 
    ("user_id", "theme", "language", "notifications_enabled")
VALUES
    (
        (SELECT "user_id" FROM "users" WHERE "username" = 'admin_user'), 
        'dark', 
        'vi', 
        true
    ),
    (
        (SELECT "user_id" FROM "users" WHERE "username" = 'jane_creative'), 
        'light', 
        'en', 
        false
    );