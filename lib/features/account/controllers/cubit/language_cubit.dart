import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale) : super(LanguageInitial(initialLocale));

  Future<void> changeLanguage(Locale newLocale, Future<void> Function(Locale) setLocale) async {
    if (state.locale == newLocale) return;

    emit(LanguageChanging(state.locale));

    await Future.delayed(const Duration(milliseconds: 500));

    await setLocale(newLocale);
    
    emit(LanguageChanged(newLocale));
  }
}
