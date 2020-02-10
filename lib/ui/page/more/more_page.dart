import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pomangam_client/common/router/app_router.dart';
import 'package:pomangam_client/provider/common/initializer_model.dart';
import 'package:pomangam_client/provider/sign/sign_up_model.dart';
import 'package:pomangam_client/ui/widget/sign/sign_modal.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();
  bool _saving = false;
  bool _bedroom = false;

  _submit() {
    setState(() {
      _saving = true;
    });

    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Bedroom'),
                value: _bedroom,
                onChanged: (bool value) {
                  setState(() {
                    _bedroom = value;
                  });
                },
                secondary: const Icon(Icons.hotel),
              ),
              RaisedButton(
                onPressed: _submit,
                child: Text('Save'),
              ),
              Divider(),
              RaisedButton(
                onPressed: _showModal,
                child: Text('Login'),
              ),
            ],
          ),
        ),

      ),
    );
  }

  _showModal({Widget widget}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (context) {
          return SignModal(onSignIn: _onSignIn, onSignUp: _onSignUp);
        }
    );
  }

  _onSignIn() {
    //router.navigateTo(context, '/signin');
  }

  _onSignUp() {
    Provider.of<SignUpModel>(context, listen: false).returnUrl = '/';
    router.navigateTo(context, '/signup');
  }
}
