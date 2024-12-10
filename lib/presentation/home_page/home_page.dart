import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/components/debounce.dart';
import 'package:pmu_labs/data/repositories/mock_repository.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:flutter/material.dart';
import 'package:pmu_labs/main.dart';
import 'package:pmu_labs/presentation/details_page/details_page.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';

part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final searchController = TextEditingController();
  final repo = PotterRepository();
  late Future<List<CardPostData>?> data;

  @override
  void initState() {
    // data = repo.loadData(); // Подгрузка начальных данных
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBlock>().add(const HomeLoadDataEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: (search) {
                Debounce.run(() => context.read<HomeBlock>().add(HomeLoadDataEvent(search: search)));
              },
            ),
          ),

          //     Expanded(
          //       child: Center(
          //         child: FutureBuilder<List<CardPostData>?>(
          //           future: data,
          //           builder: (context, snapshot) => SingleChildScrollView(
          //             child: snapshot.hasData
          //                 ? Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: snapshot.data?.map((data) {
          //                 return _CardPost.fromData(
          //                   data,
          //                   onLike: (title, isLiked) =>
          //                       _showSnackBar(context, title, isLiked),
          //                   onTap: () => _navToDetails(context, data),
          //                 );
          //               }).toList() ??
          //                   [],
          //             )
          //                 : const CircularProgressIndicator(),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          BlocBuilder<HomeBlock, HomeState>(
              builder: (context, state) => state.isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.data?[index];
                            return data != null
                                ? _CardPost.fromData(
                                    data,
                                    onLike: (title, isLiked) => _showSnackBar(context, title, isLiked),
                                    onTap: () => _navToDetails(context, data),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ),
                    )
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() {
    context
        .read<HomeBlock>()
        .add(HomeLoadDataEvent(search: searchController.text));
    return Future.value(null);
  }

  void _navToDetails(BuildContext context, CardPostData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${isLiked ? 'ОГО спс что лайкнул мем' : 'Ну блин убрали лайк с мема '} $title',
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 2),
      ));
    });
  }
}
