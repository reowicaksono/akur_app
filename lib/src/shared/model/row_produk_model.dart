class RowProduk {
  RowProduk(
    this.name,
    this.price,
    this.quantity,
    this.description,
  );
  final String name;
  final double price;
  final int quantity;
  final String description;

  bool selected = false;
}
