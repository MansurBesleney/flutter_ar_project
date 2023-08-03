import 'package:flutter/material.dart';
import 'custom_icons/eczane_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'annotations.dart';

class AnnotationView extends StatelessWidget {
  const AnnotationView({
    Key? key,
    required this.annotation,
  }) : super(key: key);

  final Annotation annotation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Akıllı Şehir kayseri eczane detay sayfasına gidecek
        print("kbb");
        },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withAlpha(150)),
      child: Row(children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: typeFactory(annotation.type),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  annotation.name,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  annotation.distanceKm,
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }

   Widget typeFactory(AnnotationType type) {
    Color color = Colors.red;
    return Icon(
      Eczane.eczane,
      size: 40,
      color: color,
    );
  }
}