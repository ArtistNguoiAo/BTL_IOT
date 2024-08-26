import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'salomon_state.dart';

class SalomonCubit extends Cubit<SalomonState> {
  SalomonCubit() : super(SalomonInitial());

  Future<void> init(int currentIndex) async {
    emit(SalomonLoaded(currentIndex: currentIndex));
  }
}
