import 'dart:async';

import 'package:flutter/material.dart';

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
    final data = [
      _CardPostData("Первая из списка карточек ыть",
          imageUrl: "./assets/images/popug1.jpg"),
      _CardPostData("Вторая из списка карточек ыть",
          imageUrl: "./assets/images/popug2.jpg"),
      _CardPostData("Третья из списка каточек ыть",
          imageUrl: "./assets/images/mem3.jpg"),
      _CardPostData("нет, он не кловун", imageUrl: "./assets/images/mem4.jpg"),
    ];
    return Center(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.map((e) => _CardPost.fromData(e, onLike: (title, isLiked) => _showSnackBar(context, title, isLiked),)).toList(),
    )));
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
        duration: const Duration(seconds: 1),
      ));
    });
  }
}
