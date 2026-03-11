import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/products/model/product_model.dart';
import 'package:taghyeer_assessment/features/products/repo/products_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo _repo;

  ProductsBloc(this._repo) : super(ProductsInitial()) {
    on<ProductsFetched>(_onFetched);
    on<ProductsNextPageFetched>(_onNextPage);
  }

  Future<void> _onFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final result = await _repo.fetchProducts(skip: 0);
      if (result.products.isEmpty) {
        emit(ProductsEmpty());
      } else {
        emit(ProductsLoaded(
          products: result.products,
          total: result.total,
          skip: ProductsRepo.limit,
        ));
      }
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onNextPage(
    ProductsNextPageFetched event,
    Emitter<ProductsState> emit,
  ) async {
    final current = state;
    if (current is! ProductsLoaded) return;
    if (current.hasReachedMax || current.isPaginating) return;

    emit(current.copyWith(isPaginating: true));
    try {
      final result = await _repo.fetchProducts(skip: current.skip);
      final updated = [...current.products, ...result.products];
      emit(current.copyWith(
        products: updated,
        skip: current.skip + ProductsRepo.limit,
        isPaginating: false,
        hasReachedMax: updated.length >= result.total,
      ));
    } catch (e) {
      emit(current.copyWith(isPaginating: false));
    }
  }
}