import 'dart:ui';
import 'package:flutter/material.dart';

/// Shared bottom navigation bar — 4 tabs: Home(0), Search(1), Cart(2), Profile(3)
/// Uses named routes registered in main.dart — no screen imports needed.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavBar({super.key, required this.currentIndex});

  static const _routes = ['/home', '/listing', '/cart', '/profile'];

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      _routes[index],
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1A2E).withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 32, right: 32, bottom: 14, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavItem(
                  icon: Icons.home_filled,
                  isActive: currentIndex == 0,
                  onTap: () => _navigate(context, 0),
                ),
                _NavItem(
                  icon: Icons.search,
                  isActive: currentIndex == 1,
                  onTap: () => _navigate(context, 1),
                ),
                _NavItem(
                  icon: Icons.shopping_cart_outlined,
                  isActive: currentIndex == 2,
                  onTap: () => _navigate(context, 2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  isActive: currentIndex == 3,
                  onTap: () => _navigate(context, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF1A1A2E)
                  : const Color(0xFF94A3B8),
              size: 26,
            ),
            if (isActive) ...[
              const SizedBox(height: 5),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFFE94560),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
