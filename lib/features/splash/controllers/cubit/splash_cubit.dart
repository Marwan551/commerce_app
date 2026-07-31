import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Timer? _timer;

  void startTimer({
    void Function()? onAuthenticated,
    void Function()? onUnauthenticated,
  }) {
    _timer = Timer(const Duration(seconds: 3), () {
      if (isClosed) return;

      final token = SharedPrefHelper.getData('token');
      if (token != null) {
        onAuthenticated?.call();
        emit(Authenticated());
      } else {
        onUnauthenticated?.call();
        emit(Unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
