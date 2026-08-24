import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changeIndex(int index) => emit(index);

  void navigateToHome() => emit(0);
  void navigateToSearch() => emit(1);
  void navigateToSaved() => emit(2);
  void navigateToCart() => emit(3);
  void navigateToAccount() => emit(4);
}
