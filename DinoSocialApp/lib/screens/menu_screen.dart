import 'package:flutter/material.dart';
import 'package:DinoSocialApp/profile/profile_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://res.cloudinary.com/dbrftgkrp/image/upload/v1757524896/koxbs3ivp9aydpvxawgx.jpg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Bùi Quang Thực",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white38,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildListDelegate([
                _MenuItem(
                  icon: Icons.person,
                  label: 'Trang cá nhân',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                ),
                _MenuItem(icon: Icons.group, label: 'Nhóm', onTap: () {}),
                _MenuItem(
                  icon: Icons.store,
                  label: 'Marketplace',
                  onTap: () {},
                ),
                _MenuItem(icon: Icons.event, label: 'Sự kiện', onTap: () {}),
                _MenuItem(icon: Icons.memory, label: 'Kỷ niệm', onTap: () {}),
                _MenuItem(icon: Icons.bookmark, label: 'Đã lưu', onTap: () {}),
                _MenuItem(icon: Icons.flag, label: 'Trang', onTap: () {}),
                _MenuItem(icon: Icons.settings, label: 'Cài đặt', onTap: () {}),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.deepOrange,
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.grey),
                    overlayColor: MaterialStateProperty.all(
                      Colors.deepOrange.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 8.0),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
