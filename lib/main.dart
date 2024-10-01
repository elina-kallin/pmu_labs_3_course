import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Безымянная соцсеть',
      home: MyHomePage(title: 'Бакальская Елена'),
    );
  }
}

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
      body: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardPostData("Первая из списка карточек ыть", imageUrl: "./assets/images/popug.jpg"),
      _CardPostData("Вторая из списка карточек ыть", imageUrl: "./assets/images/popug.jpg"),
      _CardPostData("Третья из списка каточек ыть", imageUrl: "./assets/images/popug.jpg"),
    ];
    return Center(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.map((e) => _CardPost.fromData(e)).toList(),
        //           _CardPost('jfbjdf'),
        //           _CardPost('fdg'),
        //           _CardPost('sfgsf'),

    )));
  }
}

class _CardPost extends StatelessWidget {
  final String description;
  final String? imageUrl;

  const _CardPost(this.description, {this.imageUrl});

  factory _CardPost.fromData(_CardPostData data) =>
      _CardPost(data.description, imageUrl: data.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal,
        border: Border.all(
          color: const Color.fromARGB(255, 64, 46, 9),
          width: 0.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              0.0,
              5.0,
            ),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          // IMAGE ROW
          const SizedBox(height: 10),
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imageUrl!, height: 150, width: double.infinity, fit: BoxFit.cover),
            ),

          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.favorite, color: Colors.pink),
                Icon(Icons.comment, color: Colors.white),
                Icon(Icons.share, color: Color.fromARGB(255, 15, 11, 90)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CardPostData extends StatelessWidget {
  final String description;
  final String? imageUrl;

  const _CardPostData(this.description, {this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
