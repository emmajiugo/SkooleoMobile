import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/locator.dart';
import 'package:skooleo/src/models/payment_link.dart';
import 'package:skooleo/src/providers/invoice_provider.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/screens/shared/error_template.dart';
import 'package:skooleo/src/services/payment_service.dart';
import 'package:skooleo/src/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleInvoiceScreen extends StatefulWidget {
  final String reference;

  const SingleInvoiceScreen({Key key, @required this.reference})
      : super(key: key);

  @override
  _SingleInvoiceScreenState createState() => _SingleInvoiceScreenState();
}

class _SingleInvoiceScreenState extends State<SingleInvoiceScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isPaymentLoading = false;

  void loadPayment(InvoiceProvider model) async {
    setState(() {
      _isPaymentLoading = true;
    });
    try {
      PaymentLink paymentLink =
          await locator<PaymentService>().paySingle(model.invoice.invoiceId);
      setState(() {
        _isPaymentLoading = false;
      });
      if (await canLaunch(paymentLink.data)) {
        await Navigator.of(context)
            .pushNamed(WEB_VIEW_SCREEN, arguments: paymentLink.data);
        model.getSingleInvoice(widget.reference);
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              'Could not launch (${paymentLink.data})',
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
            ),
          ),
        );
      }
    } on DioError catch (error) {
      setState(() {
        _isPaymentLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Failed to generate payment link - (${error.message})',
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
      inAsyncCall: _isPaymentLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Invoice #${widget.reference.toString()}',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) =>
              InvoiceProvider()..getSingleInvoice(widget.reference),
          child: Consumer<InvoiceProvider>(
            builder: (context, model, child) => Container(
              margin: EdgeInsets.all(30),
              alignment: Alignment.center,
              child: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : model.error != null
                      ? Center(
                          child: ErrorTemplate(
                            message: model.error.message,
                            refreshFunction: () async =>
                                await model.getSingleInvoice(widget.reference),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'INVOICE #${model.invoice.reference}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'School Fees: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          model.invoice.invoiceStatus,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5.0,
                                          horizontal: 5.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: model.invoice.invoiceStatus ==
                                                  'PAID'
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                height: 50,
                                color: Colors.grey,
                              ),
                              Column(
                                children: [
                                  Text(
                                    model.invoice.school.name,
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
                                    model.invoice.school.address,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    model.invoice.school.email,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    model.invoice.school.phone,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 50,
                                color: Colors.grey,
                              ),
                              Column(
                                children: [
                                  Text(
                                    model.invoice.student.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '${model.invoice.student.className} | ${model.invoice.student.term} | ${model.invoice.student.session}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 50,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                color: Colors.grey[300],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Amount(₦)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ListTile(
                                  title: Text(model
                                      .invoice.feeBreakdown[index].description),
                                  trailing: Text(
                                    formatAmount(model
                                        .invoice.feeBreakdown[index].amount
                                        .toString()),
                                  ),
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(height: 1),
                                itemCount: model.invoice.feeBreakdown.length,
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Sub Total: ',
                                    style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: formatAmount(
                                            model.invoice.total.toString()),
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Fee: ',
                                    style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: formatAmount(
                                            model.invoice.fee.toString()),
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Grand Total: ',
                                    style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: formatAmount(model
                                            .invoice.grandTotal
                                            .toString()),
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              model.invoice.invoiceStatus == 'PAID'
                                  ? Container()
                                  : Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                      height: kButtonSize,
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        onPressed: () => loadPayment(model),
                                        child: Text('Pay Now'),
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
