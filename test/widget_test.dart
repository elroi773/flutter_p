import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_p/main.dart';

void main() {
  testWidgets('음료 트래커 화면의 기본 요소를 보여준다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter 음료 트래커'), findsOneWidget);
    expect(find.text('오늘의 물 목표'), findsOneWidget);
    expect(find.text('8잔을 목표로 기록합니다.'), findsOneWidget);
    expect(find.text('0 / 8'), findsOneWidget);
    expect(find.text('첫 잔을 기록해보세요.'), findsOneWidget);

    expect(find.text('한 잔 추가'), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.text('물'), findsOneWidget);
    expect(find.text('커피'), findsOneWidget);
    expect(find.text('차'), findsOneWidget);
  });

  testWidgets('추가 버튼을 누르면 마신 잔 수가 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('한 잔 추가'));
    await tester.pump();

    expect(find.text('1 / 8'), findsOneWidget);
    expect(find.text('7잔 더 마시면 목표 달성입니다.'), findsOneWidget);
  });
}
