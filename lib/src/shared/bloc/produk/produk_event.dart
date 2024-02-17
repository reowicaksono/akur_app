part of 'produk_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProducts extends ProductEvent {}

class DeleteProduct extends ProductEvent {
  final String uuid;
  const DeleteProduct({required this.uuid});
}

class AddProduct extends ProductEvent {
  final RowProduk rowProduk;

  const AddProduct({required this.rowProduk, required String description});

  @override
  List<Object> get props => [rowProduk];
}

class UpdateProduct extends ProductEvent {
  final RowProduk rowProduk;

  const UpdateProduct({required this.rowProduk, required String description});

  @override
  List<Object> get props => [rowProduk];
}
