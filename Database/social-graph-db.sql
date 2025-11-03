/* * "Script" for: social_graph_db (SocialGraphService)
 * Database Type: Neo4j
 * Ngôn ngữ: Cypher
 */

/* * Neo4j là "schema-less", nhưng chúng ta cần tạo các ràng buộc (constraints)
 * để đảm bảo user_id là duy nhất và được index.
 * * Khi bạn tạo 1 constraint, Neo4j tự động tạo 1 index.
 */
 
-- Tạo một constraint duy nhất cho Nút (Node) 'User' trên thuộc tính 'user_id'
CREATE CONSTRAINT unique_user_id IF NOT EXISTS
FOR (u:User) REQUIRE u.user_id IS UNIQUE;

/*
 * Không cần tạo bảng hay quan hệ.
 * Khi người dùng 123 theo dõi 456, ứng dụng sẽ chạy lệnh Cypher:
 *
 * MERGE (a:User {user_id: 123})
 * MERGE (b:User {user_id: 456})
 * MERGE (a)-[r:FOLLOWS]->(b)
 */