part of 'produk_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final RowProduk rowProduk;

  const AddProduct({required this.rowProduk, required String description});

  @override
  List<Object> get props => [rowProduk];
}
