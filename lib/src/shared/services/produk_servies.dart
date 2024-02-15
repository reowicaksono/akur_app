import 'package:akur_app/src/shared/model/row_produk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct({
    required String name,
    required double price,
    required int quantity,
    required String description,
  }) async {
    try {
      await firestore
          .collection('products')
          .add({
            'name': name,
            'price': price,
            'quantity': quantity,
            'description': description,
          })
          // ignore: avoid_print
          .then((value) => print("User Added"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RowProduk>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('products').get();

      final List<RowProduk> products = snapshot.docs
          .map((doc) => RowProduk(
                doc['name'],
                doc['price'],
                doc['quantity'],
                doc['description'],
              ))
          .toList();

      return products;
    } catch (e) {
      throw e.toString();
    }
  }
}
