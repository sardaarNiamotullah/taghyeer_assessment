import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taghyeer_assessment/features/post/model/post_model.dart';

class PostsRepo {
  static const _baseUrl = 'https://dummyjson.com/posts';
  static const int limit = 10;

  Future<({List<PostModel> posts, int total})> fetchPosts({
    required int skip,
  }) async {
    final uri = Uri.parse('$_baseUrl?limit=$limit&skip=$skip');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final posts = (data['posts'] as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
      return (posts: posts, total: data['total'] as int);
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
