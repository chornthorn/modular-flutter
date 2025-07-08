/// Represents the different statuses a ViewModel can be in.
///
/// Used to track the lifecycle and operation state of a ViewModel:
/// - [initial]: The ViewModel has been created but hasn't started any operations
/// - [loading]: The ViewModel is currently performing an operation
/// - [success]: The ViewModel has successfully completed an operation
/// - [error]: The ViewModel encountered an error during an operation
enum Status { initial, loading, success, error }
