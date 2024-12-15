import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/components/debounce.dart';
import 'package:pmu_labs/components/extentions/context_x.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/common/svg_objects.dart';
import 'package:pmu_labs/presentation/details_page/details_page.dart';
import 'package:pmu_labs/presentation/home_page/bloc/bloc.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_bloc.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_event.dart';
import 'package:pmu_labs/presentation/locale_bloc/locale_state.dart';

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
  final scrollController = ScrollController();

  @override
  void initState() {
    SvgObjects.init();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBlock>().add(const HomeLoadDataEvent());
    });

    scrollController.addListener(_onNextPageListener);

    super.initState();
  }

  void _onNextPageListener() {
    final bloc = context.read<HomeBlock>();
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 10 &&
        !bloc.state.isPaginationLoading) {
      bloc.add(HomeLoadDataEvent(
        search: searchController.text,
        nextPage: (bloc.state.data?.nextPage),
      ));
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    placeholder: context.locale.search,
                    onChanged: (search) {
                      Debounce.run(
                          () => context.read<HomeBlock>().add(HomeLoadDataEvent(search: search)));
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
                child: SizedBox.square(
                  dimension: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: BlocBuilder<LocaleBloc, LocaleState>(
                        builder: (context, state) {
                          return state.currentLocale.languageCode == 'ru'
                              ? const SvgRu()
                              : const SvgUk();
                        },
                      ),
                  ),

                ),
              )
            ],
          ),
          BlocBuilder<HomeBlock, HomeState>(
              builder: (context, state) => state.error != null
                  ? Text(state.error ?? '')
                  : state.isLoading
                      ? const CircularProgressIndicator()
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: state.data?.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final data = state.data?.data?[index];
                                return data != null
                                    ? _CardPost.fromData(
                                        data,
                                        onLike: (title, isLiked) =>
                                            _showSnackBar(context, title, isLiked),
                                        onTap: () => _navToDetails(context, data),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          ),
                        )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 50,
                child: BlocBuilder<HomeBlock, HomeState>(
                  builder: (context, state) => state.isPaginationLoading
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() {
    context.read<HomeBlock>().add(HomeLoadDataEvent(search: searchController.text));
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
          '${isLiked ? context.locale.liked : context.locale.disliked} $title',
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
