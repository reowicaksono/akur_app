part of 'produk_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAddedSuccess extends ProductState {}

class ProductAddedFailure extends ProductState {
  final String error;

  const ProductAddedFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductsLoaded extends ProductState {
  final List<RowProduk> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductsLoadFailure extends ProductState {
  final String error;

  const ProductsLoadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
