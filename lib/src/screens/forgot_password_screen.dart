import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skooleo/src/services/user_service.dart';

import '../constants.dart';
import '../locator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _usernameController = TextEditingController();
  bool _isLoading = false;

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void forgotPassword() async {
    if (_formKey.currentState.validate()) {
      isLoading = true;
      try {
        Map<String, dynamic> response = await locator<UserService>()
            .forgotPassword(_usernameController.text);
        isLoading = false;
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              response['message'],
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          ),
        );
      } on DioError catch (e) {
        isLoading = false;
        if (e.response?.statusCode == 404) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                e.response?.data['message'],
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () =>
                    _scaffoldKey.currentState.hideCurrentSnackBar(),
              ),
            ),
          );
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                e.message,
              ),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () =>
                    _scaffoldKey.currentState.hideCurrentSnackBar(),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email or Phone',
                    hintText: 'doe@example.com or 070*****1111',
                  ),
                  validator: (String username) =>
                      username.isEmpty ? 'Field is required' : null,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: kButtonSize,
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    onPressed: _isLoading ? null : () => forgotPassword(),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
