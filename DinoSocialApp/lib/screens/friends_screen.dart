import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bạn bè')),
      body: ListView.builder(
        itemCount: 10, // Dummy count
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=${index + 10}',
              ),
            ),
            title: Text('Bạn bè ${index + 1}'),
            subtitle: const Text('2 bạn chung'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Colors.deepOrange,
                    ),
                    overlayColor: MaterialStateProperty.all(
                      Colors.deepOrange.withOpacity(0.1),
                    ),
                  ),
                  child: const Text('Kết bạn'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
