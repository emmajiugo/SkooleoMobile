import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/user_profile.dart';
import 'package:skooleo/src/providers/user_provider.dart';
import 'package:skooleo/src/screens/shared/error_template.dart';
import 'package:skooleo/src/services/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _fullNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  bool _isLoading = false;
  ExceptionHelper _error;

  void getProfile() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      UserProfile userProfile = await locator<UserService>().getProfile();
      _fullNameController.text = userProfile?.fullName;
      _emailController.text = userProfile?.email;
      _phoneNumberController.text = userProfile?.phone;

      setState(() {
        _isLoading = false;
      });
    } on DioError catch (e) {
      setState(() {
        _error = ExceptionHelper(e.message);
        _isLoading = false;
      });
    }
  }

  void updateProfile(UserProvider model) async {
    if (_formKey.currentState.validate()) {
      print(_fullNameController.text);
      bool success = await model.updateProfile(
          _fullNameController.text, _phoneNumberController.text);
      if (success) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              'Profile updated successfully',
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          ),
        );
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
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: Consumer<UserProvider>(
          builder: (context, model, child) => _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _error != null
                  ? Center(
                      child: ErrorTemplate(
                        message: _error.message,
                        refreshFunction: () => getProfile(),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _fullNameController,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  hintText: 'John Doe',
                                ),
                                validator: (String fullName) => fullName.isEmpty
                                    ? 'Full name is required'
                                    : null,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                enabled: false,
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
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                height: kButtonSize,
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 3,
                                  onPressed: model.isLoading
                                      ? null
                                      : () async => updateProfile(model),
                                  child: model.isLoading
                                      ? CircularProgressIndicator()
                                      : Text('Submit'),
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
