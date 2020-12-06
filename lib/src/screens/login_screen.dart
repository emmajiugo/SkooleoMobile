import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/models/login.dart';
import 'package:skooleo/src/providers/login_provider.dart';
import 'package:skooleo/src/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void login(LoginProvider model) async {
    if (_formKey.currentState.validate()) {
      Login login = Login(
        _usernameController.text,
        _passwordController.text,
      );
      bool success = await model.login(login);
      if (success) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NAV_SCREEN, (route) => false);
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              model.error.message,
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
        title: Text('Login'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context, model, child) => Container(
              margin: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 35,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/log-in.svg',
                        height: 100,
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email or Phone',
                        hintText: 'example@mail.com or 090xxxxxx09',
                      ),
                      validator: (String username) =>
                          username.isEmpty ? 'Please input username' : null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '****************',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => togglePasswordVisibility(),
                        ),
                      ),
                      validator: (String password) =>
                          password.isEmpty ? 'Please input password' : null,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(FORGOT_PASSWORD_SCREEN),
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
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
                        onPressed: model.isLoading ? null : () => login(model),
                        child: model.isLoading
                            ? CircularProgressIndicator()
                            : Text('LOGIN'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                    .pushNamed(REGISTER_SCREEN),
                              text: 'Register',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
