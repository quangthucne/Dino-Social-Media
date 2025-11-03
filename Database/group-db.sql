-- =================================================================
-- Script for: group_db (GroupService)
-- Database Type: PostgreSQL
-- =================================================================

-- Drop tables in reverse order
DROP TABLE IF EXISTS "RolePermissions";
DROP TABLE IF EXISTS "GroupMembers";
DROP TABLE IF EXISTS "Permissions";
DROP TABLE IF EXISTS "Roles";
DROP TABLE IF EXISTS "Groups";

-- ---------------------------------
-- Table: Groups
-- ---------------------------------
CREATE TABLE "Groups" (
    "group_id" BIGSERIAL PRIMARY KEY,
    "creator_id" BIGINT NOT NULL, -- Tham chiếu đến user_id trong UserService
    "group_name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "cover_image_url" VARCHAR(255),
    "is_private" BOOLEAN DEFAULT FALSE,
    "created_at" TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON COLUMN "Groups"."creator_id" IS 'ID của người dùng từ UserService. Không có khóa ngoại.';

-- ---------------------------------
-- Table: Roles
-- ---------------------------------
CREATE TABLE "Roles" (
    "role_id" SERIAL PRIMARY KEY,
    "role_name" VARCHAR(50) UNIQUE NOT NULL -- 'admin', 'moderator', 'member'
);

-- ---------------------------------
-- Table: Permissions
-- ---------------------------------
CREATE TABLE "Permissions" (
    "permission_id" SERIAL PRIMARY KEY,
    "permission_name" VARCHAR(100) UNIQUE NOT NULL, -- 'post:delete', 'user:ban', 'group:edit'
    "description" TEXT
);

-- ---------------------------------
-- Table: GroupMembers
-- ---------------------------------
CREATE TABLE "GroupMembers" (
    "group_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL, -- Tham chiếu đến user_id trong UserService
    "role_id" INT NOT NULL,
    "joined_at" TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY ("group_id", "user_id"),
    CONSTRAINT "fk_group" FOREIGN KEY("group_id") REFERENCES "Groups"("group_id") ON DELETE CASCADE,
    CONSTRAINT "fk_role" FOREIGN KEY("role_id") REFERENCES "Roles"("role_id")
);

-- ---------------------------------
-- Table: RolePermissions
-- ---------------------------------
CREATE TABLE "RolePermissions" (
    "role_id" INT NOT NULL,
    "permission_id" INT NOT NULL,
    PRIMARY KEY ("role_id", "permission_id"),
    CONSTRAINT "fk_role" FOREIGN KEY("role_id") REFERENCES "Roles"("role_id") ON DELETE CASCADE,
    CONSTRAINT "fk_permission" FOREIGN KEY("permission_id") REFERENCES "Permissions"("permission_id") ON DELETE CASCADE
);

-- ---------------------------------
-- Seed Data (Dữ liệu mồi)
-- ---------------------------------
INSERT INTO "Roles" ("role_name") VALUES ('admin'), ('moderator'), ('member');

INSERT INTO "Permissions" ("permission_name", "description") VALUES
    ('group:edit', 'Chỉnh sửa thông tin nhóm'),
    ('post:approve', 'Duyệt bài đăng'),
    ('post:delete', 'Xóa bài đăng của người khác'),
    ('member:invite', 'Mời thành viên mới'),
    ('member:kick', 'Xóa thành viên');

-- Gán quyền cho Admin
INSERT INTO "RolePermissions" ("role_id", "permission_id")
SELECT r."role_id", p."permission_id"
FROM "Roles" r, "Permissions" p
WHERE r."role_name" = 'admin'; -- Admin có tất cả quyền

-- Gán quyền cho Moderator
INSERT INTO "RolePermissions" ("role_id", "permission_id")
SELECT (SELECT "role_id" FROM "Roles" WHERE "role_name" = 'moderator'), "permission_id"
FROM "Permissions"
WHERE "permission_name" IN ('post:approve', 'post:delete', 'member:kick');