import 'package:flutter/material.dart';

// 앱의 시작점입니다. Dart 프로그램은 항상 main 함수에서 실행됩니다.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // StatelessWidget은 이 위젯 안에서 바뀌는 값이 없을 때 사용합니다.
  // 예: 앱의 기본 설정처럼 한 번 정해지면 그대로 쓰는 화면 구조
  const MyApp({super.key});
  // const 생성자는 같은 값의 위젯을 다시 만들 때 성능에 도움이 됩니다.

  @override
  Widget build(BuildContext context) {
    // build는 이 위젯이 화면에 어떻게 보일지 설명하는 함수입니다.
    return MaterialApp(
      // MaterialApp은 앱 전체의 기본 설정을 담당합니다.
      // 테마, 첫 화면, 화면 이동 같은 큰 설정이 여기 들어갑니다.
      debugShowCheckedModeBanner: false,
      // 오른쪽 위 DEBUG 배너를 숨깁니다.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      // 앱 전체의 디자인 분위기와 색상 규칙을 정하는 부분입니다.
      home: const StudyPage(),
      // 앱을 실행했을 때 처음 보여줄 화면입니다.
    );

    // 화면 흐름: MyApp -> MaterialApp -> StudyPage
  }
}

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

// StatefulWidget은 화면 안의 값이 바뀔 수 있을 때 사용합니다.
// StudyPage는 아래의 _StudyPageState 클래스와 연결되어 상태를 관리합니다.

class _StudyPageState extends State<StudyPage> {
  int count = 0;
  bool isFavorite = false;
  // 화면에서 바뀔 값을 변수로 저장합니다.

  void increaseCount() {
    // setState 안에서 값을 바꾸면 Flutter가 화면을 다시 그립니다.
    setState(() {
      count++;
    });
  }

  void decreaseCount() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold는 앱바, 본문, 버튼 같은 기본 화면 뼈대를 제공합니다.
      appBar: AppBar(
        title: const Text(
          'Flutter 공부',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // Column은 children 위젯들을 위에서 아래로 배치합니다.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '오늘의 공부',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade200,
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // Row는 children 위젯들을 왼쪽에서 오른쪽으로 배치합니다.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Flutter 기본 위젯',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        // onPressed에는 버튼을 눌렀을 때 실행할 함수를 넣습니다.
                        onPressed: toggleFavorite,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,

                          color: isFavorite
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    '버튼을 눌러서 상태가 어떻게 변하는지 확인해보세요.',
                  ),

                  const SizedBox(height: 20),

                  Text(
                    '현재 숫자: $count',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: decreaseCount,
                          child: const Text('-1'),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: increaseCount,
                          child: const Text('+1'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '이 코드에서 공부할 것',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const StudyItem(
              icon: Icons.widgets_outlined,
              title: 'StatefulWidget',
              description: '화면의 값이 바뀌는 위젯',
            ),

            const StudyItem(
              icon: Icons.refresh,
              title: 'setState()',
              description: '값이 바뀌었다고 Flutter에게 알려주는 함수',
            ),

            const StudyItem(
              icon: Icons.view_column_outlined,
              title: 'Row / Column',
              description: '위젯을 가로 또는 세로로 배치',
            ),

            const StudyItem(
              icon: Icons.crop_square,
              title: 'Container',
              description: '크기, 여백, 배경색, 테두리 등을 설정',
            ),
          ],
        ),
      ),
    );
  }
}

class StudyItem extends StatelessWidget {
  final IconData icon;
  //final은 한 번 값이 정해지면, 그 뒤에는 다른 값으로 바꿀 수 없게 만드는 키워드
  final String title;
  final String description;

  const StudyItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          Expanded(
            //Expanded는 Row나 Column 안에서 남는 공간을 최대한 차지하게 만드는 위젯
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
