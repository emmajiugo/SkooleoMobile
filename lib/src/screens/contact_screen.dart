import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/providers/contact_provider.dart';
import 'package:skooleo/src/screens/shared/error_template.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ContactProvider()..getContactDetails(),
        child: Consumer<ContactProvider>(
          builder: (context, model, child) => model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.error != null
                  ? Center(
                      child: ErrorTemplate(
                          message: model.error.message,
                          refreshFunction: () => model.getContactDetails()),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Address',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              model.contact.address != null
                                  ? model.contact?.address
                                  : '',
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 30,
                              color: Colors.grey,
                            ),
                            Text(
                              'Phone Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              model.contact?.phone,
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              height: 30,
                              color: Colors.grey,
                            ),
                            Text(
                              'Email Address',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              model.contact?.email,
                              textAlign: TextAlign.center,
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
