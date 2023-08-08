import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/pharmacy_model.dart';

class ReadJson {
  
  Future<List<Pharmacy>>  readJson(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      );
    print(response.body);

    if(response.statusCode == 200)
    {
        var jsonResponse = json.decode(response.body);

        // Extract the list of pharmacies from the "results" key in the JSON data
        print(jsonResponse);

        // Create a list to hold the Pharmacy objects
        List<Pharmacy> pharmacyList = [];

        // Iterate through the JSON list and convert each entry to a Pharmacy object
        for (var pharmacyJsonData in jsonResponse) {
          Pharmacy pharmacy = Pharmacy.fromJson(pharmacyJsonData);
          pharmacyList.add(pharmacy);
        }

        return pharmacyList;
    }
    else
    {
      throw Exception("Eczane bilgileri alınamadı");
    }
  }
}