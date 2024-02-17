import 'package:akur_app/src/shared/model/row_produk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct({
    required String id,
    required String name,
    required double price,
    required int quantity,
    required String description,
  }) async {
    try {
      await firestore
          .collection('products')
          .doc(id)
          .set({
            'id': id,
            'name': name,
            'price': price,
            'quantity': quantity,
            'description': description,
            'createdAt': DateTime.now(),
            'updatedAt': DateTime.now(),
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
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('products')
          .orderBy('createdAt', descending: true)
          .get();

      final List<RowProduk> products = snapshot.docs
          .map((doc) => RowProduk(
                doc['id'],
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

  Future<void> deteleById(String id) async {
    try {
      await firestore
          .collection('products')
          .doc(id)
          .delete()
          .then((value) => debugPrint("oke sudah dihapus"));
    } catch (e) {
      // Handle error jika diperlukan
      print("Error deleting product: $e");
      throw Exception("Failed to delete product");
    }
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required double price,
    required int quantity,
    required String description,
  }) async {
    try {
      await firestore
          .collection('products')
          .doc(id)
          .update({
            'id': id,
            'name': name,
            'price': price,
            'quantity': quantity,
            'description': description,
            'updatedAt': DateTime.now(),
          })

          // ignore: avoid_print
          .then((value) => print("User Update"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      throw e.toString();
    }
  }
}
