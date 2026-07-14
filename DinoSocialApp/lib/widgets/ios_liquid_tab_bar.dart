import 'package:flutter/material.dart';

class IOSLiquidTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const IOSLiquidTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _item(Icons.home, 0),
        _item(Icons.people, 1),
        _item(Icons.play_circle, 2),
        _item(Icons.notifications, 3),
        _item(Icons.menu, 4),
      ],
    );
  }

  Widget _item(IconData icon, int index) {
    final selected = index == currentIndex;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white.withOpacity(0.22) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 26,
          color: selected ? Colors.white : Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}

class IOSSearchButton extends StatelessWidget {
  final VoidCallback onTap;

  const IOSSearchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.search,
          size: 26,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}
