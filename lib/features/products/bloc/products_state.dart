part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsEmpty extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final bool isPaginating;
  final bool hasReachedMax;

  ProductsLoaded({
    required this.products,
    required this.total,
    required this.skip,
    this.isPaginating = false,
    this.hasReachedMax = false,
  });

  ProductsLoaded copyWith({
    List<ProductModel>? products,
    int? total,
    int? skip,
    bool? isPaginating,
    bool? hasReachedMax,
  }) => ProductsLoaded(
    products: products ?? this.products,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    isPaginating: isPaginating ?? this.isPaginating,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
  );
}
