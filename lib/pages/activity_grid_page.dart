import 'package:flutter/material.dart';
import 'package:video_player_you_tube/widgets/activity_card.dart';

class ActivityGridPage extends StatefulWidget {
  const ActivityGridPage({super.key});

  @override
  State<ActivityGridPage> createState() => _ActivityGridPageState();
}

class _ActivityGridPageState extends State<ActivityGridPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = _demoItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your today activity'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth ~/ 140; // fit cards
            return GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount.clamp(2, 4),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 115 / 102,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = index == selectedIndex;
                return ActivityCard(
                  title: item.title,
                  emoji: item.emoji,
                  progress: item.progress,
                  maxDots: 4,
                  state: item.disabled
                      ? ActivityCardState.disabled
                      : isSelected
                          ? ActivityCardState.selected
                          : ActivityCardState.normal,
                  onTap: () {
                    if (!item.disabled) {
                      setState(() => selectedIndex = index);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<_Item> _demoItems() {
    return const [
      _Item('Physical Activity', '🧘‍♀️', 0, false),
      _Item('Stress &\nEmotional Upswings', '🥶', 3, false),
      _Item('Food &\nBeverages', '🍽️', 1, false),
      _Item('Hormonal\nFactors', '💊', 0, true),
      _Item('Clothing\nChoices', '👚', 0, true),
      _Item('Sleep Environment\n(Night Sweats)', '🛏️', 0, false),
    ];
  }
}

class _Item {
  final String title;
  final String emoji;
  final int progress;
  final bool disabled;
  const _Item(this.title, this.emoji, this.progress, this.disabled);
}