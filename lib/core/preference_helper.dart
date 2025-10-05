import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/login_model.dart';

class SharedPreferenceHelper {
  static const String _keyToken = "token";
  static const String _keyUser = "user";

  /// ---------------- TOKEN METHODS ----------------

  /// Save token
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  /// Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  /// Clear token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  /// ---------------- USER METHODS ----------------

  /// Save user
  static Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_keyUser, userJson);
  }

  /// Get user
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null && userJson.isNotEmpty) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  /// Clear user
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }

  /// ---------------- CLEAR ALL ----------------

  /// Clear all (token + user)
  static Future<void> clearAll() async {
    await clearToken();
    await clearUser();
  }
}