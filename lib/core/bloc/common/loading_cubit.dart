import 'package:counter/core/bloc/base_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadingCubit extends BaseCubit<bool> {
  LoadingCubit() : super(false);
  void show() => emit(true);
  void hide() => emit(false);
}
