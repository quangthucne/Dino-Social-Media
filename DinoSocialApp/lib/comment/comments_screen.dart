import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:DinoSocialApp/models/post_model.dart';
import 'package:DinoSocialApp/models/comment_model.dart';
import 'package:DinoSocialApp/data/dummy_data.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;
  const CommentsScreen({super.key, required this.post});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late final ValueNotifier<List<Comment>> _commentsNotifier;

  @override
  void initState() {
    super.initState();
    // Khởi tạo danh sách bình luận ban đầu từ mock data
    _commentsNotifier = ValueNotifier<List<Comment>>(List.from(dummyComments));
  }

  @override
  void dispose() {
    _commentsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bình luận của ${widget.post.username}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.thumb_up_alt_outlined),
            onPressed: () {},
          ),
          Center(
            child: Text(
              widget.post.likes.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Comment>>(
              valueListenable: _commentsNotifier,
              builder: (context, comments, child) {
                if (comments.isEmpty) {
                  return const Center(
                    child: Text(
                      'Chưa có bình luận nào. Hãy là người đầu tiên!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return _CommentItem(comment: comment);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _CommentInputField(
            onSendComment: (text, imagePath) {
              final newComment = Comment(
                username: 'Bùi Quang Thực', // Mock user hiện tại
                avatarUrl: 'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
                timeAgo: 'Vừa xong',
                text: text.isNotEmpty ? text : null,
                imageUrl: imagePath,
              );
              _commentsNotifier.value = [..._commentsNotifier.value, newComment];
            },
          ),
        ],
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final Comment comment;
  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(comment.avatarUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[150] ?? const Color(0xFFF1F2F6),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (comment.text != null)
                        Text(
                          comment.text!,
                          style: const TextStyle(fontSize: 14.5),
                        ),
                      if (comment.stickerUrl != null) ...[
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(comment.stickerUrl!, height: 100),
                        ),
                      ],
                      if (comment.imageUrl != null) ...[
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: comment.imageUrl!.startsWith('http')
                              ? Image.network(comment.imageUrl!, height: 160, fit: BoxFit.cover)
                              : Image.file(File(comment.imageUrl!), height: 160, fit: BoxFit.cover),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    comment.timeAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInputField extends StatefulWidget {
  final Function(String text, String? imagePath) onSendComment;
  const _CommentInputField({required this.onSendComment});

  @override
  State<_CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<_CommentInputField> {
  final TextEditingController _commentController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);

  @override
  void dispose() {
    _commentController.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleImageUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

  void _sendComment() {
    final commentText = _commentController.text.trim();
    final imageFile = _imageNotifier.value;

    if (commentText.isNotEmpty || imageFile != null) {
      widget.onSendComment(commentText, imageFile?.path);
      
      // Reset input controllers
      _commentController.clear();
      _imageNotifier.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0 + bottomPadding),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hiển thị xem trước ảnh (image preview) nếu có
          ValueListenableBuilder<File?>(
            valueListenable: _imageNotifier,
            builder: (context, imageFile, child) {
              if (imageFile == null) return const SizedBox.shrink();
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: FileImage(imageFile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () => _imageNotifier.value = null,
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                onPressed: _handleImageUpload,
              ),
              IconButton(
                icon: const Icon(Icons.sticky_note_2_outlined, color: Colors.grey),
                onPressed: () {
                  // Sticker mocked logic or toast can be placed here
                },
              ),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendComment(),
                  decoration: InputDecoration(
                    hintText: 'Viết bình luận...',
                    filled: true,
                    fillColor: const Color(0xFFF1F2F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.deepOrange),
                onPressed: _sendComment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
