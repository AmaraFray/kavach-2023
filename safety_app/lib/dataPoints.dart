import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:sensors_plus/sensors_plus.dart';
// import 'package:background_location/background_location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'cred.dart' as cred;

void initAccelerometer() {
  print("hello");
  var last = DateTime.now().millisecondsSinceEpoch;

  userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 2500) {
      last = now;
      cred.uploadToServer("Accelerometer: $event");
    }
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

void getPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.locationAlways,
    Permission.locationWhenInUse,
  ].request();
  print(statuses[Permission.location]);
  print(statuses[Permission.locationAlways]);
  print(statuses[Permission.locationWhenInUse]);

  //Get mic permission
  PermissionStatus micPermissionStatus = await Permission.microphone.request();
  if (micPermissionStatus.isGranted) {
    print("mic granted");
  } else {
    print("mic not granted");
  }

  //Get Sensor permission
  PermissionStatus sensorPermissionStatus = await Permission.sensors.request();
  if (sensorPermissionStatus.isGranted) {
    print("sensor granted");
  } else {
    print("sensor not granted");
  }
  //Get camera permission
  PermissionStatus cameraPermissionStatus = await Permission.camera.request();
  if (cameraPermissionStatus.isGranted) {
    print("camera granted");
  } else {
    print("camera not granted");
  }
}

class BackgroundLocation {
  // The channel to be used for communication.
  // This channel is also refrenced inside both iOS and Abdroid classes
  static const MethodChannel _channel =
      MethodChannel('com.almoullim.background_location/methods');

  /// Stop receiving location updates
  static stopLocationService() async {
    return await _channel.invokeMethod('stop_location_service');
  }

  /// Start receiving location updated
  static startLocationService(
      {double distanceFilter = 0.0,
      bool forceAndroidLocationManager = false}) async {
    return await _channel
        .invokeMethod('start_location_service', <String, dynamic>{
      'distance_filter': distanceFilter,
      'force_location_manager': forceAndroidLocationManager
    });
  }

  static setAndroidNotification(
      {String? title, String? message, String? icon}) async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('set_android_notification',
          <String, dynamic>{'title': title, 'message': message, 'icon': icon});
    } else {
      //return Promise.resolve();
    }
  }

  static setAndroidConfiguration(int interval) async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('set_configuration', <String, dynamic>{
        'interval': interval.toString(),
      });
    } else {
      //return Promise.resolve();
    }
  }

  /// Get the current location once.
  Future<Location> getCurrentLocation() async {
    var completer = Completer<Location>();

    var _location = Location();
    await getLocationUpdates((location) {
      _location.latitude = location.latitude;
      _location.longitude = location.longitude;
      _location.accuracy = location.accuracy;
      _location.altitude = location.altitude;
      _location.bearing = location.bearing;
      _location.speed = location.speed;
      _location.time = location.time;
      completer.complete(_location);
    });

    return completer.future;
  }

  /// Register a function to recive location updates as long as the location
  /// service has started
  static getLocationUpdates(Function(Location) location) {
    // add a handler on the channel to recive updates from the native classes
    _channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'location') {
        var locationData = Map.from(methodCall.arguments);
        // Call the user passed function
        location(
          Location(
              latitude: locationData['latitude'],
              longitude: locationData['longitude'],
              altitude: locationData['altitude'],
              accuracy: locationData['accuracy'],
              bearing: locationData['bearing'],
              speed: locationData['speed'],
              time: locationData['time'],
              isMock: locationData['is_mock']),
        );
      }
    });
  }
}

/// about the user current location
class Location {
  double? latitude;
  double? longitude;
  double? altitude;
  double? bearing;
  double? accuracy;
  double? speed;
  double? time;
  bool? isMock;

  Location(
      {@required this.longitude,
      @required this.latitude,
      @required this.altitude,
      @required this.accuracy,
      @required this.bearing,
      @required this.speed,
      @required this.time,
      @required this.isMock});

  toMap() {
    var obj = {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'bearing': bearing,
      'accuracy': accuracy,
      'speed': speed,
      'time': time,
      'is_mock': isMock
    };
    return obj;
  }
}
