import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/components/locale/l10n/app_locale.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/home_page/home_page.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_bloc.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_event.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Мемы на каждый день)',
            locale: state.currentLocale,
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: RepositoryProvider<PotterRepository>(
              lazy: true,
              create: (_) => PotterRepository(),
              child: BlocProvider<HomeBlock>(
                  lazy: false,
                  create: (context) =>
                      HomeBlock(context.read<PotterRepository>()),
                  child: const MyHomePage(title: 'Бакальская Елена')),
            ),
          );
        },
      ),
    );
  }
}
