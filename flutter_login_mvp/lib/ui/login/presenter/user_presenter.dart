import 'package:flutter_login_mvp/ui/login/model/user_model.dart';
import 'package:flutter_login_mvp/ui/login/model/user_model_impl.dart';

abstract class ILogin {
  void LoginSuccess(Users user);
  void LoginError();
}

class LoginPresenter {
  ILogin _login;
  UsersRepository _usersRepository;
  LoginPresenter(this._login) {
    _usersRepository = GetUserRepository();
  }
  void loadUser(String user,String pass) {
    assert(_login != null);
    _usersRepository
        .get(user,pass)
        .then((data) => _login.LoginSuccess(data))
        .catchError((onError) {
      print(onError);
      _login.LoginError();
    });
  }
}
