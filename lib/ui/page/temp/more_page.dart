import 'package:flutter/material.dart';
import 'package:pomangam_client/common/key/pmg_key.dart';
import 'package:pomangam_client/common/network/domain/user_dto.dart';
import 'package:pomangam_client/common/network/exception/oauth_exception.dart';
import 'package:pomangam_client/common/network/provider/user_model.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  static final loginForm = GlobalKey<FormState>();
  String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginForm,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Username',
                ),
                onSaved: (value) {
                  _username = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                onSaved: (value) {
                  _password = value;
                },
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: _submitForm,
                  child: Text('Sign In'),
                ),
              ),
              Consumer<UserModel>(
                builder: (_, model, child) {
                  return Text('${model.signState}');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final FormState form = loginForm.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
      try {
        UserDto userInfo = await Provider.of<UserModel>(context, listen: false)
            .signIn(username: _username, password: _password);
        showMessage('"${userInfo.nickname}"님 로그인 성공');
      } on OauthNetworkException catch(e) {
        String msg;
        switch(e.type) {

          case OauthExceptionType.networkError:
            msg = '네트워크 에러';
            break;
          case OauthExceptionType.serverMaintenance:
            msg = '서버 점검 중';
            break;
          case OauthExceptionType.serverClosed:
            msg = '서버 종료';
            break;
          case OauthExceptionType.badCredentials:
            msg = '잘못된 로그인 정보 입력';
            break;
        }
        showMessage('로그인 실패 - ${msg??''}');
      }
    }
  }

  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: new Text(message)));
  }
}
