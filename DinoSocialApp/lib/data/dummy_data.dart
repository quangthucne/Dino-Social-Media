import '../models/post_model.dart';
import '../models/comment_model.dart';

// Dummy data for the feed (in Vietnamese)
final List<Post> dummyPosts = [
  Post(
    username: 'Bùi Quang Thực',
    avatarUrl:
        'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
    timeAgo: '5 phút trước',
    content:
        'Flutter là một bộ công cụ phát triển giao diện người dùng nguồn mở do Google tạo ra. Nó được sử dụng để phát triển các ứng dụng đa nền tảng cho Android, iOS, Linux, macOS, Windows và web từ một cơ sở mã duy nhất.',
    likes: 128,
    comments: 23,
  ),
  Post(
    username: 'Quang Thọt',
    avatarUrl:
        'https://res.cloudinary.com/dbrftgkrp/image/upload/v1756147653/6868Food/assets/20250826014730.jpg',
    timeAgo: '1 giờ trước',
    content: 'Đang tận hưởng hoàng hôn tuyệt đẹp! #thiênnhiên #hạnhphúc',
    imageUrl:
        'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1932&auto=format&fit=crop',
    likes: 432,
    comments: 78,
  ),
  Post(
    username: 'Trần Hùng',
    avatarUrl: 'https://i.pravatar.cc/150?img=3',
    timeAgo: '3 giờ trước',
    content: 'Tối nay thử công thức nấu ăn mới. Chúc mình may mắn!',
    likes: 75,
    comments: 12,
  ),
  Post(
    username: 'Linh Chi',
    avatarUrl: 'https://i.pravatar.cc/150?img=4',
    timeAgo: '5 giờ trước',
    content: 'Khám phá thành phố! Có quá nhiều cảnh đẹp để xem.',
    imageUrl:
        'https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?q=80&w=1887&auto=format&fit=crop',
    likes: 210,
    comments: 45,
  ),
];

final List<Comment> dummyComments = [
  Comment(
    username: 'Quang Thọt',
    avatarUrl: 'https://res.cloudinary.com/dbrftgkrp/image/upload/v1756147653/6868Food/assets/20250826014730.jpg',
    timeAgo: '2 phút trước',
    text: 'Bài viết tuyệt vời!',
  ),
  Comment(
    username: 'Trần Hùng',
    avatarUrl: 'https://i.pravatar.cc/150?img=3',
    timeAgo: '1 phút trước',
    stickerUrl: 'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg', // Example sticker
  ),
    Comment(
    username: 'Linh Chi',
    avatarUrl: 'https://i.pravatar.cc/150?img=4',
    timeAgo: 'Ngay bây giờ',
    text: 'Cảm ơn bạn đã chia sẻ!',
  ),
];
