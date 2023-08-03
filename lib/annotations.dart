import 'dart:math';
import 'package:flutter_ar_project/annotation_view.dart';
import 'package:flutter_ar_project/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ar_location_view/ar_location_view.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'models/pharmacy_model.dart';
import 'read_json.dart';
import 'package:uuid/uuid.dart';
import 'package:ar_location_view/ar_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

enum AnnotationType{pharmacy}

class Annotation extends ArAnnotation{
  final String name;
  final AnnotationType type;
  final String distanceKm;
  Annotation({
              required super.uid, required super.position, required super.azimuth,
              required this.name, required this.type, required this.distanceKm
              });
}

List<Annotation> returnPharms(Position userPos, List pharmacyList) {
  
  List<Annotation> nearPharms = [];
  print(pharmacyList.length);
  for (var pharmacy in pharmacyList) {
    var bearing = Geolocator.bearingBetween(userPos.latitude, userPos.longitude, pharmacy.latitude!, pharmacy.longitude!);
    Position pharmPos = Position(
                                longitude: pharmacy.longitude!, latitude: pharmacy.latitude!,
                                timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1,
                                speedAccuracy: 1
                                );

    Annotation pharm = Annotation(
                                  uid: const Uuid().v1() , position: pharmPos, azimuth: bearing, name: pharmacy.name!,
                                  type: AnnotationType.pharmacy, distanceKm: pharmacy.distanceKm
                                  );
    nearPharms.add(pharm);
  }
  return nearPharms;
}

AnnotationType getRandomAnnotation() {
  final types = AnnotationType.values.toList();
  final index = Random.secure().nextInt(types.length);

  return types[index];
}

/* List<Annotation> fakeAnnotation(
  {required Position position, int distance = 1500, int numberMaxPoi = 100}) {
    return List<Annotation>.generate(
      numberMaxPoi,
      (index) {
        return Annotation(
          uid: const Uuid().v1(),
          position: getRandomLocation(
            position.latitude,
            position.longitude,
            distance/100000,
            distance/100000,
          ),
          type: getRandomAnnotation(),
        );
      },
    );
  }

  Position getRandomLocation(double centerLatitude, double centerLongitude,
    double deltaLat, double deltaLon) {
      var lat = centerLatitude;
      var lon = centerLongitude;

      final latDelta = -(deltaLat/2) + Random.secure().nextDouble() * deltaLat;
      final lonDelta = -(deltaLon/2) + Random.secure().nextDouble() * deltaLon;

      lat = lat + latDelta;
      lon = lon + lonDelta;
    
      return Position(
        longitude: lon,
        latitude: lat,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 1,
        heading: 1,
        speed: 1,
        speedAccuracy: 1
        );
    } */

