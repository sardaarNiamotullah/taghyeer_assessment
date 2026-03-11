part of 'products_bloc.dart';

abstract class ProductsEvent {}

class ProductsFetched extends ProductsEvent {}

class ProductsNextPageFetched extends ProductsEvent {}