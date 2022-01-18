import 'package:boilerplate/features/boilerplate_app/data/models/photo_model.dart';
import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  final Photo? photo;
  const Tiles({Key? key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: SizedBox(
            child: Image.network(
          photo!.url,
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
