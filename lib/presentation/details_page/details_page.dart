import 'package:flutter/material.dart';
import 'package:pmu_labs/domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardPostData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),

            child: Image.network(
              data.imageUrl ?? '',
              fit: BoxFit.cover,
              width: 340,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              data.description ?? "описание съел енот",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
