import 'package:flutter/material.dart';
import 'package:DinoSocialApp/data/dummy_data.dart';
import 'package:DinoSocialApp/post/post_create_screen.dart';
import 'package:DinoSocialApp/widgets/post_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:DinoSocialApp/screens/messenger_screen.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate 50 background for premium feed look
      appBar: AppBar(
        title: const Text(
          'Dino blog',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.facebookMessenger,
              color: Color(0xFF1E293B),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessengerScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: controller,
        padding: const EdgeInsets.only(bottom: 96), // Extra bottom padding for floating tab bar
        itemCount: dummyPosts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _CreatePostSection();
          }
          final post = dummyPosts[index - 1];
          return PostCard(post: post);
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
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)), // Slate 200
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9), // Slate 100
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Bạn đang nghĩ gì, Thực?',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24, color: Color(0xFFF1F5F9)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CreatePostButton(
                  icon: Icons.videocam_rounded,
                  color: Colors.redAccent,
                  label: 'Trực tiếp',
                ),
                _CreatePostButton(
                  icon: Icons.photo_library_rounded,
                  color: Colors.green,
                  label: 'Ảnh',
                ),
                _CreatePostButton(
                  icon: Icons.video_call_rounded,
                  color: Colors.purpleAccent,
                  label: 'Họp mặt',
                ),
              ],
            ),
          ],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF475569), // Slate 600
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
