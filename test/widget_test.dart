import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_p/main.dart';

void main() {
  testWidgets('Todo 학습 화면의 기본 요소를 보여준다', (WidgetTester tester) async {
    // MyApp을 테스트 화면에 올리고 첫 프레임을 그립니다.
    await tester.pumpWidget(const MyApp());

    // 상단 제목과 초기 할 일 목록이 정상적으로 보이는지 확인합니다.
    expect(find.text('Flutter 기초 예제'), findsOneWidget);
    expect(find.text('오늘 할 일'), findsOneWidget);
    expect(find.text('완료: 0 / 3'), findsOneWidget);
    expect(find.text('TextField로 글자 입력받기'), findsOneWidget);
    expect(find.text('setState로 화면 다시 그리기'), findsOneWidget);
    expect(find.text('ListView로 목록 보여주기'), findsOneWidget);

    // 입력창, 추가 버튼, 체크박스, 삭제 버튼처럼 조작 가능한 요소를 확인합니다.
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(Checkbox), findsNWidgets(3));
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(3));
  });
}
