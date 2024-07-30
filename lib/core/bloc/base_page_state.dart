import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di.dart';
import '../helper/stream/dispose_bag.dart';
import 'base_bloc.dart';
import 'common/loading_cubit.dart';


abstract class BasePageState<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> {
  StackRouter get router => context.router;
  late final ThemeData theme = Theme.of(context);

  late final LoadingCubit loadingCubit = getIt<LoadingCubit>()
    ..router = router
    ..disposeBag = disposeBag;

  late final B bloc = getIt<B>()
    ..router = router
    ..disposeBag = disposeBag
    ..loadingCubit = loadingCubit;

  late final DisposeBag disposeBag = DisposeBag();

  late final TextTheme textTheme = Theme.of(context).textTheme;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  bool get isAppWidget => false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
        BlocProvider(create: (_) => loadingCubit),
      ],
      child: Builder(
        builder: (context) {
          return buildPageListeners(
            child: isAppWidget
                ? buildPage(context)
                : Stack(
                    children: [
                      buildPage(context),
                      BlocBuilder<LoadingCubit, bool>(
                        builder: (context, isLoading) => Visibility(
                          visible: isLoading,
                          child: Container(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            child: buildPageLoading(),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }
      ),
    );
  }

  Widget buildPageListeners({required Widget child}) => child;

  Widget buildPageLoading() => const Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [CircularProgressIndicator()],
        ),
      );

  Widget buildPage(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    disposeBag.dispose();
  }
}



abstract class BaseCubitState<T extends StatefulWidget,
C extends BaseCubit> extends State<T> {
  StackRouter get router => context.router;
  late final ThemeData theme = Theme.of(context);

  late final LoadingCubit loadingCubit = getIt<LoadingCubit>()
    ..router = router
    ..disposeBag = disposeBag;

  late final C cubit = getIt<C>()
    ..router = router
    ..disposeBag = disposeBag
    ..loadingCubit = loadingCubit;

  late final DisposeBag disposeBag = DisposeBag();

  late final TextTheme textTheme = Theme.of(context).textTheme;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  bool get isAppWidget => false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => cubit),
        BlocProvider(create: (_) => loadingCubit),
      ],
      child: BlocListener<LoadingCubit, bool>(
        listener: (context, state) {
          // handleException(state.appExceptionWrapper!);
        },
        child: Builder(
            builder: (context) {
              return buildPageListeners(
                child: isAppWidget
                    ? buildPage(context)
                    : Stack(
                  children: [
                    buildPage(context),
                    BlocBuilder<LoadingCubit, bool>(
                      builder: (context, isLoading) => Visibility(
                        visible: isLoading,
                        child: Container(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          child: buildPageLoading(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget buildPageListeners({required Widget child}) => child;

  Widget buildPageLoading() => const Center(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [CircularProgressIndicator()],
    ),
  );

  Widget buildPage(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    disposeBag.dispose();
  }
}
