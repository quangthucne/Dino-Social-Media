import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/post_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = dummyPosts[0]; // Use the first user for profile data

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _ProfileHeader(user: user),
                ),
                bottom: const TabBar(
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

  Widget _buildPostsTab(Post user) {
    // Filter posts to show only the user's posts
    final userPosts = dummyPosts
        .where((post) => post.username == user.username)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        return _PostCard(post: userPosts[index]);
      },
    );
  }

  Widget _buildAboutTab(Post user) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới thiệu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text('Làm việc tại Google'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.school),
              title: Text('Đã học tại Đại học Bách khoa Hà Nội'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Sống tại Hà Nội'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Đến từ Hà Nội'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    // Use a set to get unique users, excluding the main profile user
    final friends = dummyPosts.map((post) => post.username).toSet().toList();
    friends.remove(dummyPosts[0].username);

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
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

class _ProfileHeader extends StatelessWidget {
  final Post user;

  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
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
        // Profile Picture
        Positioned(
          top: 150,
          left: 10,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
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
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hello, Quang Thọt',
                style: TextStyle(fontSize: 16, color: Colors.black54),
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
                  onPressed: () {},
                  icon: const Icon(Icons.person_add),
                  label: const Text('Thêm bạn bè'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  label: const Text('Nhắn tin'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.more_horiz),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.timeAgo,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.content),
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(post.imageUrl!),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up, color: Colors.blue, size: 18),
                    const SizedBox(width: 4),
                    Text('${post.likes}'),
                  ],
                ),
                Text('${post.comments} bình luận'),
              ],
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: Icons.thumb_up_alt_outlined,
                  label: 'Thích',
                ),
                _ActionButton(icon: Icons.comment_outlined, label: 'Bình luận'),
                _ActionButton(icon: Icons.share_outlined, label: 'Chia sẻ'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey[600]),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}

class _FriendGridItem extends StatelessWidget {
  final String name;
  final String avatarUrl;

  const _FriendGridItem({required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
