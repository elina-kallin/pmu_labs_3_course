import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_event.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_state.dart';

import '../../components/locale/l10n/app_locale.dart';


class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(Locale defaultLocale) : super(LocaleState(currentLocale: defaultLocale)) {
    on<ChangeLocaleEvent>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    final toChange = AppLocale.supportedLocales
        .firstWhere((e) => e.languageCode != state.currentLocale.languageCode);
    emit(state.copyWith(currentLocale: toChange));
  }
}