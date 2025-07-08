// ignore_for_file: avoid_print

import 'package:viewmodel/viewmodel.dart';

part 'viewmodel_example.freezed.dart';

// Example 1: Simple Counter State with Freezed
@freezed
class CounterUiState extends UiState<CounterUiState> with _$CounterUiState {
  const CounterUiState._();

  const factory CounterUiState({
    required int value,
    @Default(Status.initial) Status status,
    String? message,
    String? errorMessage,
  }) = _CounterUiState;

  @override
  CounterUiState get loading => copyWith(status: Status.loading);
}

// Example 2: Complex User Profile State
@freezed
class UserProfileUiState extends UiState<UserProfileUiState>
    with _$UserProfileUiState {
  const UserProfileUiState._();

  const factory UserProfileUiState({
    String? userName,
    String? email,
    @Default([]) List<String> posts,
    @Default(false) bool isRefreshing,
    @Default(Status.initial) Status status,
    String? message,
    String? errorMessage,
  }) = _UserProfileUiState;

  @override
  UserProfileUiState get loading => copyWith(status: Status.loading);
}

// Counter ViewModel
class CounterViewModel extends ViewModel<CounterUiState> {
  CounterViewModel() : super(const CounterUiState(value: 0));

  @override
  Future<void> onInit() async {
    print('CounterViewModel initialized');
  }

  void increment() {
    state = state.copyWith(
      value: state.value + 1,
      status: Status.success,
      message: 'Incremented to ${state.value + 1}',
    );
  }

  void decrement() {
    state = state.copyWith(
      value: state.value - 1,
      status: Status.success,
      message: 'Decremented to ${state.value - 1}',
    );
  }

  Future<void> reset() async {
    state = state.loading;

    // Simulate async operation
    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(
      value: 0,
      status: Status.success,
      message: 'Counter reset successfully',
    );
  }
}

// User Profile ViewModel
class UserProfileViewModel extends ViewModel<UserProfileUiState> {
  UserProfileViewModel() : super(const UserProfileUiState());

  @override
  Future<void> onInit() async {
    await loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    state = state.loading;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        userName: 'John Doe',
        email: 'john.doe@example.com',
        posts: ['Post 1', 'Post 2', 'Post 3'],
        status: Status.success,
        message: 'Profile loaded successfully',
      );
    } catch (error) {
      state = state.copyWith(
        status: Status.error,
        errorMessage: 'Failed to load profile: $error',
      );
    }
  }

  Future<void> refreshProfile() async {
    state = state.copyWith(isRefreshing: true);

    try {
      // Simulate refresh
      await Future.delayed(const Duration(milliseconds: 800));

      state = state.copyWith(
        posts: [...state.posts, 'New Post ${state.posts.length + 1}'],
        isRefreshing: false,
        status: Status.success,
        message: 'Profile refreshed',
      );
    } catch (error) {
      state = state.copyWith(
        isRefreshing: false,
        status: Status.error,
        errorMessage: 'Failed to refresh: $error',
      );
    }
  }
}

// Providers
final counterViewModelProvider =
    StateNotifierProvider<CounterViewModel, CounterUiState>(
      (ref) => CounterViewModel(),
    );

final userProfileViewModelProvider =
    StateNotifierProvider<UserProfileViewModel, UserProfileUiState>(
      (ref) => UserProfileViewModel(),
    );

void main() {
  // Example usage (this would typically be in a Flutter app)
  print('ViewModel Example with Freezed');
  print('Run "dart pub run build_runner build" to generate Freezed code');
}
