import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'viewmodel_state.dart';

/// Abstract base class for all ViewModels using Riverpod's StateNotifier.
///
/// Manages a state object derived from [UiState] and provides a consistent
/// pattern for implementing business logic in a UI-independent way.
/// Concrete ViewModels should extend this class and provide an initial state.
///
/// Example:
/// ```dart
/// class CounterViewModel extends ViewModel<CounterUiState> {
///   CounterViewModel() : super(const CounterUiState(value: 0));
///
///   void increment() {
///     state = state.copy(value: state.value + 1);
///   }
/// }
/// ```
abstract class ViewModel<State extends UiState> extends StateNotifier<State> {
  /// Creates a ViewModel with the given [initialState].
  ///
  /// Automatically calls [onInit] during initialization to allow
  /// subclasses to perform startup tasks like loading data.
  ViewModel(super.initialState) : super() {
    onInit();
  }

  /// The current state of the ViewModel.
  ///
  /// This is a shortcut for [state] to make it easier to access the state
  /// in the ViewModel.
  State get uiState => state;

  /// Initialize the ViewModel.
  ///
  /// This method is called when the ViewModel is created.
  /// Override this method to load initial data or set up resources.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Future<void> onInit() async {
  ///   state = state.loading;
  ///   final data = await repository.fetchData();
  ///   state = state.success(data);
  /// }
  /// ```
  Future<void> onInit() async {}
}
