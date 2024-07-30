part of 'counter_bloc.dart';

final class CounterState {
  const CounterState({this.counter = 0});

  final int counter;

  CounterState copyWith({int? counter}) =>
      CounterState(counter: counter ?? this.counter);
}
