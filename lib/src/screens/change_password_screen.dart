import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skooleo/src/services/user_service.dart';

import '../constants.dart';
import '../locator.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  bool _isPasswordVisible2 = false;

  void togglePassword2Visibility() {
    setState(() {
      _isPasswordVisible2 = !_isPasswordVisible2;
    });
  }

  void changePassword() async {
    if (_formKey.currentState.validate()) {
      isLoading = true;
      try {
        Map<String, dynamic> response = await locator<UserService>()
            .changePassword(
                _newPasswordController.text, _confirmPasswordController.text);
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
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              e.message,
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Change Password'),
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
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '*************',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => togglePasswordVisibility(),
                    ),
                  ),
                  validator: (String newPassword) =>
                      newPassword.isEmpty ? 'New password is required' : null,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isPasswordVisible2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: '*************',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible2
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => togglePassword2Visibility(),
                    ),
                  ),
                  validator: (String confirmPassword) {
                    if (confirmPassword.isEmpty) {
                      return 'password confirmation is required';
                    } else if (confirmPassword != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  // validator: (String newPassword) => newPassword.isEmpty
                  //     ? 'password confirmation is required'
                  //     : null,
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
                    onPressed: _isLoading ? null : () => changePassword(),
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
