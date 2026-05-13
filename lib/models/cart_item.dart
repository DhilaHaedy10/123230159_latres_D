import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0) final String username; // Untuk filter per-user
  @HiveField(1) final int productId;
  @HiveField(2) final String productName;
  @HiveField(3) final double price;
  @HiveField(4) final String image;
  @HiveField(5) int quantity;

  CartItem({
    required this.username, required this.productId, required this.productName,
    required this.price, required this.image, required this.quantity,
  });
}