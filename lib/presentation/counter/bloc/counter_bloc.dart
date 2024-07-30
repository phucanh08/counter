import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/bloc/base_bloc.dart';

part 'counter_event.dart';

part 'counter_state.dart';

@injectable
class CounterBloc extends BaseBloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncrementPressed>(_onCounterIncrementPressed);
    on<CounterDecrementPressed>(_onCounterDecrementPressed);
  }


  Future<void> _onCounterIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) async {
    loadingCubit.showLoading();
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(counter: state.counter + 1));
    loadingCubit.hideLoading();

  }

  void _onCounterDecrementPressed(
    CounterDecrementPressed event,
    Emitter<CounterState> emit,
  ) =>
      emit(state.copyWith(counter: state.counter - 1));
}
