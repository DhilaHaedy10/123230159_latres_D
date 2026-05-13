import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';

class StorageService {
  static const String _sessionKey = 'user_session';
  
  // Pastikan nama box sama dengan yang di-open di main.dart
  Box<CartItem> get _cartBox => Hive.box<CartItem>('cartBox');

  // --- Session Management ---
  Future<void> saveUser(String user) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_sessionKey, user);
  }

  Future<String?> getUser() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_sessionKey);
  }

  Future<void> logout() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_sessionKey);
  }

  // --- Cart Management ---
  Future<void> addToCart(CartItem item) async {
    // Mencari apakah produk sudah ada untuk user tersebut
    final existing = _cartBox.values.where(
      (i) => i.username == item.username && i.productId == item.productId
    );

    if (existing.isNotEmpty) {
      // Jika ada, tambahkan kuantitasnya
      var currentItem = existing.first;
      currentItem.quantity += item.quantity;
      await currentItem.save();
    } else {
      // Jika belum ada, tambah data baru
      await _cartBox.add(item);
    }
  }

  // Perbaikan fungsi getCart: Pastikan return type-nya List<CartItem>
  List<CartItem> getCart(String user) {
    return _cartBox.values.where((item) => item.username == user).toList();
  }
}