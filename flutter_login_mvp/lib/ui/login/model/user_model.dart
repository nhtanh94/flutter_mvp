import 'dart:async';
class Users{
  String id;
  String account;
  String nameuser;
  String token;
  Users({this.id,this.account,this.nameuser,this.token});


  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['ID'],
        account: json['Account'],
        nameuser:json['NameUser'],
        token:json['Token']
    );
  }
}

abstract class UsersRepository {
  Future<Users> get(String User,String Pass);
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}