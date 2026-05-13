import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _url = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body)['products'];
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Gagal mengambil data produk');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}