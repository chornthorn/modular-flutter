/// A class representing either success [T] or failure [E].
/// Similar to Rust's Result type.
sealed class Result<T, E> {
  const Result();

  /// Creates a success Result
  static Result<T, E> ok<T, E>(T value) => Success<T, E>(value);

  /// Creates an error Result
  static Result<T, E> err<T, E>(E error) => Failure<T, E>(error);

  /// Returns true if this is a success result
  bool isOk();

  /// Returns true if this is an error result
  bool isErr();

  /// Unwraps the success value or throws if this is an error
  T unwrap();

  /// Unwraps the error value or throws if this is a success
  E unwrapErr();

  /// Returns the success value or a provided default
  T unwrapOr(T defaultValue);

  /// Maps a Result<T, E> to Result<U, E> by applying a function to the contained Ok value
  Result<U, E> map<U>(U Function(T) fn);

  /// Maps a Result<T, E> to Result<T, F> by applying a function to the contained Err value
  Result<T, F> mapErr<F>(F Function(E) fn);

  /// Returns the provided default (if Err), or applies a function to the contained value (if Ok)
  U mapOr<U>(U defaultValue, U Function(T) fn);

  /// Returns the result of the provided function when Ok, otherwise returns the Err value
  Result<U, E> flatMap<U>(Result<U, E> Function(T) fn);

  /// Executes the provided callback if the result is Ok
  Result<T, E> ifOk(void Function(T) fn);

  /// Executes the provided callback if the result is Err
  Result<T, E> ifErr(void Function(E) fn);

  /// Pattern match on Result with switch expressions
  R match<R>({
    required R Function(T value) onOk,
    required R Function(E error) onErr,
  });
}

/// Success variant of Result
final class Success<T, E> extends Result<T, E> {
  const Success(this.value) : super();
  final T value;

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  T unwrap() => value;

  @override
  E unwrapErr() {
    throw Exception('Called unwrapErr on an Ok value');
  }

  @override
  T unwrapOr(T defaultValue) => value;

  @override
  Result<U, E> map<U>(U Function(T) fn) => Success<U, E>(fn(value));

  @override
  Result<T, F> mapErr<F>(F Function(E) fn) => Success<T, F>(value);

  @override
  U mapOr<U>(U defaultValue, U Function(T) fn) => fn(value);

  @override
  Result<U, E> flatMap<U>(Result<U, E> Function(T) fn) => fn(value);

  @override
  Result<T, E> ifOk(void Function(T) fn) {
    fn(value);
    return this;
  }

  @override
  Result<T, E> ifErr(void Function(E) fn) => this;

  @override
  R match<R>({
    required R Function(T value) onOk,
    required R Function(E error) onErr,
  }) {
    return onOk(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T, E> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Ok($value)';
}

/// Error variant of Result
final class Failure<T, E> extends Result<T, E> {
  const Failure(this.error) : super();
  final E error;

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;

  @override
  T unwrap() {
    throw Exception('Called unwrap on an Err value: $error');
  }

  @override
  E unwrapErr() => error;

  @override
  T unwrapOr(T defaultValue) => defaultValue;

  @override
  Result<U, E> map<U>(U Function(T) fn) => Failure<U, E>(error);

  @override
  Result<T, F> mapErr<F>(F Function(E) fn) => Failure<T, F>(fn(error));

  @override
  U mapOr<U>(U defaultValue, U Function(T) fn) => defaultValue;

  @override
  Result<U, E> flatMap<U>(Result<U, E> Function(T) fn) => Failure<U, E>(error);

  @override
  Result<T, E> ifOk(void Function(T) fn) => this;

  @override
  Result<T, E> ifErr(void Function(E) fn) {
    fn(error);
    return this;
  }

  @override
  R match<R>({
    required R Function(T value) onOk,
    required R Function(E error) onErr,
  }) {
    return onErr(error);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T, E> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Err($error)';
}

// Rust-like syntax
typedef Ok<T, E> = Success<T, E>;
typedef Err<T, E> = Failure<T, E>;
