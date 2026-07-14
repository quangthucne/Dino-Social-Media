import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _activeFilterIndex = 0; // 0: Tất cả, 1: Chưa đọc

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded, color: Color(0xFF1E293B)),
            onPressed: () {},
            tooltip: 'Đánh dấu tất cả đã đọc',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Row (Capsules/Chips UI)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                _buildFilterChip('Tất cả', 0),
                const SizedBox(width: 8),
                _buildFilterChip('Chưa đọc', 1),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          // Notification List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 96.0), // Space for floating tab bar
              itemCount: 8,
              itemBuilder: (context, index) {
                final names = [
                  'Bùi Quang Thực',
                  'Hoàng Long',
                  'Thu Hà',
                  'Đức Anh',
                  'Linh Chi',
                  'Trần Hùng',
                  'Thanh Trúc',
                  'Quốc Bảo'
                ];
                final actions = [
                  'đã bày tỏ cảm xúc về bài viết của bạn.',
                  'đã bình luận về bài viết của bạn.',
                  'đã gửi lời mời kết bạn.',
                  'đã gắn thẻ bạn trong một bài viết.',
                  'đã chia sẻ bài viết của bạn.',
                  'đã phản hồi bình luận của bạn.',
                  'đã nhắc đến bạn trong một bình luận.',
                  'đã đăng một bài viết mới trong Nhóm Flutter Việt Nam.'
                ];
                final times = [
                  '2 phút trước',
                  '15 phút trước',
                  '1 giờ trước',
                  '3 giờ trước',
                  '5 giờ trước',
                  '1 ngày trước',
                  '2 ngày trước',
                  '3 ngày trước'
                ];
                final types = [
                  'like',
                  'comment',
                  'friend',
                  'tag',
                  'share',
                  'reply',
                  'mention',
                  'post'
                ];
                final isUnread = [true, true, true, false, false, false, false, false];

                // Nếu chọn lọc chưa đọc, bỏ qua các mục đã đọc
                if (_activeFilterIndex == 1 && !isUnread[index]) {
                  return const SizedBox.shrink();
                }

                return _buildNotificationTile(
                  names[index],
                  'https://i.pravatar.cc/150?img=${index + 15}',
                  actions[index],
                  times[index],
                  types[index],
                  isUnread[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    final active = index == _activeFilterIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeFilterIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: active ? Colors.deepOrange : const Color(0xFFF1F5F9), // Slate 100
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF475569), // Slate 600
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile(
    String name,
    String avatarUrl,
    String actionText,
    String timeAgo,
    String type,
    bool isUnread,
  ) {
    IconData badgeIcon;
    Color badgeColor;

    switch (type) {
      case 'like':
        badgeIcon = Icons.favorite_rounded;
        badgeColor = Colors.redAccent;
        break;
      case 'comment':
      case 'reply':
      case 'mention':
        badgeIcon = Icons.chat_bubble_rounded;
        badgeColor = Colors.blueAccent;
        break;
      case 'friend':
        badgeIcon = Icons.person_add_alt_1_rounded;
        badgeColor = Colors.green;
        break;
      case 'share':
        badgeIcon = Icons.share_rounded;
        badgeColor = Colors.teal;
        break;
      case 'tag':
        badgeIcon = Icons.local_offer_rounded;
        badgeColor = Colors.amber;
        break;
      default:
        badgeIcon = Icons.notifications_rounded;
        badgeColor = Colors.deepOrange;
    }

    return Container(
      color: isUnread ? const Color(0xFFEFF6FF) : Colors.transparent, // Light Blue tint for unread
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                // Badge overlay indicating type of notification
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: badgeColor,
                      child: Icon(badgeIcon, color: Colors.white, size: 9),
                    ),
                  ),
                ),
              ],
            ),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14.5),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: actionText),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                timeAgo,
                style: TextStyle(
                  color: isUnread ? Colors.blueAccent : const Color(0xFF64748B),
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Color(0xFF94A3B8)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Container(
              height: 1,
              color: const Color(0xFFF1F5F9), // Divider line
            ),
          ),
        ],
      ),
    );
  }
}
