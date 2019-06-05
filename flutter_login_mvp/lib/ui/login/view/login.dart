import 'package:flutter/material.dart';
import 'package:flutter_login_mvp/ui/login/model/user_model.dart';
import 'package:flutter_login_mvp/ui/login/presenter/user_presenter.dart';
import 'package:flutter_login_mvp/utilies/constains.dart';
import 'package:auto_size_text/auto_size_text.dart';
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> implements ILogin {
  LoginPresenter _loginPresenter;
  _LoginPage(){
    _loginPresenter = LoginPresenter(this);
  }
  Users _users;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String _userError ="Tài khoản không hợp lệ";
  String _passError ="Mật khẩu không hợp lệ";
  bool _userInvalid = false;
  bool _passInvalid = false;
  bool _showPass = false;
  TextEditingController _userController = TextEditingController(text: ACCOUNT);
  TextEditingController _passController = TextEditingController(text: PASSWORD);
  _showNackar(){
    final SnackBar snackBar = SnackBar(
      content: Text("Tài Khoản Mật Khẩu chưa đúng !"),
    );
    _globalKey.currentState.showSnackBar(snackBar);
  }
  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: 100,
        height: 100,
        decoration:
        BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
        child: FlutterLogo(),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            "WELLCOM FLUTTER",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ));
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: TextField(
            style: TextStyle(fontSize: 18, color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
              labelText: "USERNAME",
              errorText: _userInvalid?_userError:null,
              labelStyle: TextStyle(color: Colors.grey),
            ),
            controller: _userController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: <Widget>[
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key,
                    color: Colors.blue,
                  ),
                  labelText: "PASSWORD",
                  errorText: _passInvalid?_passError:null,
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                obscureText: !_showPass,
                controller: _passController,
              ),
              GestureDetector(
                onTap: onToggleShowPass,
                child: Text(
                  _showPass?"HIDE":"SHOW",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: onSignClicked,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Text(
                "SIGN IN",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                AutoSizeText(
                  "NEW USER ?",
                  style: TextStyle(fontSize: 10.0),
                  maxLines: 1,
                ),
                  AutoSizeText(
                    "SIGN UP",
                    style: TextStyle(color: Colors.blue,fontSize: 10.0),
                    maxLines: 1,
                  ),
                ],
              ),
              AutoSizeText(
                "FORGOT PASSWORD",
                style: TextStyle(color: Colors.blue,fontSize: 10.0),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        key: _globalKey,
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              _buildLogo(),
              _buildTitle(),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }
  void onToggleShowPass(){
    setState(() {
      _showPass = !_showPass;
    });
  }
  onSignClicked()async{
    if(_userController.text.length <3){
      setState(() {
        _userInvalid = true;
      });
      return;
    }
    if(_passController.text.length <3){
      setState(() {
        _passInvalid = true;
      });
      return;
    }
    else{

      setState(() {
        _userInvalid = false;
        _passInvalid = false;
        _loginPresenter.loadUser(_userController.text,_passController.text);
        if(_users.account == 'API'){
          print("Login Thanh Cong");

        }
        else{
          _showNackar();
        }
      });

    }
  }

  @override
  void LoginError() {
    // TODO: implement LoginError
  }

  @override
  void LoginSuccess(Users user) {
    // TODO: implement LoginSuccess
    _users = user;
  }
}
