import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/local/shared_pref_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startTimer({
    void Function(bool isAuthenticated)? onFinished,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (isClosed) return;

    final token = SharedPrefHelper().getData(SharedPrefKeys.token);
    final isAuthenticated = token != null;

    onFinished?.call(isAuthenticated);

    if (isAuthenticated) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }
}
