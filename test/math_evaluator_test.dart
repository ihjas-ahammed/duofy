import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/math_evaluator_service.dart';
import 'dart:math' as math;

void main() {
  group('MathEvaluatorService Tests', () {
    test('Basic Arithmetic', () {
      expect(MathEvaluatorService.tryEvaluate('2 + 3'), 5.0);
      expect(MathEvaluatorService.tryEvaluate('= 10 - 4 * 2'), 2.0);
      expect(MathEvaluatorService.tryEvaluate('(12 + 8) / 4'), 5.0);
      expect(MathEvaluatorService.tryEvaluate('2^3'), 8.0);
    });

    test('Permutations and Combinations', () {
      expect(MathEvaluatorService.tryEvaluate('P(5, 2)'), 20.0);
      expect(MathEvaluatorService.tryEvaluate('C(5, 2)'), 10.0);
      expect(MathEvaluatorService.tryEvaluate('=P(4, 4)'), 24.0);
      expect(MathEvaluatorService.tryEvaluate('=C(6, 3)'), 20.0);
    });

    test('Factorials', () {
      expect(MathEvaluatorService.tryEvaluate('fact(5)'), 120.0);
      expect(MathEvaluatorService.tryEvaluate('5!'), 120.0);
      expect(MathEvaluatorService.tryEvaluate('=fact(0)'), 1.0);
      expect(MathEvaluatorService.tryEvaluate('3! + 2!'), 8.0);
    });

    test('Standard Math Functions and Constants', () {
      expect(MathEvaluatorService.tryEvaluate('sin(pi / 2)'), closeTo(1.0, 1e-6));
      expect(MathEvaluatorService.tryEvaluate('cos(pi)'), closeTo(-1.0, 1e-6));
      expect(MathEvaluatorService.tryEvaluate('sqrt(16)'), 4.0);
      expect(MathEvaluatorService.tryEvaluate('cbrt(27)'), 3.0);
      expect(MathEvaluatorService.tryEvaluate('abs(-42)'), 42.0);
      expect(MathEvaluatorService.tryEvaluate('ln(e)'), closeTo(1.0, 1e-6));
      expect(MathEvaluatorService.tryEvaluate('log(100)'), closeTo(2.0, 1e-6));
    });

    test('Combined Complex Expressions', () {
      expect(
        MathEvaluatorService.tryEvaluate('=fact(5) + P(4, 2) * C(3, 1)'),
        156.0, // 120 + 12 * 3 = 156
      );
    });

    test('Formatting Results', () {
      expect(MathEvaluatorService.formatResult('=2+3'), '5');
      expect(MathEvaluatorService.formatResult('sin(pi/4)'), '0.7071');
    });
  });
}
