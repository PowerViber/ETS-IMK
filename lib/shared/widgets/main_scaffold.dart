import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

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
      backgroundColor: context.appBackground,
      body: Stack(
        children: [
          Column(
            children: [
              const _CompactTopBar(),
              Expanded(child: navigationShell),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: _FloatingBottomNav(
              currentIndex: navigationShell.currentIndex,
              onTap: _onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactTopBar extends StatelessWidget {
  const _CompactTopBar();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

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
          const Spacer(),
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

class _FloatingBottomNav extends StatefulWidget {
  const _FloatingBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<_FloatingBottomNav> createState() => _FloatingBottomNavState();
}

class _FloatingBottomNavState extends State<_FloatingBottomNav> {
  bool _focused = false;
  String? _activeTooltip;

  void _setFocus(String label, bool value) {
    setState(() {
      _focused = value;
      _activeTooltip = value ? label : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        AnimatedOpacity(
          opacity: _focused ? 1 : 0.78,
          duration: const Duration(milliseconds: 180),
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _focused
                  ? context.appDockSurfaceFocused
                  : context.appDockSurface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: _focused
                    ? context.appDockBorderFocused
                    : context.appDockBorder,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DockIconButton(
                  tooltip: 'Home',
                  icon: Icons.home_rounded,
                  selected: false,
                  onPressed: () => context.go('/home'),
                  onLongPressStart: () => _setFocus('Home', true),
                  onLongPressEnd: () => _setFocus('Home', false),
                ),
                _DockIconButton(
                  tooltip: 'Al-Quran',
                  icon: Icons.menu_book_rounded,
                  selected: widget.currentIndex == 0,
                  onPressed: () => widget.onTap(0),
                  onLongPressStart: () => _setFocus('Al-Quran', true),
                  onLongPressEnd: () => _setFocus('Al-Quran', false),
                ),
                _DockIconButton(
                  tooltip: 'Latihan',
                  icon: Icons.quiz_rounded,
                  selected: widget.currentIndex == 1,
                  onPressed: () => widget.onTap(1),
                  onLongPressStart: () => _setFocus('Latihan', true),
                  onLongPressEnd: () => _setFocus('Latihan', false),
                ),
                _DockIconButton(
                  tooltip: 'Target',
                  icon: Icons.flag_rounded,
                  selected: widget.currentIndex == 2,
                  onPressed: () => widget.onTap(2),
                  onLongPressStart: () => _setFocus('Target', true),
                  onLongPressEnd: () => _setFocus('Target', false),
                ),
              ],
            ),
          ),
        ),
        if (_activeTooltip != null)
          Positioned(
            bottom: 82,
            child: AnimatedOpacity(
              opacity: _focused ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xF7166D56),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _activeTooltip!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DockIconButton extends StatelessWidget {
  const _DockIconButton({
    required this.tooltip,
    required this.icon,
    required this.selected,
    required this.onPressed,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  final String tooltip;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: tooltip,
      button: true,
      child: GestureDetector(
        onTap: onPressed,
        onLongPressStart: (_) => onLongPressStart(),
        onLongPressEnd: (_) => onLongPressEnd(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF166D56) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: selected ? Colors.white : context.appNavIcon,
            size: 23,
          ),
        ),
      ),
    );
  }
}
