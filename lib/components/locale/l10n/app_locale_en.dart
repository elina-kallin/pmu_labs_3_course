import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get search => 'Search';

  @override
  String get liked => 'oh yes, liked a ';

  @override
  String get disliked => 'nooo((( disliked a ';

  @override
  String get arbEnding => 'Чтобы не забыть про отсутствие запятой';
}
