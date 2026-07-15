// Smoke tests for self-contained widgets (no Firebase / plugin dependencies).
// The old template "counter" test pumped the full app, which needs Firebase
// initialization, and had been failing since the app outgrew the template.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flow/widgets/duo_button.dart';

void main() {
  testWidgets('DuoButton renders its label and fires onPressed', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: DuoButton(
              text: 'Continue',
              color: Colors.green,
              shadowColor: Colors.greenAccent,
              onPressed: () => taps++,
            ),
          ),
        ),
      ),
    );

    expect(find.text('CONTINUE'), findsOneWidget);

    await tester.tap(find.text('CONTINUE'));
    await tester.pump(const Duration(milliseconds: 150));
    expect(taps, 1);
  });
}
