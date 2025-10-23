/* * "Script" for: interaction_db (InteractionService)
 * Database Type: Apache Cassandra
 * Ngôn ngữ: CQL (Cassandra Query Language)
 */

-- Tạo một "keyspace" (tương tự database)
CREATE KEYSPACE IF NOT EXISTS interaction_db
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE interaction_db;

/*
 * Bảng để lấy comment theo bài đăng.
 * Truy vấn: "Lấy 50 comment mới nhất của post_id = X"
 */
CREATE TABLE IF NOT EXISTS comments_by_post (
    post_id bigint,
    comment_id timeuuid,
    user_id bigint,
    comment_text text,
    created_at timestamp,
    PRIMARY KEY (post_id, comment_id)
) WITH CLUSTERING ORDER BY (comment_id DESC);

/*
 * Bảng để lấy like theo bài đăng.
 * Truy vấn: "Kiểm tra xem user_id = Y đã like post_id = X chưa?"
 */
CREATE TABLE IF NOT EXISTS likes_by_post (
    post_id bigint,
    user_id bigint,
    liked_at timestamp,
    PRIMARY KEY (post_id, user_id)
);

/*
 * Bảng để đếm like (dùng kiểu counter).
 * Truy vấn: "Lấy tổng số like của post_id = X"
 */
CREATE TABLE IF NOT EXISTS like_counts (
    post_id bigint PRIMARY KEY,
    like_count counter
);
-- Để tăng like: UPDATE like_counts SET like_count = like_count + 1 WHERE post_id = ?;