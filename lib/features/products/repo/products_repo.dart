import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taghyeer_assessment/features/products/model/product_model.dart';

class ProductsRepo {
  static const _baseUrl = 'https://dummyjson.com/products';
  static const int limit = 10;

  Future<({List<ProductModel> products, int total})> fetchProducts({
    required int skip,
  }) async {
    final uri = Uri.parse('$_baseUrl?limit=$limit&skip=$skip');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final products = (data['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return (products: products, total: data['total'] as int);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
