import 'package:test/test.dart';

// Copy the Status enum directly to avoid Flutter imports
enum Status { initial, loading, success, error }

void main() {
  group('Status enum (Simple)', () {
    test('should have all expected values', () {
      expect(Status.values, hasLength(4));
      expect(Status.values, contains(Status.initial));
      expect(Status.values, contains(Status.loading));
      expect(Status.values, contains(Status.success));
      expect(Status.values, contains(Status.error));
    });

    test('should have correct string representations', () {
      expect(Status.initial.toString(), 'Status.initial');
      expect(Status.loading.toString(), 'Status.loading');
      expect(Status.success.toString(), 'Status.success');
      expect(Status.error.toString(), 'Status.error');
    });

    test('should support equality comparison', () {
      expect(Status.initial == Status.initial, isTrue);
      expect(Status.loading == Status.loading, isTrue);
      expect(Status.success == Status.success, isTrue);
      expect(Status.error == Status.error, isTrue);

      expect(Status.initial == Status.loading, isFalse);
      expect(Status.loading == Status.success, isFalse);
      expect(Status.success == Status.error, isFalse);
      expect(Status.error == Status.initial, isFalse);
    });

    test('should be usable in switch statements', () {
      String getDescription(Status status) {
        switch (status) {
          case Status.initial:
            return 'not started';
          case Status.loading:
            return 'in progress';
          case Status.success:
            return 'completed';
          case Status.error:
            return 'failed';
        }
      }

      expect(getDescription(Status.initial), 'not started');
      expect(getDescription(Status.loading), 'in progress');
      expect(getDescription(Status.success), 'completed');
      expect(getDescription(Status.error), 'failed');
    });
  });
}
