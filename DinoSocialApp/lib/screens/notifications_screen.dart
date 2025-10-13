import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text('Bạn có thông báo mới ${index + 1}'),
            subtitle: Text('Đây là nội dung thông báo. ${index + 1} giờ trước'),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
