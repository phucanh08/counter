import '../../exception/base/app_exception.dart';
import 'result.dart';

Result<O> runCatching<O>({
  required O Function() action,
}) {
  try {
    return SuccessResult(action.call());
  } on AppException catch (e) {
    return ErrorResult(e);
  }
}

Future<Result<O>> runAsyncCatching<O>({
  required Future<O> Function() action,
}) async {
  try {
    final output = await action.call();

    return SuccessResult(output);
  } on AppException catch (e) {
    return ErrorResult(e);
  }
}
