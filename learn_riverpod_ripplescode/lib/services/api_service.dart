import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';

class ApiService {
  //endpoint (situs tujuan)
  String endpoint = "https://reqres.in/api/users?page=1";

  //ambil data modelnya pakai future
  Future<List<UserModel>> getUser() async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      //diambil atribut "data" nya pakai .body
      final List result = jsonDecode(response.body)["data"];

      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      //munculkan pesan error
      throw Exception(response.reasonPhrase);
    }
  }
}
