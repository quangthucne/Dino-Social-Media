-- =================================================================
-- Script for: post_db (PostService)
-- Database Type: PostgreSQL
-- =================================================================

DROP TABLE IF EXISTS "Stories";
DROP TABLE IF EXISTS "Posts";

-- ---------------------------------
-- Table: Posts
-- ---------------------------------
CREATE TABLE "Posts" (
    "post_id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL, -- ID của người dùng từ UserService
    "group_id" BIGINT, -- ID của nhóm từ GroupService (nếu đăng trong nhóm)
    "caption" TEXT,
    "media_url" VARCHAR(255) NOT NULL,
    "media_type" VARCHAR(10) NOT NULL CHECK ("media_type" IN ('video', 'image')),
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    
    -- *** Dữ liệu phi chuẩn hóa (Denormalized Data) ***
    -- Sao chép từ UserService và GroupService để đọc feed nhanh
    -- Sẽ được cập nhật thông qua Message Broker (Kafka/RabbitMQ)
    "user_username" VARCHAR(30),
    "user_avatar_url" VARCHAR(255)
);

COMMENT ON TABLE "Posts" IS 'Lưu trữ meta-data của bài đăng. Media thật nằm trên S3.';
COMMENT ON COLUMN "Posts"."user_id" IS 'Tham chiếu đến user_id trong UserService.';
COMMENT ON COLUMN "Posts"."group_id" IS 'Tham chiếu đến group_id trong GroupService (nếu có).';
COMMENT ON COLUMN "Posts"."user_username" IS 'Dữ liệu sao chép từ UserService để tránh JOIN liên-service.';

-- ---------------------------------
-- Table: Stories
-- ---------------------------------
CREATE TABLE "Stories" (
    "story_id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "media_url" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    "expires_at" TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '24 hours')
);

-- ---------------------------------
-- Indexes
-- ---------------------------------
-- Index để lấy tất cả bài đăng của một người
CREATE INDEX "idx_posts_user_id" ON "Posts"("user_id", "created_at" DESC);
-- Index để lấy feed của một nhóm
CREATE INDEX "idx_posts_group_id" ON "Posts"("group_id", "created_at" DESC);
-- Index để dọn dẹp stories hết hạn
CREATE INDEX "idx_stories_expires_at" ON "Stories"("expires_at");