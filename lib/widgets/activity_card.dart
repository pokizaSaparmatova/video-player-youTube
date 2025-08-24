import 'package:flutter/material.dart';

enum ActivityCardState {
  normal,
  selected,
  disabled,
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String emoji;
  final int progress; // 0..4
  final int maxDots;
  final ActivityCardState state;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.title,
    required this.emoji,
    this.progress = 0,
    this.maxDots = 4,
    this.state = ActivityCardState.normal,
    this.onTap,
  });

  bool get _isDisabled => state == ActivityCardState.disabled;
  bool get _isSelected => state == ActivityCardState.selected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color baseBg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF5F5F7);
    final Color selectedBg = colors.primaryContainer.withOpacity(0.85);
    final Color disabledOverlay = Colors.black.withOpacity(0.04);

    Color bgColor = baseBg;
    if (_isSelected) bgColor = selectedBg;

    final Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 115,
      height: 102,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildInner(colors),
    );

    Widget result = _isDisabled
        ? ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
            child: Stack(
              fit: StackFit.expand,
              children: [
                content,
                Container(
                  decoration: BoxDecoration(
                    color: disabledOverlay,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          )
        : content;

    if (_isSelected) {
      result = Stack(
        children: [
          result,
          Positioned(
            top: 8,
            left: 8,
            child: _buildCheckBadge(colors),
          ),
        ],
      );
    }

    return IgnorePointer(
      ignoring: _isDisabled,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: result,
      ),
    );
  }

  Widget _buildInner(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 28),
        ),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        Row(
          children: List.generate(maxDots, (index) {
            final bool filled = index < progress;
            return Padding(
              padding: EdgeInsets.only(right: index == maxDots - 1 ? 0 : 4),
              child: _Dot(
                color: filled ? colors.primary : Colors.grey.shade300,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCheckBadge(ColorScheme colors) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: colors.onPrimary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        Icons.check_circle,
        color: colors.primary,
        size: 28,
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}