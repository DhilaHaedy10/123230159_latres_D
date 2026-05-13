import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../services/storage_service.dart';
import '../shared.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(widget.product.thumbnail, height: 300, width: double.infinity, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text("\$${widget.product.price}", style: const TextStyle(fontSize: 20, color: AppTheme.accent, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(widget.product.description, style: const TextStyle(color: Colors.grey, height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDeco,
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => setState(() => _qty > 1 ? _qty-- : null)),
                Text("$_qty", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => setState(() => _qty < widget.product.stock ? _qty++ : null)),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
                  onPressed: () async {
                    String? u = await StorageService().getUser();
                    if (u != null) {
                      await StorageService().addToCart(CartItem(username: u, productId: widget.product.id, productName: widget.product.title, price: widget.product.price, image: widget.product.thumbnail, quantity: _qty));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ditambahkan ke keranjang!')));
                    }
                  },
                  child: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}