class PureFailure implements Exception {
  const PureFailure(
    this.message,
  );

  final String message;
}
