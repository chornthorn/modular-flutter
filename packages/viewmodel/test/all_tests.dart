// Test suite runner for the viewmodel package
import 'package:test/test.dart';

import 'viewmodel_status_test.dart' as status_tests;
import 'viewmodel_state_test.dart' as state_tests;
import 'viewmodel_test.dart' as viewmodel_tests;
import 'viewmodel_observer_test.dart' as observer_tests;

void main() {
  group('ViewModel Package Tests', () {
    group('Status Tests', status_tests.main);
    group('UiState Tests', state_tests.main);
    group('ViewModel Tests', viewmodel_tests.main);
    group('Observer Tests', observer_tests.main);
  });
}
