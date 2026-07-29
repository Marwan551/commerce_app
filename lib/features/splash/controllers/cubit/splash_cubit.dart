import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Timer? _timer;

  void startTimer({required void Function() onSuccess}) {
    _timer = Timer(const Duration(seconds: 3), () {
      onSuccess();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
