import 'package:flutter_test/flutter_test.dart';
import 'package:flow/services/python_runner_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PythonRunnerService Tests', () {
    test('runCode returns PythonExecutionResult structure', () async {
      final res = await PythonRunnerService.instance.runCode('print(2 + 2)');
      expect(res, isNotNull);
      expect(res.duration, isNotNull);
    });

    test('runCode handles user input() calls gracefully', () async {
      final code = 'name = input("Name: ")\nprint(f"Hello {name}")';
      final res = await PythonRunnerService.instance.runCode(code, inputs: ['Bob']);
      expect(res, isNotNull);
      expect(res.duration, isNotNull);
    });

    test('runCode processes syntax checking without throwing', () async {
      final res = await PythonRunnerService.instance.runCode('def invalid_syntax(');
      expect(res, isNotNull);
    });
  });
}
