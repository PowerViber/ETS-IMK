import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Removed the built-in appBar completely to use a custom single bar.
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
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FullTopNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Al-Quran', 'Latihan', 'Target'];
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      // The navbar background should be the mosque color (accentGreen)
      color: AppTheme.accentGreen,
      padding: EdgeInsets.only(top: topPadding),
      // 60 height + status bar padding
      height: 65 + topPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Logo (Mosque - White)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.mosque, color: Colors.white, size: 28),
              onPressed: () {
                context.push('/dashboard');
              },
            ),
          ),
          
          // Center Navigation Tabs
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tabs.length, (index) {
                final isSelected = currentIndex == index;
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12), // offset push down
                        Text(
                          tabs[index],
                          style: TextStyle(
                            // Unselected is slightly faded white, selected is pure white + bold
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 3,
                          width: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          // Right Profile Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
              onPressed: () {
                // Open user profile
              },
            ),
          ),
        ],
      ),
    );
  }
}
