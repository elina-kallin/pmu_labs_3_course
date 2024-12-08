import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Безымянная соцсеть',
      home: RepositoryProvider<PotterRepository>(
        lazy: true,
        create: (_) => PotterRepository(),
        child: BlocProvider<HomeBlock>(
            lazy: false,
            create: (context) => HomeBlock(context.read<PotterRepository>()),
            child: const MyHomePage(title: 'Бакальская Елена')),
      ),
    );
  }
}
