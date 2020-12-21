import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/providers/authentication_provider.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/services/contact_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  bool _isLoading = false;

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void _loadLiveChat() async {
    try {
      isLoading = true;
      String link = await locator<ContactService>().getLiveChatLink();
      isLoading = false;
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: 'Could not launch ($link})',
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
    } on DioError catch (e) {
      isLoading = false;
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: e.response.statusMessage,
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

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(EDIT_PROFILE_SCREEN),
                leading: Icon(Icons.account_box),
                title: Text('Edit Profile'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () =>
                    Navigator.of(context).pushNamed(CHANGE_PASSWORD_SCREEN),
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(CONTACT_SCREEN),
                leading: Icon(Icons.phone),
                title: Text('Contact'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () => _loadLiveChat(),
                leading: Icon(Icons.live_help),
                title: Text('Live Chat'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () => authenticationProvider.logout(),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
