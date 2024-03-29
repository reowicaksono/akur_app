import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:akur_app/src/shared/model/produk_model.dart';
import 'package:akur_app/src/shared/model/row_produk_model.dart';
import 'package:akur_app/src/shared/services/produk_servies.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService = ProductService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProductBloc() : super(ProductInitial()) {
    on<AddProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        await productService.addProduct(
          id: event.rowProduk.id,
          name: event.rowProduk.name,
          price: event.rowProduk.price,
          quantity: event.rowProduk.quantity,
          description: event.rowProduk.description,
        );
        final List<RowProduk> products = await productService.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {
        emit(ProductAddedFailure(error: e.toString()));
      }
    });

    on<GetAllProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        final List<RowProduk> products = await productService.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {}
    });
    on<DeleteProduct>((event, emit) async {
      try {
        await productService.deteleById(event.uuid);
        emit(ProductLoading());
        final List<RowProduk> products = await productService.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {}
    });
    on<UpdateProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        await productService.addProduct(
          id: event.rowProduk.id,
          name: event.rowProduk.name,
          price: event.rowProduk.price,
          quantity: event.rowProduk.quantity,
          description: event.rowProduk.description,
        );
        final List<RowProduk> products = await productService.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {
        emit(ProductAddedFailure(error: e.toString()));
      }
    });
  }

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is GetAllProducts) {
      try {
        emit(ProductLoading());
        final List<RowProduk> products = await productService.getAllProducts();
        emit(ProductsLoaded(products: products));
      } catch (e) {
        emit(ProductsLoadFailure(error: e.toString()));
      }
    } else if (event is AddProduct) {
      try {
        await productService.addProduct(
          id: event.rowProduk.id,
          name: event.rowProduk.name,
          price: event.rowProduk.price,
          quantity: event.rowProduk.quantity,
          description: event.rowProduk.description,
        );
        yield ProductAddedSuccess();
      } catch (e) {
        yield ProductAddedFailure(error: e.toString());
      }
    } else if (event is UpdateProduct) {
      try {
        await productService.updateProduct(
          id: event.rowProduk.id,
          name: event.rowProduk.name,
          price: event.rowProduk.price,
          quantity: event.rowProduk.quantity,
          description: event.rowProduk.description,
        );
        yield ProductAddedSuccess();
      } catch (e) {
        yield ProductAddedFailure(error: e.toString());
      }
    }
  }
}
