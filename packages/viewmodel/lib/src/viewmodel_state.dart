import 'viewmodel_status.dart';

/// Abstract base class for all Ui State using Freezed.
///
/// Concrete state classes should use Freezed annotations and extend this class
/// for automatic generation of immutable classes with copyWith methods.
///
/// Example usage:
/// ```dart
/// @freezed
/// class CounterUiState extends UiState<CounterUiState> with _$CounterUiState {
///   const CounterUiState._();
///
///   const factory CounterUiState({
///     required int value,
///     @Default(UiStatus.initial) UiStatus uiStatus,
///   }) = _CounterUiState;
/// }
/// ```
abstract class UiState<T> {
  /// The current status of the ViewModel.
  UiStatus get uiStatus;

  /// Protected const constructor for Freezed subclasses.
  const UiState();

  /// Returns a copy of this state with loading status.
  ///
  /// This method should be implemented by concrete classes using Freezed's copyWith.
  T get loading;

  /// Returns true if the status is initial.
  bool get isInitial => uiStatus == UiStatus.initial;

  /// Returns true if the status is loading.
  bool get isLoading => uiStatus == UiStatus.loading;

  /// Returns true if the status is success.
  bool get isSuccess => uiStatus == UiStatus.success;

  /// Returns true if the status is error.
  bool get isError => uiStatus == UiStatus.error;
}
