import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  String? userName;
  String? userPhone;
  String? userEmail;
  Uint8List? userProfileImage;
  bool serviceActive = false; // Default value is false
  double userBalance = 0.0; // Default balance is 0
  String? userAddressID;

  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userName = prefs.getString('userName');
      userPhone = prefs.getString('userPhone');
      userEmail = prefs.getString('userEmail');
      serviceActive = prefs.getBool('serviceActive') ?? false;
      userBalance = prefs.getDouble('userBalance') ?? 0.0;
      userAddressID = prefs.getString('userAddressID');
      String? base64Image = prefs.getString('userProfileImage');
      if (base64Image != null && base64Image.isNotEmpty) {
        userProfileImage = base64Decode(base64Image);
      }
      notifyListeners();
    } catch (error) {
      print('Error loading user data: $error');
    }
  }

  Future<void> saveUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', userName ?? '');
      await prefs.setString('userPhone', userPhone ?? '');
      await prefs.setString('userEmail', userEmail ?? '');
      await prefs.setBool('serviceActive', serviceActive);
      await prefs.setDouble('userBalance', userBalance);
      await prefs.setString('userAddressID', userAddressID ?? '');
      if (userProfileImage != null) {
        String base64Image = base64Encode(userProfileImage!);
        await prefs.setString('userProfileImage', base64Image);
      }
      notifyListeners();
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  Future<void> updateUserProfileImage(Uint8List image) async {
    try {
      userProfileImage = image;
      await saveUserData();
    } catch (error) {
      print('Error updating user profile image: $error');
    }
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
    await prefs.setString(
        'userAddressBlocknumber', userAddressBlocknumber ?? '');
    await prefs.setString('userAddressBuilding', userAddressBuilding ?? '');
    await prefs.setString('userAddressRoad', userAddressRoad ?? '');
    await prefs.setString('userAddressLandmark', userAddressLandmark ?? '');
    await prefs.setString('userAddressLocation', userAddressLocation ?? '');
    await prefs.setString('userAddressCity', userAddressCity ?? '');
    await prefs.setString('userAddressPin', userAddressPin ?? '');
  }
}
