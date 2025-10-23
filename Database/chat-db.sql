/* * "Script" for: chat_db (ChatService)
 * Database Type: Apache Cassandra
 * Ngôn ngữ: CQL
 */

CREATE KEYSPACE IF NOT EXISTS chat_db
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE chat_db;

/*
 * Bảng lưu tin nhắn.
 * Truy vấn: "Lấy 100 tin nhắn mới nhất của cuộc trò chuyện (conversation_id) = X"
 */
CREATE TABLE IF NOT EXISTS messages_by_conversation (
    conversation_id uuid,
    message_id timeuuid,
    sender_id bigint,
    message_content text,
    sent_at timestamp,
    PRIMARY KEY (conversation_id, message_id)
) WITH CLUSTERING ORDER BY (message_id DESC);

/*
 * Bảng tra cứu các cuộc trò chuyện của một người dùng.
 * Truy vấn: "Lấy tất cả các cuộc trò chuyện mà user_id = Y tham gia"
 */
CREATE TABLE IF NOT EXISTS conversations_by_user (
    user_id bigint,
    conversation_id uuid,
    last_message text,
    last_updated timestamp,
    PRIMARY KEY (user_id, last_updated)
) WITH CLUSTERING ORDER BY (last_updated DESC);