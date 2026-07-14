CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    -- Đối tượng liên quan
    recipient_id UUID NOT NULL,          -- Người nhận (Index để load danh sách thông báo)
    sender_id UUID,                     -- Người tạo ra hành động (Ví dụ: thằng bạn vừa Like)
    
    -- Phân loại và Nội dung
    type VARCHAR(20) NOT NULL,          -- EMAIL, PUSH, IN_APP, SMS
    template_code VARCHAR(50),          -- Mã template đã dùng
    title TEXT NOT NULL,                -- Tiêu đề đã render
    content TEXT NOT NULL,              -- Nội dung đã render (để user xem lại dù template bị xóa)
    
    -- Metadata & Deep-linking (Rất quan trọng cho Mobile)
    -- Lưu dạng JSONB để linh hoạt: {"post_id": "123", "screen": "comment_detail"}
    metadata JSONB,                     
    
    -- Trạng thái vòng đời
    status VARCHAR(20) DEFAULT 'SENT',  -- SENT, DELIVERED, READ, FAILED
    error_detail TEXT,                  -- Lưu lý do nếu gửi mail/push thất bại
    
    -- Thời gian
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP WITH TIME ZONE,   -- Thời điểm user bấm vào xem thông báo
    
    -- Trình tối ưu hóa
    deleted_at TIMESTAMP WITH TIME ZONE -- Soft delete (nếu user xóa thông báo)
);

-- Index quan trọng để load "Cái chuông" cực nhanh
CREATE INDEX idx_notifications_recipient_read ON notifications (recipient_id, status) WHERE status != 'READ';
CREATE INDEX idx_notifications_created_at ON notifications (created_at DESC);