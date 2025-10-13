class Post {
  final String username;
  final String avatarUrl;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;

  Post({
    required this.username,
    required this.avatarUrl,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
  });
}
