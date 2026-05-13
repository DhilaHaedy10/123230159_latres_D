import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/cart_item.dart';
import '../shared.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final storage = StorageService();
    String? u = await storage.getUser();
    if (u != null) setState(() => _items = storage.getCart(u));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text("Keranjang"), backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
      body: _items.isEmpty ? const Center(child: Text("Keranjang kosong")) : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: _items.length,
        itemBuilder: (c, i) => Container( // Const dihapus di sini
          margin: const EdgeInsets.only(bottom: 10),
          decoration: AppTheme.cardDeco,
          child: ListTile(
            leading: ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(_items[i].image, width: 40, fit: BoxFit.cover)),
            title: Text(_items[i].productName),
            subtitle: Text("Qty: ${_items[i].quantity} | Total: \$${_items[i].price * _items[i].quantity}"),
            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () async {
              await _items[i].delete();
              _load();
            }),
          ),
        ),
      ),
    );
  }
}