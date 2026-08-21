import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;

  // Login
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = User(
        id: '1',
        name: 'User Name',
        email: email,
        phone: '1234567890',
        userType: 'passenger',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        isActive: true,
      );
      _isLoggedIn = true;
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  // Register
  Future<void> register(String name, String email, String phone, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement actual registration logic
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = User(
        id: '1',
        name: name,
        email: email,
        phone: phone,
        userType: 'passenger',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: false,
        isActive: true,
      );
      _isLoggedIn = true;
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    _error = null;
    notifyListeners();
  }

  // Clear Error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
