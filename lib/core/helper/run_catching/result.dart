import '../../exception/base/app_exception.dart';

sealed class Result<T> {
  const Result();
}

final class SuccessResult<T> extends Result<T> {
  final T data;

  const SuccessResult(this.data);
}

final class ErrorResult<T> extends Result<T> {
  final AppException exception;

  const ErrorResult(this.exception);
}
