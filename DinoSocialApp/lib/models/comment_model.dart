class Comment {
  final String username;
  final String avatarUrl;
  final String timeAgo;
  final String? text;
  final String? imageUrl;
  final String? stickerUrl;

  Comment({
    required this.username,
    required this.avatarUrl,
    required this.timeAgo,
    this.text,
    this.imageUrl,
    this.stickerUrl,
  });
}
