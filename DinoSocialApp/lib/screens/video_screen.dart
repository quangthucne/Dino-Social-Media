import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900 - Premium dark background for videos
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        title: const Text(
          'Dino Watch',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12.0, bottom: 96.0), // Space for floating tab bar
        itemCount: 5,
        itemBuilder: (context, index) {
          final channels = ['Kênh Khoa học', 'Tin tức 24h', 'Ẩm thực Việt', 'Khám phá thế giới', 'Thể thao HD'];
          final times = ['10 phút trước', '1 giờ trước', '3 giờ trước', '5 giờ trước', '1 ngày trước'];
          final titles = [
            '10 phát hiện khảo cổ học làm thay đổi lịch sử loài người',
            'Bản tin sáng: Cập nhật tình hình thời tiết và sự kiện nổi bật hôm nay',
            'Cách làm món phở bò truyền thống chuẩn vị Hà Nội tại nhà',
            'Hành trình chinh phục đỉnh núi Fansipan - Nóc nhà Đông Dương',
            'Tổng hợp những bàn thắng đẹp mắt nhất vòng đấu Ngoại Hạng Anh tuần này'
          ];
          final durations = ['12:40', '08:15', '15:30', '22:10', '05:50'];
          final viewCounts = ['12K', '45K', '8.9K', '102K', '256K'];

          return _buildVideoCard(
            channels[index],
            'https://i.pravatar.cc/150?img=${index + 40}',
            times[index],
            titles[index],
            'https://picsum.photos/seed/${index + 90}/600/350',
            durations[index],
            viewCounts[index],
          );
        },
      ),
    );
  }

  Widget _buildVideoCard(
    String channelName,
    String avatarUrl,
    String timeAgo,
    String title,
    String videoCoverUrl,
    String duration,
    String views,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Slate 800
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Channel Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        channelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.7)),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Video Cover with overlays
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    videoCoverUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                // Play Button overlay
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                // Duration Badge
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Views Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.remove_red_eye_rounded, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          '$views lượt xem',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Video Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                height: 1.35,
              ),
            ),
          ),

          // Action buttons (Pills design)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _buildActionPill(Icons.thumb_up_outlined, 'Thích'),
                const SizedBox(width: 8),
                _buildActionPill(Icons.comment_outlined, 'Bình luận'),
                const SizedBox(width: 8),
                _buildActionPill(Icons.share_outlined, 'Chia sẻ'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPill(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.7), size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
