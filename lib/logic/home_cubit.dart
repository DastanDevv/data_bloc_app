import 'dart:developer';

import 'package:bloc/bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // super(HomeInitialState()); -  самый начальный State
  HomeCubit() : super(HomeInitialState());

  Future<void> parseNumber(String value) async {
    // Функция началь работат он паказывает состояние загрузки
    emit(HomeLoadingState());
    // будет ждать 1 секунд
    await Future.delayed(const Duration(seconds: 1));
    try {
      // String value' перевот на number
      final parcedValue = num.parse(value);
      // после перевода напиши number на consol
      log(parcedValue.toString());
      //  скажи ui что все готово
      emit(HomeSuccessState(parcedValue));
    } catch (e) {
      log(e.toString());
      // Если ошибка сообщи на UI
      emit(HomeErrorState(e.toString()));
    }
  }
}
