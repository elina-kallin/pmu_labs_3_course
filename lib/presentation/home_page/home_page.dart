import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pmu_labs/data/repositories/mock_repository.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/details_page/details_page.dart';

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

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = PotterRepository().loadData();
    return Center(
      child: FutureBuilder<List<CardPostData>?>(
        future: data,
        builder: (context, snapshot) => SingleChildScrollView(
          child: snapshot.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data?.map((data) {
                        return _CardPost.fromData(
                          data,
                          onLike: (String title, bool isLiked) =>
                              _showSnackBar(context, title, isLiked),
                          onTap: () => _navToDetails(context, data),
                        );
                      }).toList() ??
                      [],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
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
