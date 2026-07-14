import 'package:flutter/material.dart';
import 'package:DinoSocialApp/widgets/post_card.dart';
import '../data/dummy_data.dart';
import '../models/post_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _friendRequestSent = false;

  void _toggleFriendRequest() {
    setState(() {
      _friendRequestSent = !_friendRequestSent;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _friendRequestSent
              ? 'Đã gửi yêu cầu kết bạn tới Quang Thọt!'
              : 'Đã hủy yêu cầu kết bạn.',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = dummyPosts[0]; // Use the first user for profile data

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern soft background
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeaderSection(user),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.deepOrange,
                  indicatorWeight: 3.0,
                  labelColor: Colors.deepOrange,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
                  unselectedLabelColor: Color(0xFF64748B),
                  tabs: [
                    Tab(text: 'Bài viết'),
                    Tab(text: 'Giới thiệu'),
                    Tab(text: 'Bạn bè'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildPostsTab(user),
              _buildAboutTab(user),
              _buildFriendsTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Post user) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cover Photo
        Positioned.fill(
          bottom: 250, // Space for profile picture and name
          child: Image.network(
            'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1932&auto=format&fit=crop', // Placeholder
            fit: BoxFit.cover,
          ),
        ),
        // Camera icon over cover photo (bottom-right)
        Positioned(
          bottom: 262,
          right: 12,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tính năng đăng tải ảnh bìa đang phát triển.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
            ),
          ),
        ),
        // Profile Picture with floating camera icon
        Positioned(
          top: 150,
          left: 10,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tính năng thay đổi ảnh đại diện đang phát triển.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9), // Slate 100
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF475569), size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        // User Name and Bio
        Positioned(
          top: 290,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hello, Quang Thọt. Rất vui được kết nối!',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        // Action Buttons
        Positioned(
          top: 350,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _toggleFriendRequest,
                  icon: Icon(_friendRequestSent ? Icons.check_rounded : Icons.person_add_rounded, size: 18),
                  label: Text(_friendRequestSent ? 'Đã gửi yêu cầu' : 'Thêm bạn bè'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _friendRequestSent ? const Color(0xFF475569) : Colors.white,
                    backgroundColor: _friendRequestSent ? const Color(0xFFE2E8F0) : Colors.deepOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tính năng nhắn tin đang được phát triển.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.message_rounded, size: 18),
                  label: const Text('Nhắn tin'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    backgroundColor: const Color(0xFFE2E8F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    backgroundColor: const Color(0xFFE2E8F0),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.more_horiz_rounded),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsTab(Post user) {
    final userPosts = dummyPosts
        .where((post) => post.username == user.username)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0, bottom: 96.0), // Padding below list for tab bar
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        return PostCard(post: userPosts[index]);
      },
    );
  }

  Widget _buildAboutTab(Post user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 96.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Giới thiệu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(Icons.work_rounded, 'Làm việc tại Google'),
          _buildInfoCard(Icons.school_rounded, 'Đã học tại Đại học Bách khoa Hà Nội'),
          _buildInfoCard(Icons.home_rounded, 'Sống tại Hà Nội'),
          _buildInfoCard(Icons.location_on_rounded, 'Đến từ Hà Nội'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrange),
        title: Text(
          text,
          style: const TextStyle(fontSize: 14.5, color: Color(0xFF334155), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    final friends = dummyPosts.map((post) => post.username).toSet().toList();
    friends.remove(dummyPosts[0].username);

    return GridView.builder(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 96.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 3,
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friendName = friends[index];
        final friendAvatar = dummyPosts
            .firstWhere((post) => post.username == friendName)
            .avatarUrl;
        return _FriendGridItem(name: friendName, avatarUrl: friendAvatar);
      },
    );
  }
}

class _FriendGridItem extends StatelessWidget {
  final String name;
  final String avatarUrl;

  const _FriendGridItem({required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1E293B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
