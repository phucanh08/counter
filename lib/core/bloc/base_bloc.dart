import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../exception/base/app_exception.dart';
import '../exception/base/app_exception_wrapper.dart';
import '../helper/stream/dispose_bag.dart';
import '../utils/log_utils.dart';
import 'common/loading_cubit.dart';
import 'event_transformer_mixin.dart';

abstract class BaseCubit<S> extends Cubit<S> with _BLocBase<S> {
  BaseCubit(super.initialState);
}

abstract class BaseBloc<E, S> extends Bloc<E, S> with _BLocBase<S>, EventTransformerMixin  {
  BaseBloc(super.initialState);

  @override
  void add(E event) {
    if (!isClosed) {
      super.add(event);
    } else {
      Log.e('Cannot add new event $event because $runtimeType was closed');
    }
  }
}

mixin _BLocBase<S> on BlocBase<S> {
  late final StackRouter router;
  late final DisposeBag disposeBag;
  late final LoadingCubit _loadingCubit;

  set loadingCubit(LoadingCubit loadingCubit) {
    _loadingCubit = loadingCubit;
  }

  LoadingCubit get loadingCubit =>
      this is LoadingCubit ? this as LoadingCubit : _loadingCubit;

  Future<void> addException(AppExceptionWrapper appExceptionWrapper) async {
    // loadingCubit.add(ExceptionEmitted(
    //   appExceptionWrapper: appExceptionWrapper,
    // ));

    return appExceptionWrapper.exceptionCompleter?.future;
  }

  void showLoading() => loadingCubit.show();

  void hideLoading() => loadingCubit.hide();

  Future<void> runBlocCatching({
    required Future<void> Function() action,
    Future<void> Function()? doOnRetry,
    Future<void> Function(AppException)? doOnError,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    Future<void> Function()? doOnEventCompleted,
    bool handleLoading = true,
    bool handleError = true,
    bool handleRetry = true,
    bool Function(AppException)? forceHandleError,
    String? overrideErrorMessage,
  }) async {
    Completer<void>? recursion;
    try {
      await doOnSubscribe?.call();
      if (handleLoading) {
        showLoading();
      }

      await action.call();

      if (handleLoading) {
        hideLoading();
      }
      await doOnSuccessOrError?.call();
    } on AppException catch (e) {
      if (handleLoading) {
        hideLoading();
      }
      await doOnSuccessOrError?.call();
      await doOnError?.call(e);

      if (handleError || (forceHandleError?.call(e) ?? _forceHandleError(e))) {
        await addException(AppExceptionWrapper(
          appException: e,
          doOnRetry: doOnRetry ??
              (handleRetry
                  ? () async {
                      recursion = Completer();
                      await runBlocCatching(
                        action: action,
                        doOnEventCompleted: doOnEventCompleted,
                        doOnSubscribe: doOnSubscribe,
                        doOnSuccessOrError: doOnSuccessOrError,
                        doOnError: doOnError,
                        doOnRetry: doOnRetry,
                        forceHandleError: forceHandleError,
                        handleError: handleError,
                        handleLoading: handleLoading,
                        handleRetry: handleRetry,
                        overrideErrorMessage: overrideErrorMessage,
                      );
                      recursion?.complete();
                    }
                  : null),
          exceptionCompleter: Completer<void>(),
          overrideMessage: overrideErrorMessage,
        ));
      }
    } finally {
      await recursion?.future;
      await doOnEventCompleted?.call();
    }
  }

  bool _forceHandleError(AppException appException) {
    return false;
    // return appException is RemoteException &&
    //     appException.kind == RemoteExceptionKind.refreshTokenFailed;
  }
}
