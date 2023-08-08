import 'package:flutter_ar_project/annotation_view.dart';
import 'package:flutter_ar_project/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ar_location_view/ar_location_view.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'models/pharmacy_model.dart';
import 'read_json.dart';
import 'package:uuid/uuid.dart';



List<Annotation> pharms = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 runApp(const MyApp());


  final ReadJson read = ReadJson();

  String Url = 'https://acikveri.kayseri.bel.tr/api/kbb/eczane';
  final pharmacyList = await read.readJson(Url);

  /* // Convert the JSON string to a Map
  Map<String, dynamic> jsonMap = json.decode(jsonData);

  // Extract the list of pharmacies from the "results" key in the JSON data
  List<dynamic> pharmacyListJson = jsonMap['results'];

  // Create a list to hold the Pharmacy objects
  List<Pharmacy> pharmacyList = [];

  // Iterate through the JSON list and convert each entry to a Pharmacy object
  for (var pharmacyJsonData in pharmacyListJson) {
    Pharmacy pharmacy = Pharmacy.fromJson(pharmacyJsonData);
    pharmacyList.add(pharmacy);
  } */

  Position userPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

   pharms =  returnPharms(userPos, pharmacyList);

  for (var pharmacy in pharms){
    print("pharm name: " + pharmacy.name +
          "\npharm pos: " + pharmacy.position.latitude.toString() + "," +pharmacy.position.longitude.toString() +
          "\npharm distance: " + pharmacy.distanceFromUser.toString() +
          "\nazimuth: " + pharmacy.azimuth.toString());
  }
  }


  // Now, you have a List of Pharmacy objects
  // You can use this list to access pharmacy information

  

  //Position userPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
/*   print(userPos.latitude);
  print(userPos.longitude);

  print(pharmacyList.length);
  for (var pharmacy in pharmacyList) {
    var distanceBetween = Geolocator.distanceBetween(userPos.latitude, userPos.longitude, pharmacy.latitude!, pharmacy.longitude!);
    var bearing = Geolocator.bearingBetween(userPos.latitude, userPos.longitude, pharmacy.latitude!, pharmacy.longitude!);
    Position pharmPos = Position(longitude: pharmacy.longitude!, latitude: pharmacy.latitude!, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);

    PharmacyAnnot pharm = PharmacyAnnot(uid: const Uuid().v1() , position: pharmPos, distanceFromUser: distanceBetween, azimuth: bearing, name: pharmacy.name!);
    pharms.add(pharm);
    print("pharm name: " + pharm.name +
          "\npharm pos: " + pharm.position.latitude.toString() + "," +pharm.position.longitude.toString() +
          "\npharm distance: " + pharm.distanceFromUser.toString() +
          "\nazimuth: " + pharm.azimuth.toString());
  } */

class PharmacyAnnot extends ArAnnotation{
  final String name;
  PharmacyAnnot({required super.uid, required super.position, required super.distanceFromUser, required super.azimuth, required this.name});
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Annotation> annotations = [];

@override
Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Akıllı Şehir Kayseri",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          color: Colors.black,
          onPressed: () {
            
          },
          ),
      ),
      body: Stack(
        children: [
          ArLocationWidget(
            annotations: pharms,
            showDebugInfoSensor: false,
            annotationWidth: 180,
            annotationHeight: 60,
            radarPosition: RadarPosition.bottomCenter,
            annotationViewBuilder: (context, annotation) {
              return AnnotationView(
                key: ValueKey(annotation.uid),
                annotation: annotation as Annotation,
              );
            },
            radarWidth: 200,
            scaleWithDistance: false,
            onLocationChange: (Position position) {
              Future.delayed(const Duration(seconds: 5), () {
                annotations = pharms;
                setState(() {});
              });
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.3, // Adjust the value here to change the position
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white.withAlpha(150),
              child: Text(
                "Kamerayı Çevirerek Yakındaki Eczaneleri Görebilirsiniz",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}