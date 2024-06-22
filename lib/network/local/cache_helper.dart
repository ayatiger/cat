import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'dart:io';


class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences?.setString(key, value);
    if (value is int) return await sharedPreferences?.setInt(key, value);
    if (value is bool) return await sharedPreferences?.setBool(key, value);
    if (value is Locale) {
      final localeData = <String, String>{
        'languageCode': value.languageCode,
        'countryCode': value.countryCode ?? '',
      };
      return await sharedPreferences?.setString(key, jsonEncode(localeData));
    }
    return await sharedPreferences?.setDouble(key, value);
  }


  static Future<bool> removeData({required String key}) async {
    if (key == 'lang') {
      // Special handling for removing the language preference
      await sharedPreferences?.remove(key);
      return true; // Indicate success
    } else {
      // For other keys, remove as usual
      return await sharedPreferences?.remove(key) ?? false;
    }
  }


  static Future<dynamic> saveFile({
    required String key,
    required File file,
  }) async {
    try {
      // Read the file content as bytes
      List<int> fileBytes = await file.readAsBytes();

      // Convert bytes to base64 String
      String base64String = base64Encode(Uint8List.fromList(fileBytes));

      // Save the base64 String to SharedPreferences
      return await sharedPreferences?.setString(key, base64String);
    } catch (e) {
      // Handle errors
      print("Error saving file: $e");
      return null;
    }
  }

  static File getFileData({required String key}) {
    String? base64String = sharedPreferences?.getString(key);
    if (base64String == null) {
      return File('default_image_path.png'); // Return a default image path or handle it accordingly
    }

    // Decode base64 string to bytes
    Uint8List bytes = base64Decode(base64String);

    // Save the bytes as a file
    File file = File('path_to_save_image.png'); // Provide a path to save the image
    file.writeAsBytesSync(bytes);

    return file;
  }

  static Future<bool> saveCustomData({required String key, required List<Map<String, dynamic>> value}) async {
    try {
      List<String> encodedDataList = value.map((map) => json.encode(map)).toList();
      return await sharedPreferences?.setStringList(key, encodedDataList) ?? false;
    } catch (error) {
      throw Exception('Failed to save data: $error');
    }
  }
  static List<Map<String, dynamic>> getCustomData({required String key}) {
    List<String>? encodedDataList = sharedPreferences?.getStringList(key);
    if (encodedDataList != null) {
      return encodedDataList.map((encodedData) => json.decode(encodedData)).toList().cast<Map<String, dynamic>>();
    }
    return [];
  }


  static Future<bool> saveIntList({required String key, required List<int> value}) async {
    try {
      // Encode the list to JSON
      String jsonList = jsonEncode(value);
      // Save the JSON string
      await sharedPreferences?.setString(key, jsonList);
      return true; // Return true to indicate success
    } catch (e) {
      print('Error saving int list: $e');
      return false; // Return false to indicate failure
    }
  }

  static List<int> getIntList({required String key}) {
    String? jsonList = sharedPreferences?.getString(key);
    if (jsonList != null) {
      // Decode JSON string to list of integers
      List<dynamic> decodedList = jsonDecode(jsonList);
      // Convert dynamic list to list of integers
      List<int> intList = decodedList.cast<int>();
      return intList;
    }
    return []; // Return an empty list if data is not available
  }

  // Method to save a Duration
  static Future<bool> saveDuration({
    required String key,
    required Duration duration,
  }) async {
    // Save the duration as milliseconds
    int millis = duration.inMilliseconds;
    return await sharedPreferences?.setInt(key, millis) ?? false;
  }

  // Method to get a Duration
  static Duration getDuration({
    required String key,
    Duration defaultValue = const Duration(),
  }) {
    // Retrieve the milliseconds and convert back to Duration
    int? millis = sharedPreferences?.getInt(key);
    if (millis != null) {
      return Duration(milliseconds: millis);
    }
    return defaultValue; // Return default value if not found
  }

}