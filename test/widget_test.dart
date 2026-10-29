import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora/main.dart';

void main() {
  testWidgets('Calculator basic operations and navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('0'), findsWidgets);

    await tester.tap(find.text('7'));
    await tester.pump();
    expect(find.text('7'), findsWidgets);

    await tester.tap(find.text('+'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();

    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('10'), findsWidgets);

    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Información'), findsOneWidget);
    expect(find.text('Hamad El Troudi'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Calculadora'), findsOneWidget);
  });
}
