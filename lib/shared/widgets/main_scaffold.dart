import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F1),
      body: Column(
        children: [
          _FullTopNavBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _onTap,
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _FullTopNavBar extends StatelessWidget {
  const _FullTopNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    Widget tabButton({
      required String label,
      required bool selected,
      required VoidCallback onPressed,
    }) {
      return GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFF66B89F),
      padding: EdgeInsets.only(top: topPadding),
      height: 56 + topPadding,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => context.go('/home'),
              child: const Text(
                "IQRA'",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tabButton(
                  label: 'Home',
                  selected: false,
                  onPressed: () => context.go('/home'),
                ),
                tabButton(
                  label: 'Al-Quran',
                  selected: currentIndex == 0,
                  onPressed: () => onTap(0),
                ),
                tabButton(
                  label: 'Latihan',
                  selected: currentIndex == 1,
                  onPressed: () => onTap(1),
                ),
                tabButton(
                  label: 'Target',
                  selected: currentIndex == 2,
                  onPressed: () => onTap(2),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.go('/home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.home_rounded,
                color: Color(0xFF2F594E), size: 24),
          ),
          const SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => context.go('/dashboard'),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xFF2F594E),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
