import 'package:DinoSocialApp/widgets/liquid_glass_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:DinoSocialApp/home/home_screen.dart';
import 'package:DinoSocialApp/screens/friends_screen.dart';
import 'package:DinoSocialApp/screens/video_screen.dart';
import 'package:DinoSocialApp/screens/notifications_screen.dart';
import 'package:DinoSocialApp/screens/menu_screen.dart';
import 'package:DinoSocialApp/widgets/ios_liquid_tab_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late final ScrollController _scrollController;
  late final PageController _pageController;
  final TextEditingController _searchController = TextEditingController();
  
  bool _isBarVisible = true;
  bool _isSearching = false;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _pageController = PageController(initialPage: 0);

    _screens = [
      HomeScreen(controller: _scrollController),
      const FriendsScreen(),
      const VideoScreen(),
      const NotificationsScreen(),
      const MenuScreen(),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Chỉ ẩn/hiện thanh bar khi không ở chế độ tìm kiếm để tránh đổi layout đột ngột
    if (_isSearching) return;
    
    final direction = _scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse && _isBarVisible) {
      setState(() => _isBarVisible = false);
    } else if (direction == ScrollDirection.forward && !_isBarVisible) {
      setState(() => _isBarVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// CONTENT (PageView hỗ trợ kéo trượt)
          PageView(
            controller: _pageController,
            children: _screens,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),

          /// FLOATING iOS TAB BAR + SEARCH UNIFIED
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + safeBottom,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOut,
              offset: _isBarVisible ? Offset.zero : const Offset(0, 1.35),
              child: LiquidGlassRenderer(
                borderRadius: BorderRadius.circular(36),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                    height: 64,
                    child: _isSearching
                        ? _buildSearchField()
                        : _buildTabBarRow(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarRow() {
    return Row(
      children: [
        Expanded(
          child: IOSLiquidTabBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              });
            },
          ),
        ),
        const VerticalDivider(
          color: Colors.white24,
          width: 1,
          indent: 18,
          endIndent: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IOSSearchButton(
            onTap: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 10.0),
          child: Icon(Icons.search, color: Colors.white70),
        ),
        Expanded(
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm trên Dino...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onSubmitted: (query) {
              // Xử lý tìm kiếm thực tế ở đây
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
