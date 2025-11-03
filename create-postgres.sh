#!/bin/bash

# ===============================================
# SCRIPT TẠO CONTAINER POSTGRESQL TRÊN DOCKER
# Author: Grok
# Version: 1.0
# ===============================================

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Cấu hình mặc định
POSTGRES_VERSION="17"
CONTAINER_NAME="postgres-db"
DB_NAME="mydb"
DB_USER="dino@admin"
DB_PASSWORD="dinone@0310"
PORT="5432"
VOLUME_NAME="postgres_data"

# Hàm log
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Hiển thị banner
show_banner() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🐳 POSTGRESQL DOCKER                      ║"
    echo "║                    Tạo Container Nhanh                       ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Hiển thị menu cấu hình
show_config() {
    echo -e "${YELLOW}=== CẤU HÌNH HIỆN TẠI ===${NC}"
    echo "Container Name: ${CONTAINER_NAME}"
    echo "PostgreSQL Version: ${POSTGRES_VERSION}"
    echo "Database Name: ${DB_NAME}"
    echo "User: ${DB_USER}"
    echo "Port: ${PORT}"
    echo "Volume: ${VOLUME_NAME}"
    echo "Password: ${DB_PASSWORD}"
    echo -e "${NC}"
}

# Kiểm tra Docker
check_docker() {
    log_info "Kiểm tra Docker..."
    if ! command -v docker &> /dev/null; then
        log_error "Docker chưa được cài đặt!"
        exit 1
    fi
    log_success "Docker đã sẵn sàng!"
}

# Kiểm tra container đã tồn tại
check_container_exists() {
    if docker ps -a --format "table {{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        log_warning "Container '${CONTAINER_NAME}' đã tồn tại!"
        read -p "Bạn có muốn xóa và tạo lại? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker stop ${CONTAINER_NAME} 2>/dev/null
            docker rm ${CONTAINER_NAME}
            log_success "Đã xóa container cũ!"
        else
            exit 0
        fi
    fi
}

# Tạo volume
create_volume() {
    log_info "Tạo Docker Volume: ${VOLUME_NAME}"
    docker volume create ${VOLUME_NAME} >/dev/null 2>&1
    log_success "Volume '${VOLUME_NAME}' đã sẵn sàng!"
}

# Tạo container
create_container() {
    log_info "Tạo container PostgreSQL..."
    
    docker run -d \
        --name ${CONTAINER_NAME} \
        --restart unless-stopped \
        -e POSTGRES_DB=${DB_NAME} \
        -e POSTGRES_USER=${DB_USER} \
        -e POSTGRES_PASSWORD=${DB_PASSWORD} \
        -p ${PORT}:5432 \
        -v ${VOLUME_NAME}:/var/lib/postgresql/data \
        postgres:${POSTGRES_VERSION}
    
    if [ $? -eq 0 ]; then
        log_success "Container '${CONTAINER_NAME}' đã được tạo thành công!"
    else
        log_error "Lỗi khi tạo container!"
        exit 1
    fi
}

# Chờ container ready
wait_for_ready() {
    log_info "Đợi PostgreSQL khởi động (30s)..."
    sleep 30
    
    if docker logs ${CONTAINER_NAME} 2>&1 | grep -q "database system is ready to accept connections"; then
        log_success "PostgreSQL đã sẵn sàng!"
    else
        log_warning "PostgreSQL có thể chưa sẵn sàng hoàn toàn"
    fi
}

# Hiển thị thông tin kết nối
show_connection_info() {
    echo -e "${GREEN}"
    echo "══════════════════════════════════════════════════════════════"
    echo "✅ POSTGRESQL ĐÃ SẴN SÀNG!"
    echo "══════════════════════════════════════════════════════════════"
    echo ""
    echo "📋 THÔNG TIN KẾT NỐI:"
    echo "   Host: localhost"
    echo "   Port: ${PORT}"
    echo "   Database: ${DB_NAME}"
    echo "   Username: ${DB_USER}"
    echo "   Password: ${DB_PASSWORD}"
    echo ""
    echo "🔗 STRING KẾT NỐI:"
    echo "   postgresql://${DB_USER}:${DB_PASSWORD}@localhost:${PORT}/${DB_NAME}"
    echo ""
    echo "🚀 LỆNH TEST KẾT NỐI:"
    echo "   docker exec -it ${CONTAINER_NAME} psql -U ${DB_USER} -d ${DB_NAME}"
    echo ""
    echo "📊 KIỂM TRA LOGS:"
    echo "   docker logs ${CONTAINER_NAME}"
    echo "══════════════════════════════════════════════════════════════"
    echo -e "${NC}"
}

# Menu tùy chỉnh
show_menu() {
    echo -e "${YELLOW}=== TÙY CHỈNH CẤU HÌNH ===${NC}"
    read -p "Nhập tên container (Enter=keep): " input
    [[ -n $input ]] && CONTAINER_NAME="$input"
    
    read -p "Nhập tên DB (Enter=keep): " input
    [[ -n $input ]] && DB_NAME="$input"
    
    read -p "Nhập username (Enter=keep): " input
    [[ -n $input ]] && DB_USER="$input"
    
    read -p "Nhập password (Enter=keep): " input
    [[ -n $input ]] && DB_PASSWORD="$input"
    
    read -p "Nhập port (Enter=keep): " input
    [[ -n $input ]] && PORT="$input"
    
    show_config
}

# Main execution
main() {
    show_banner
    check_docker
    show_config
    
    read -p $'\n👉 Tùy chỉnh cấu hình? (y/N): ' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        show_menu
    fi
    
    check_container_exists
    create_volume
    create_container
    wait_for_ready
    show_connection_info
    
    log_success "Hoàn thành! 🎉"
}

# Chạy main
main "$@"