import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/helpers/ExceptionHelper.dart';
import 'package:skooleo/src/models/fee_type.dart';
import 'package:skooleo/src/models/school_detail.dart';
import 'package:skooleo/src/models/session.dart';
import 'package:skooleo/src/providers/school_provider.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/screens/shared/error_template.dart';
import 'package:skooleo/src/services/school_service.dart';

import '../locator.dart';

class SchoolFeeScreen extends StatefulWidget {
  final String schoolId;

  const SchoolFeeScreen({Key key, this.schoolId}) : super(key: key);

  @override
  _SchoolFeeScreenState createState() => _SchoolFeeScreenState();
}

class _SchoolFeeScreenState extends State<SchoolFeeScreen> {
  List<String> _classes = <String>[];

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _feeType;
  String _section;
  String _session;
  String _term;
  String _selectedClass;

  SchoolDetail _school;
  ExceptionHelper _error;
  bool _isLoading = false;

  void getSchool() async {
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      _school = await locator<SchoolService>().getSingleSchool(widget.schoolId);

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

  void getSchoolFees(SchoolProvider model) async {
    bool success = await model.getSchoolFee(_school.schoolId.toString(),
        _feeType.toString(), _section, _session, _term, _selectedClass);
    if (success) {
      Navigator.of(context)
          .pushNamed(ADD_STUDENT_SCREEN, arguments: model.schoolFee);
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

  @override
  void initState() {
    super.initState();
    getSchool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Pay Fee',
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => SchoolProvider(),
        child: Consumer<SchoolProvider>(
          builder: (context, model, child) => _isLoading
              ? Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(
                      child: ErrorTemplate(
                          message: _error.message,
                          refreshFunction: () => getSchool()),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  _school.schoolName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  _school.schoolAddress,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  _school.schoolEmail,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  _school.schoolPhone,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Divider(
                              height: 50,
                              color: Colors.grey,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Select Fee Type'),
                              items: _school.feeTypes.map((FeeType feeType) {
                                return DropdownMenuItem<int>(
                                  value: feeType.id,
                                  child: Text(feeType.feeName),
                                );
                              }).toList(),
                              value: _feeType,
                              onChanged: (value) {
                                _feeType = value;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Select Section'),
                              items: <String>[
                                'SECONDARY',
                                'PRIMARY',
                                'NURSERY',
                                'CRECHE',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _section,
                              onChanged: (value) {
                                setState(() {
                                  _section = value;
                                  switch (value) {
                                    case 'CRECHE':
                                      _selectedClass = 'CRECHE';
                                      _classes = <String>[
                                        'CRECHE',
                                      ];
                                      break;
                                    case 'NURSERY':
                                      _selectedClass = 'NURSERY 3';
                                      _classes = <String>[
                                        'NURSERY 3',
                                        'NURSERY 2',
                                        'NURSERY 1',
                                      ];
                                      break;
                                    case 'PRIMARY':
                                      _selectedClass = 'PRIMARY 6';
                                      _classes = <String>[
                                        'PRIMARY 6',
                                        'PRIMARY 5',
                                        'PRIMARY 4',
                                        'PRIMARY 3',
                                        'PRIMARY 2',
                                        'PRIMARY 1',
                                      ];
                                      break;
                                    case 'SECONDARY':
                                      _selectedClass = 'SS 3';
                                      _classes = <String>[
                                        'SS 3',
                                        'SS 2',
                                        'SS 1',
                                        'JSS 3',
                                        'JSS 2',
                                        'JSS 1',
                                      ];
                                      break;
                                    default:
                                      _classes = <String>[];
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Select Session'),
                              items: _school.sessions.map((Session session) {
                                return DropdownMenuItem<String>(
                                  value: session.sessionName,
                                  child: Text(session.sessionName),
                                );
                              }).toList(),
                              value: _session,
                              onChanged: (value) {
                                _session = value;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Select Term'),
                              items: <String>[
                                '1ST TERM',
                                '2ND TERM',
                                '3RD TERM',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _term,
                              onChanged: (value) {
                                _term = value;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField(
                              hint: Text('Select Class'),
                              value: _selectedClass,
                              items: _classes.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                // _selectedClass = value;
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
                                    : () async => getSchoolFees(model),
                                child: model.isLoading
                                    ? CircularProgressIndicator()
                                    : Text('Continue...'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
