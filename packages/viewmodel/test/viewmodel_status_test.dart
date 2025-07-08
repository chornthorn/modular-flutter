import 'package:test/test.dart';
import 'package:viewmodel/src/viewmodel_status.dart';

void main() {
  group('Status enum', () {
    test('should have all expected values', () {
      expect(UiStatus.values, hasLength(4));
      expect(UiStatus.values, contains(UiStatus.initial));
      expect(UiStatus.values, contains(UiStatus.loading));
      expect(UiStatus.values, contains(UiStatus.success));
      expect(UiStatus.values, contains(UiStatus.error));
    });

    test('should have correct string representations', () {
      expect(UiStatus.initial.toString(), 'UiStatus.initial');
      expect(UiStatus.loading.toString(), 'UiStatus.loading');
      expect(UiStatus.success.toString(), 'UiStatus.success');
      expect(UiStatus.error.toString(), 'UiStatus.error');
    });

    test('should support equality comparison', () {
      expect(UiStatus.initial == UiStatus.initial, isTrue);
      expect(UiStatus.loading == UiStatus.loading, isTrue);
      expect(UiStatus.success == UiStatus.success, isTrue);
      expect(UiStatus.error == UiStatus.error, isTrue);

      expect(UiStatus.initial == UiStatus.loading, isFalse);
      expect(UiStatus.loading == UiStatus.success, isFalse);
      expect(UiStatus.success == UiStatus.error, isFalse);
      expect(UiStatus.error == UiStatus.initial, isFalse);
    });

    test('should be usable in switch statements', () {
      String getDescription(UiStatus status) {
        switch (status) {
          case UiStatus.initial:
            return 'not started';
          case UiStatus.loading:
            return 'in progress';
          case UiStatus.success:
            return 'completed';
          case UiStatus.error:
            return 'failed';
        }
      }

      expect(getDescription(UiStatus.initial), 'not started');
      expect(getDescription(UiStatus.loading), 'in progress');
      expect(getDescription(UiStatus.success), 'completed');
      expect(getDescription(UiStatus.error), 'failed');
    });
  });
}
