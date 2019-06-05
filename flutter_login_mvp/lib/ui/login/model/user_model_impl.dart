import 'dart:async';
import 'package:flutter_login_mvp/ui/login/model/response_data_api.dart';
import 'user_model.dart';
import '../../../utilies/interactions.dart';

class GetUserRepository implements UsersRepository {

  final ApiConnection _apiConnection = ApiConnection();
  Future<Users> get(String user,String pass) async {
    Map<String,dynamic> account = {
      "Username":user,
      "Password":pass
    };
    ApiResponseData jsonBody = await _apiConnection.createPost("login",body: account);
    return Users.fromJson(jsonBody.data);
  }
}