import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserData with ChangeNotifier {
  String? userName;
  String? userPhone;
  String? userEmail;
  bool serviceActive = false; // Default value is false
  double userBalance = 0.0; // Default balance is 0
  String? userAddressID;

  // Function to load user data from SharedPreferences
  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName');
    userPhone = prefs.getString('userPhone');
    userEmail = prefs.getString('userEmail');
    serviceActive = prefs.getBool('serviceActive') ?? false;
    userBalance = prefs.getDouble('userBalance') ?? 0.0;
    userAddressID = prefs.getString('userAddressID');
  }

  // Function to save user data to SharedPreferences
  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName ?? '');
    await prefs.setString('userPhone', userPhone ?? '');
    await prefs.setString('userEmail', userEmail ?? '');
    await prefs.setBool('serviceActive', serviceActive);
    await prefs.setDouble('userBalance', userBalance);
    await prefs.setString('userAddressID', userAddressID ?? '');
  }
}

class VehicleData {
  String? userVehicleID;
  String? userVehicleCompany;
  String? userVehicleModel;
  String? userVehicleType;
  String? userVehicleColor;
  String? userVehicleNumber;

  // Function to save vehicle data to SharedPreferences
  Future<void> saveVehicleData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userVehicleID', userVehicleID ?? '');
    await prefs.setString('userVehicleCompany', userVehicleCompany ?? '');
    await prefs.setString('userVehicleModel', userVehicleModel ?? '');
    await prefs.setString('userVehicleType', userVehicleType ?? '');
    await prefs.setString('userVehicleColor', userVehicleColor ?? '');
    await prefs.setString('userVehicleNumber', userVehicleNumber ?? '');
  }
}

class AddressData {
  String? userAddressID;
  String? userAddressType;
  String? userAddressBlocknumber;
  String? userAddressBuilding;
  String? userAddressRoad;
  String? userAddressLandmark;
  String? userAddressLocation;
  String? userAddressCity;
  String? userAddressPin;

  // Function to save address data to SharedPreferences
  Future<void> saveAddressData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userAddressID', userAddressID ?? '');
    await prefs.setString('userAddressType', userAddressType ?? '');
    await prefs.setString('userAddressBlocknumber', userAddressBlocknumber ?? '');
    await prefs.setString('userAddressBuilding', userAddressBuilding ?? '');
    await prefs.setString('userAddressRoad', userAddressRoad ?? '');
    await prefs.setString('userAddressLandmark', userAddressLandmark ?? '');
    await prefs.setString('userAddressLocation', userAddressLocation ?? '');
    await prefs.setString('userAddressCity', userAddressCity ?? '');
    await prefs.setString('userAddressPin', userAddressPin ?? '');
  }
}
