import 'package:flutter/material.dart';

sealed class LanguageState {
  final Locale locale;
  const LanguageState(this.locale);
}

final class LanguageInitial extends LanguageState {
  const LanguageInitial(super.locale);
}

final class LanguageChanging extends LanguageState {
  const LanguageChanging(super.locale);
}

final class LanguageChanged extends LanguageState {
  const LanguageChanged(super.locale);
}
