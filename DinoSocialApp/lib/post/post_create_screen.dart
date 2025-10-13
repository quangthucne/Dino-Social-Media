import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _textController = TextEditingController();
  File? _imageFile;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo bài viết',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement post creation logic
              Navigator.pop(context);
            },
            child: const Text(
              'Đăng',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              150.0,
            ), // Padding for the sheet
            child: Column(
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bùi Quang Thực',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.public, size: 14, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              'Công khai',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _textController,
                  maxLines: null, // Allows for multiline input
                  decoration: const InputDecoration(
                    hintText: 'Bạn đang nghĩ gì?',
                    border: InputBorder.none,
                  ),
                ),
                if (_imageFile != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: FileImage(_imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          height: 5,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    _AddMediaButton(
                      icon: Icons.photo_library,
                      label: 'Ảnh/video',
                      color: Colors.green,
                      onTap: _handleImageUpload,
                    ),
                    const _AddMediaButton(
                      icon: Icons.person,
                      label: 'Gắn thẻ người khác',
                      color: Colors.blueAccent,
                    ),
                    const _AddMediaButton(
                      icon: Icons.emoji_emotions,
                      color: Colors.yellow,
                      label: 'Cảm xúc/Hoạt động',
                    ),
                    const _AddMediaButton(
                      icon: Icons.location_on,
                      color: Colors.deepOrangeAccent,
                      label: 'Check in',
                    ),
                    const _AddMediaButton(
                      icon: Icons.gif,
                      label: 'GIF',
                      color: Colors.greenAccent,
                    ),
                    const _AddMediaButton(
                      icon: Icons.videocam,
                      label: 'Video trực tiếp',
                      color: Colors.red,
                    ),
                    const _AddMediaButton(
                      icon: Icons.event,
                      label: 'Tổ chức sự kiện',
                      color: Colors.pink,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AddMediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;
  const _AddMediaButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onTap ?? () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          alignment: Alignment.centerLeft,
        ),
        icon: Icon(icon, color: color),
        label: Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ),
    );
  }
}
