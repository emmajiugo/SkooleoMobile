import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/models/register.dart';
import 'package:skooleo/src/providers/register_provider.dart';
import 'package:skooleo/src/routes.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void register(RegisterProvider registerProvider) async {
    if (_formKey.currentState.validate()) {
      Register register = Register(
        _fullNameController.text,
        _emailController.text,
        _phoneNumberController.text,
        _passwordController.text,
        _passwordController.text,
      );
      bool success = await registerProvider.register(register);
      if (success) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NAV_SCREEN, (route) => false);
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: registerProvider.error.message,
          buttons: [
            DialogButton(
              child: Text(
                "OKAY",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => RegisterProvider(),
        child: Consumer<RegisterProvider>(
          builder: (context, model, child) => SingleChildScrollView(
            child: Container(
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
                        'assets/svgs/register.svg',
                        height: 100,
                      ),
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                      ),
                      validator: (String fullName) =>
                          fullName.isEmpty ? 'Full name is required' : null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'example@mail.com',
                      ),
                      validator: (String email) =>
                          email.isEmpty ? 'Email is required' : null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '090xxxxxx09',
                      ),
                      maxLength: 11,
                      validator: (String phoneNumber) {
                        if (phoneNumber.isEmpty) {
                          return 'Phone number is required';
                        } else if (phoneNumber.length < 11) {
                          return 'Phone number must be 11';
                        } else {
                          return null;
                        }
                      },
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
                        validator: (String password) {
                          if (password.isEmpty) {
                            return 'Password is required';
                          } else if (password.length < 6) {
                            return 'Password should be at least 6 characters';
                          }
                          return null;
                        }),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: kButtonSize,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 3,
                        onPressed:
                            model.isLoading ? null : () => register(model),
                        child: model.isLoading
                            ? CircularProgressIndicator()
                            : Text('REGISTER'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context)
                                    .pushNamed(LOGIN_SCREEN),
                              text: 'Login',
                              style: GoogleFonts.openSans(
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
