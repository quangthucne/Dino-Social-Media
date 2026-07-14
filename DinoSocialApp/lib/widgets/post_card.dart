import 'package:flutter/material.dart';
import 'package:DinoSocialApp/models/post_model.dart';
import 'package:DinoSocialApp/comment/comments_screen.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback? onCommentTap;

  const PostCard({
    super.key,
    required this.post,
    this.onCommentTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post.likes;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeCount++;
      } else {
        _likeCount--;
      }
    });
  }

  void _handleCommentTap() {
    if (widget.onCommentTap != null) {
      widget.onCommentTap!();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommentsScreen(post: widget.post),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16.0,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE2E8F0), // Slate 200 border
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar with premium ring
                Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.deepOrange.withOpacity(0.8),
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.post.avatarUrl),
                  ),
                ),
                const SizedBox(width: 12),
                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B), // Slate 800
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            widget.post.timeAgo,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B), // Slate 500
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.public_rounded,
                            size: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Menu Action Button
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: Color(0xFF64748B),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              widget.post.content,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.5,
                color: Color(0xFF334155), // Slate 700
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Post Image Section
          if (widget.post.imageUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  widget.post.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          // Stats Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                // Likes Count
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF2EC), // Soft orange tint
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.deepOrange,
                    size: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '$_likeCount',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569), // Slate 600
                  ),
                ),
                const Spacer(),
                // Comments Count
                GestureDetector(
                  onTap: _handleCommentTap,
                  child: Text(
                    '${widget.post.comments} bình luận',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B), // Slate 500
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 1,
              color: const Color(0xFFF1F5F9), // Slate 100
            ),
          ),

          // Action Section (Pills UI)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Like Button Pill
                _buildPillButton(
                  icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  label: _isLiked ? 'Đã thích' : 'Thích',
                  color: _isLiked ? Colors.white : const Color(0xFF64748B),
                  textColor: _isLiked ? Colors.white : const Color(0xFF475569),
                  backgroundColor: _isLiked ? Colors.deepOrange : const Color(0xFFF8FAFC), // Slate 50 / deepOrange
                  onTap: _toggleLike,
                ),
                // Comment Button Pill
                _buildPillButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Bình luận',
                  color: const Color(0xFF64748B),
                  textColor: const Color(0xFF475569),
                  backgroundColor: const Color(0xFFF8FAFC),
                  onTap: _handleCommentTap,
                ),
                // Share Button Pill
                _buildPillButton(
                  icon: Icons.share_outlined,
                  label: 'Chia sẻ',
                  color: const Color(0xFF64748B),
                  textColor: const Color(0xFF475569),
                  backgroundColor: const Color(0xFFF8FAFC),
                  onTap: () {
                    // Mock Share logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đã sao chép liên kết bài viết!'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
