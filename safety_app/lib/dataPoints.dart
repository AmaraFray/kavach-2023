import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:background_location/background_location.dart';
import 'cred.dart' as cred;

void initAccelerometer() {
  print("hello");

  accelerometerEvents.listen((AccelerometerEvent event) {
    print(event);
  });
}

void locationUpdates() {
  BackgroundLocation.startLocationService();

  String latitude = "";
  String longitude = "";
  String accuracy = "";
  String altitude = "";
  String bearing = "";
  String speed = "";
  String time = "";

  BackgroundLocation.getLocationUpdates((location) {
    latitude = location.latitude.toString();
    longitude = location.longitude.toString();
    accuracy = location.accuracy.toString();
    altitude = location.altitude.toString();
    bearing = location.bearing.toString();
    speed = location.speed.toString();
    time =
        DateTime.fromMillisecondsSinceEpoch(location.time!.toInt()).toString();
    String message =
        "Latitude: $latitude, Longitude: $longitude, Accuracy: $accuracy, Altitude: $altitude, Bearing: $bearing, Speed: $speed, Time: $time";
    cred.uploadToServer(message);
  });
}

void stopLocationService_() {
  BackgroundLocation.stopLocationService();
}
