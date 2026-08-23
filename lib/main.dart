import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Study',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WaterTrackerPage(),
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final List<DrinkTheme> themes = const [
    DrinkTheme(name: '물', icon: Icons.water_drop, color: Colors.blue, goal: 8),
    DrinkTheme(name: '커피', icon: Icons.coffee, color: Colors.brown, goal: 3),
    DrinkTheme(name: '차', icon: Icons.local_cafe, color: Colors.green, goal: 5),
  ];

  int selectedThemeIndex = 0;
  int glassCount = 0;

  DrinkTheme get selectedTheme => themes[selectedThemeIndex];

  double get progress {
    return (glassCount / selectedTheme.goal).clamp(0.0, 1.0);
  }

  String get statusMessage {
    if (glassCount == 0) {
      return '첫 잔을 기록해보세요.';
    }

    if (glassCount >= selectedTheme.goal) {
      return '오늘 목표를 달성했어요!';
    }

    final int remaining = selectedTheme.goal - glassCount;
    return '$remaining잔 더 마시면 목표 달성입니다.';
  }

  void addGlass() {
    setState(() {
      glassCount++;
    });
  }

  void removeGlass() {
    if (glassCount == 0) {
      return;
    }

    setState(() {
      glassCount--;
    });
  }

  void resetGlass() {
    setState(() {
      glassCount = 0;
    });
  }

  void selectTheme(int index) {
    setState(() {
      selectedThemeIndex = index;
      glassCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DrinkTheme theme = selectedTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 음료 트래커'),
        backgroundColor: theme.color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TrackerHeader(theme: theme),
            const SizedBox(height: 24),
            DrinkCounter(
              count: glassCount,
              goal: theme.goal,
              color: theme.color,
              icon: theme.icon,
            ),
            const SizedBox(height: 18),
            Text(
              statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: theme.color.withValues(alpha: 0.16),
              color: theme.color,
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: addGlass,
                    icon: const Icon(Icons.add),
                    label: const Text('한 잔 추가'),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: removeGlass,
                  icon: const Icon(Icons.remove),
                  tooltip: '한 잔 빼기',
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  onPressed: resetGlass,
                  icon: const Icon(Icons.refresh),
                  tooltip: '초기화',
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              '기록할 음료',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int index = 0; index < themes.length; index++)
                  DrinkChoiceChip(
                    theme: themes[index],
                    isSelected: selectedThemeIndex == index,
                    onSelected: () => selectTheme(index),
                  ),
              ],
            ),
            const SizedBox(height: 36),
            const StudyHint(),
          ],
        ),
      ),
    );
  }
}



class DrinkTheme {
  const DrinkTheme({
    required this.name,
    required this.icon,
    required this.color,
    required this.goal,
  });

  final String name;
  final IconData icon;
  final MaterialColor color;
  final int goal;
}

class TrackerHeader extends StatelessWidget {
  const TrackerHeader({super.key, required this.theme});

  final DrinkTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.color.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.color,
            foregroundColor: Colors.white,
            child: Icon(theme.icon, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '오늘의 ${theme.name} 목표',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${theme.goal}잔을 목표로 기록합니다.',
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrinkCounter extends StatelessWidget {
  const DrinkCounter({
    super.key,
    required this.count,
    required this.goal,
    required this.color,
    required this.icon,
  });

  final int count;
  final int goal;
  final MaterialColor color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: color),
          const SizedBox(height: 12),
          Text(
            '$count / $goal',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: color.shade800,
            ),
          ),
          const Text(
            '잔',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class DrinkChoiceChip extends StatelessWidget {
  const DrinkChoiceChip({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.onSelected,
  });

  final DrinkTheme theme;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected,
      onSelected: (_) => onSelected(),
      avatar: Icon(theme.icon, size: 18, color: theme.color),
      label: Text(theme.name),
      selectedColor: theme.color.shade100,
      side: BorderSide(color: isSelected ? theme.color : Colors.black26),
      labelStyle: TextStyle(
        color: isSelected ? theme.color.shade900 : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class StudyHint extends StatelessWidget {
  const StudyHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: const Text(
        '연습 포인트: setState, getter, 버튼 이벤트, ChoiceChip, 진행률 표시',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
