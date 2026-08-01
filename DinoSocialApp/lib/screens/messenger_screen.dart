import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:DinoSocialApp/utils/session_manager.dart';
import 'package:DinoSocialApp/screens/chat_screen.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  List<dynamic> _conversations = [];
  bool _isLoading = true;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _fetchConversations();
    // Start active polling every 4 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 4), (_) => _fetchConversations(silent: true));
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchConversations({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final response = await http.get(
        Uri.parse('${SessionManager.baseUrl}/messages/conversations'),
        headers: SessionManager.getHeaders(),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && mounted) {
          setState(() {
            _conversations = data['data'];
            _isLoading = false;
          });
        }
      } else {
        if (mounted && !silent) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted && !silent) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern soft background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1.0,
        title: const Text(
          'Đoạn chat',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchConversations(silent: false),
        color: Colors.deepOrange,
        child: Column(
          children: [
            // Search Input Container
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // Slate 100
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm trên Messenger',
                    hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ),
            
            // Conversations List
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.deepOrange),
                    )
                  : _conversations.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 100),
                            Center(
                              child: Text(
                                'Chưa có cuộc trò chuyện nào',
                                style: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _conversations.length,
                          itemBuilder: (context, index) {
                            final conv = _conversations[index];
                            final String title = conv['name'] ?? 'Dino Social User';
                            final String? avatar = conv['avatarUrl'];
                            final String lastMsg = conv['lastMessage'] ?? 'Hãy bắt đầu cuộc trò chuyện!';
                            final String timeStr = conv['lastUpdated'] != null
                                ? DateTime.parse(conv['lastUpdated']).toLocal().toString().substring(11, 16)
                                : '';

                            return ListTile(
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: avatar != null
                                    ? NetworkImage(avatar)
                                    : const NetworkImage('https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars-thoughts/user-profile-icon.png'),
                              ),
                              title: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.5,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              subtitle: Text(
                                lastMsg,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 13.5,
                                ),
                              ),
                              trailing: Text(
                                timeStr,
                                style: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 12,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      conversationId: conv['id'],
                                      title: title,
                                      avatarUrl: avatar,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
