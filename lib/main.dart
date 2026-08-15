import 'package:flutter/material.dart';


//앱의 시작점 Dart 프로그램은 main 함수에서 실행 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //extends Stataless widget == 이 위젯 자체는 상태값이 변하지 않는 위젯이다 
  // 카운트가 바뀐다거나 좋아요 상태가 바뀌는 일이 없음 
  const MyApp({super.key});
  //MyApp 객체를 만들 때 사용하는 생성자 like const MyApp()

  @override
  Widget build(BuildContext context) {
    //build 는 이 위젯이 화면에 어떻게 생길지 정의하는 함수 return 이 있어야 함 
    return MaterialApp(
      //Flutter 앱 전체를 감싸는 최상위 위젯 
      //앱 테마, 첫 화면, 네비게이션 등을 여기서 설정
      debugShowCheckedModeBanner: false,
      //디버그 배너 없애기 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      //앱 전체의 디자인 테마를 설정 하는 부분 테마 데이터 
      home: const StudyPage(),
      //첫 화면 지정 앱을 실행 했을 때 처음 보여줄 화면을 정하는 코드 like index
    );

    //MyApp -> Material App -> StudyPage
  }
}

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

//값이 바뀌는 기능은 StatefulWidget 로 구현 해야 함 
//StudyPage가 사용할 상태 관리 클래스를 연결하는 코드

class _StudyPageState extends State<StudyPage> {
  int count = 0;
  bool isFavorite = false;
//두개의 상태값 선언

//숫자 함수들
  void increaseCount() {
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