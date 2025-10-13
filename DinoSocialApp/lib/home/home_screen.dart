import 'package:flutter/material.dart';
import 'package:DinoSocialApp/data/dummy_data.dart';
import 'package:DinoSocialApp/models/post_model.dart';
import 'package:DinoSocialApp/post/post_create_screen.dart';
import 'package:DinoSocialApp/comment/comments_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dino blog',

          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 28,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.facebookMessenger,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        controller: controller,
        itemCount: dummyPosts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _CreatePostSection();
          }
          final post = dummyPosts[index - 1];
          return _PostItem(post: post);
        },
      ),
    );
  }
}

class _CreatePostSection extends StatelessWidget {
  const _CreatePostSection();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PostCreateScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Bạn đang nghĩ gì, Thực?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CreatePostButton(
                    icon: Icons.videocam,
                    color: Colors.red,
                    label: 'Trực tiếp',
                  ),
                  _CreatePostButton(
                    icon: Icons.photo_library,
                    color: Colors.green,
                    label: 'Ảnh',
                  ),
                  _CreatePostButton(
                    icon: Icons.video_call,
                    color: Colors.purple,
                    label: 'Phòng họp mặt',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreatePostButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _CreatePostButton({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }
}

class _PostItem extends StatelessWidget {
  final Post post;

  const _PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PostHeader(post: post),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Text(post.content),
            ),
            if (post.imageUrl != null)
              Image.network(
                post.imageUrl!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            _PostStats(post: post),
            const Divider(height: 1, indent: 12, endIndent: 12),
            _PostActions(post: post),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(post.timeAgo, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }
}

class _PostStats extends StatelessWidget {
  final Post post;
  const _PostStats({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.thumb_up, color: Colors.deepOrange, size: 16),
          const SizedBox(width: 4),
          Text('${post.likes}'),
          const Spacer(),
          Text('${post.comments} bình luận'),
        ],
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  final Post post;
  const _PostActions({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionButton(
            icon: Icons.thumb_up_alt_outlined,
            label: 'Thích',
            onTap: () {},
          ),
          _ActionButton(
            icon: Icons.comment_outlined,
            label: 'Bình luận',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentsScreen(post: post),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.share_outlined,
            label: 'Chia sẻ',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey),
        overlayColor: MaterialStateProperty.all(
          Colors.deepOrange.withOpacity(0.1),
        ),
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
