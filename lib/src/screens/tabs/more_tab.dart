import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/providers/authentication_provider.dart';
import 'package:skooleo/src/routes.dart';

class MoreTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authenticationProvider =
        Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(EDIT_PROFILE_SCREEN),
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
              onTap: () async => await FlutterWebviewPlugin().evalJavascript(
                  "<script async type=\"text/javascript\" src=\"https://userlike-cdn-widgets.s3-eu-west-1.amazonaws.com/7b897a71f129ef36a1a7d1c19d50f0ac526e4b8cf2297eca490303cf0a8d55d5.js\"></script>"),
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
    );
  }
}
