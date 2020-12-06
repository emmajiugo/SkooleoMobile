import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/screens/components/home_card.dart';
import 'package:skooleo/src/services/school_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void openStore() async {
    isLoading = true;
    try {
      Map<String, dynamic> response =
          await locator<SchoolService>().getStoreLink();
      isLoading = false;
      String storeLink = response['data'];
      if (await canLaunch(storeLink)) {
        await launch(storeLink);
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              'Could not launch $storeLink',
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          ),
        );
      }
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.blueGrey,
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Over 3500 schools registered and verified.',
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.7,
                        ),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.thumbsUp,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    homeCardItem(
                      () =>
                          Navigator.of(context).pushNamed(SCHOOL_SEARCH_SCREEN),
                      'assets/images/cash.png',
                      'PAY FEES',
                      'Easy payment for school fees without any hassle.',
                      Colors.green,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    homeCardItem(
                      () => Navigator.of(context).pushNamed(COMING_SOON_SCREEN),
                      'assets/images/piggy-bank.png',
                      'SAVINGS',
                      'Save for next term or session and earn 7% increase.',
                      Colors.pink,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    homeCardItem(
                      () => openStore(),
                      'assets/images/school.png',
                      'BACK TO SCHOOL',
                      'Get educational packages for your kids at a discounted price.',
                      Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
