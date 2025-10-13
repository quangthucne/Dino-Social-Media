import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:DinoSocialApp/home/home_screen.dart';
import 'package:DinoSocialApp/screens/friends_screen.dart';
import 'package:DinoSocialApp/screens/video_screen.dart';
import 'package:DinoSocialApp/screens/notifications_screen.dart';
import 'package:DinoSocialApp/screens/menu_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late final ScrollController _scrollController;
  bool _isBottomBarVisible = true;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScroll);
    _widgetOptions = <Widget>[
      HomeScreen(controller: _scrollController),
      const FriendsScreen(),
      const VideoScreen(),
      const NotificationsScreen(),
      const MenuScreen(),
    ];
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listenToScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _listenToScroll() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (_isBottomBarVisible) {
        setState(() => _isBottomBarVisible = false);
      }
    } else if (direction == ScrollDirection.forward) {
      if (!_isBottomBarVisible) {
        setState(() => _isBottomBarVisible = true);
      }
    }
  }

  void _onItemTapped(int index) {
    if (index == 0 && _selectedIndex == 0) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isBottomBarVisible
            ? kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom
            : 0,
        child: Wrap(
          children: [
            BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Bạn bè',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ondemand_video),
                  label: 'Video',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Thông báo',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey[700],
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
            ),
          ],
        ),
      ),
    );
  }
}
