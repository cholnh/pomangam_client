import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
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
              new RaisedButton(
                onPressed: _submit,
                child: new Text('Save'),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
