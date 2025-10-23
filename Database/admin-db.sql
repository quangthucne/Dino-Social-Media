-- =================================================================
-- Script for: admin_db (AdminService)
-- Database Type: PostgreSQL
-- =================================================================

DROP TABLE IF EXISTS "Reports";

-- ---------------------------------
-- Table: Reports
-- ---------------------------------
CREATE TABLE "Reports" (
    "report_id" BIGSERIAL PRIMARY KEY,
    "reporter_user_id" BIGINT NOT NULL, -- ID người báo cáo (từ UserService)
    "reported_entity_type" VARCHAR(20) NOT NULL CHECK ("reported_entity_type" IN ('post', 'comment', 'user', 'group')),
    "reported_entity_id" BIGINT NOT NULL, -- ID của post/comment/user/group bị báo cáo
    "reason" TEXT NOT NULL,
    "status" VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK ("status" IN ('pending', 'resolved', 'dismissed')),
    "notes" TEXT, -- Ghi chú của admin xử lý
    "created_at" TIMESTAMPTZ DEFAULT NOW(),
    "updated_at" TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE "Reports" IS 'Lưu trữ các báo cáo vi phạm từ người dùng.';

-- ---------------------------------
-- Indexes
-- ---------------------------------
-- Index để admin xem các báo cáo đang chờ xử lý
CREATE INDEX "idx_reports_status" ON "Reports"("status") WHERE "status" = 'pending';
-- Index để tra cứu lịch sử báo cáo của một đối tượng
CREATE INDEX "idx_reports_entity" ON "Reports"("reported_entity_type", "reported_entity_id");