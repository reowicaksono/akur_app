// produk_model.dart
class ProdukModel {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final DateTime createdAt;

  ProdukModel(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.description,
      required this.createdAt});
}
