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
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: dummyComments.length,
              itemBuilder: (context, index) {
                final comment = dummyComments[index];
                return _CommentItem(comment: comment);
              },
            ),
          ),
          const Divider(height: 1),
          _CommentInputField(),
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
          CircleAvatar(backgroundImage: NetworkImage(comment.avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (comment.text != null)
                        Text(comment.text!),
                      if (comment.stickerUrl != null)
                        Image.network(comment.stickerUrl!, height: 100),
                      if (comment.imageUrl != null)
                        Image.network(comment.imageUrl!, height: 150),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(comment.timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInputField extends StatefulWidget {
  @override
  __CommentInputFieldState createState() => __CommentInputFieldState();
}

class __CommentInputFieldState extends State<_CommentInputField> {
  File? _imageFile;

  Future<void> _handleImageUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.white,
      child: Column(
        children: [
          if (_imageFile != null)
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                ),
              ],
            ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.camera_alt_outlined), onPressed: _handleImageUpload),
              IconButton(icon: const Icon(Icons.sticky_note_2_outlined), onPressed: () {}),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Viết bình luận...',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.send, color: Colors.deepOrange), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
