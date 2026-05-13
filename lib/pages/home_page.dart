import 'package:flutter/material.dart';
import '../shared.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'detail_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currIdx = 0;
  String _user = "";

  @override
  void initState() {
    super.initState();
    StorageService().getUser().then((v) => setState(() => _user = v ?? "User"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(_currIdx == 0 ? "Hi, $_user" : "Profile"),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: _currIdx == 0 ? [
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())))
        ] : null,
      ),
      body: _currIdx == 0 ? _buildList() : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIdx,
        onTap: (i) => setState(() => _currIdx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder<List<Product>>(
      future: ApiService().fetchProducts(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: snap.data!.length,
          itemBuilder: (c, i) {
            final p = snap.data![i];
            return Container( // Const dihapus di sini
              margin: const EdgeInsets.only(bottom: 12),
              decoration: AppTheme.cardDeco,
              child: ListTile(
                leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(p.thumbnail, width: 50, height: 50, fit: BoxFit.cover)),
                title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("\$${p.price}", style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(product: p))),
              ),
            );
          },
        );
      },
    );
  }
}