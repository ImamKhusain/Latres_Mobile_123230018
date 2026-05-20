import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseApi = "https://api.tvmaze.com";

  // List TV Show
  Future<List<dynamic>> fetchShows() async {
    try {
      final url = Uri.parse("$_baseApi/shows");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      }

      throw Exception(
        "Tidak dapat mengambil data show",
      );
    } catch (e) {
      throw Exception(
        "Terjadi kesalahan: $e",
      );
    }
  }

  // Deail TV Show
  Future<Map<String, dynamic>> fetchShowById(
    int id,
  ) async {
    try {
      final url = Uri.parse(
        "$_baseApi/shows/$id",
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final detail = json.decode(response.body);
        return detail;
      }

      throw Exception(
        "Detail show gagal dimuat",
      );
    } catch (e) {
      throw Exception(
        "Error detail show: $e",
      );
    }
  }
}