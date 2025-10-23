-- =================================================================
-- Script for creating a COMPLETE social media database (PostgreSQL)
-- This is a MONOLITHIC design (all tables in one schema).
-- =================================================================

-- Drop tables in reverse order of dependency to prevent errors
DROP TABLE IF EXISTS "Likes";
DROP TABLE IF EXISTS "Comments";
DROP TABLE IF EXISTS "GroupMembers";
DROP TABLE IF EXISTS "Roles";
DROP TABLE IF EXISTS "Groups";
DROP TABLE IF EXISTS "Follows";
DROP TABLE IF EXISTS "Posts";
DROP TABLE IF EXISTS "Users";

-- =================================================================
-- Table: Users
-- =================================================================
CREATE DATABASE dino_user
CREATE TABLE "Users" (
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
-- NOTE: Trong mô hình đơn khối chuẩn hóa, chúng ta sẽ tính toán
-- 'follower_count' và 'following_count' bằng cách COUNT từ bảng 'Follows' 
-- thay vì lưu trữ chúng (denormalization).

-- =================================================================
-- Table: Roles (For Group Permissions)
-- =================================================================
CREATE TABLE "Roles" (
    "role_id" SERIAL PRIMARY KEY,
    "role_name" VARCHAR(50) UNIQUE NOT NULL
);

-- =================================================================
-- Table: Groups
-- =================================================================
CREATE TABLE "Groups" (
    "group_id" BIGSERIAL PRIMARY KEY,
    "creator_id" BIGINT NOT NULL,
    "group_name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "cover_image_url" VARCHAR(255),
    "is_private" BOOLEAN DEFAULT FALSE,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT "fk_creator" FOREIGN KEY("creator_id") REFERENCES "Users"("user_id") ON DELETE SET NULL
);

-- =================================================================
-- Table: GroupMembers (Junction table for Users, Groups, Roles)
-- =================================================================
CREATE TABLE "GroupMembers" (
    "group_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "role_id" INT NOT NULL,
    "joined_at" TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY ("group_id", "user_id"),
    CONSTRAINT "fk_group" FOREIGN KEY("group_id") REFERENCES "Groups"("group_id") ON DELETE CASCADE,
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE,
    CONSTRAINT "fk_role" FOREIGN KEY("role_id") REFERENCES "Roles"("role_id")
);

-- =================================================================
-- Table: Posts
-- =================================================================
CREATE TABLE "Posts" (
    "post_id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "caption" TEXT,
    "media_url" VARCHAR(255) NOT NULL,
    "media_type" VARCHAR(10) NOT NULL CHECK ("media_type" IN ('video', 'image')),
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE
);
-- NOTE: 'like_count' và 'comment_count' được tính từ bảng 'Likes' và 'Comments'.

-- =================================================================
-- Table: Follows (Social Graph)
-- =================================================================
CREATE TABLE "Follows" (
    "follower_id" BIGINT NOT NULL,
    "following_id" BIGINT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY ("follower_id", "following_id"),
    CONSTRAINT "fk_follower" FOREIGN KEY("follower_id") REFERENCES "Users"("user_id") ON DELETE CASCADE,
    CONSTRAINT "fk_following" FOREIGN KEY("following_id") REFERENCES "Users"("user_id") ON DELETE CASCADE
);

-- =================================================================
-- Table: Comments (Interactions)
-- =================================================================
CREATE TABLE "Comments" (
    "comment_id" BIGSERIAL PRIMARY KEY,
    "post_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "comment_text" TEXT NOT NULL,
    "parent_comment_id" BIGINT,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT "fk_post" FOREIGN KEY("post_id") REFERENCES "Posts"("post_id") ON DELETE CASCADE,
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE,
    CONSTRAINT "fk_parent_comment" FOREIGN KEY("parent_comment_id") REFERENCES "Comments"("comment_id") ON DELETE CASCADE
);

-- =================================================================
-- Table: Likes (Interactions)
-- =================================================================
CREATE TABLE "Likes" (
    "user_id" BIGINT NOT NULL,
    "post_id" BIGINT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY ("user_id", "post_id"),
    CONSTRAINT "fk_user" FOREIGN KEY("user_id") REFERENCES "Users"("user_id") ON DELETE CASCADE,
    CONSTRAINT "fk_post" FOREIGN KEY("post_id") REFERENCES "Posts"("post_id") ON DELETE CASCADE
);

-- =================================================================
-- Indexes for Performance
-- =================================================================
CREATE INDEX "idx_users_username" ON "Users"("username");
CREATE INDEX "idx_posts_user_id_created_at" ON "Posts"("user_id", "created_at" DESC);
CREATE INDEX "idx_follows_following_id" ON "Follows"("following_id");
CREATE INDEX "idx_comments_post_id_created_at" ON "Comments"("post_id", "created_at" DESC);
CREATE INDEX "idx_likes_post_id" ON "Likes"("post_id");
CREATE INDEX "idx_groupmembers_user_id" ON "GroupMembers"("user_id");

-- =================================================================
-- Seed Data (Initial Data)
-- =================================================================
INSERT INTO "Roles" ("role_name") VALUES ('admin'), ('moderator'), ('member');

-- End of script