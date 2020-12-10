import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skooleo/src/models/invoice.dart';
import 'package:skooleo/src/models/payment_link.dart';
import 'package:skooleo/src/providers/invoice_provider.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/screens/components/invoice_item.dart';
import 'package:skooleo/src/screens/shared/empty_screen_template.dart';
import 'package:skooleo/src/services/payment_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';

class InvoiceListTab extends StatefulWidget {
  @override
  _InvoiceListTabState createState() => _InvoiceListTabState();
}

class _InvoiceListTabState extends State<InvoiceListTab> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool _isPaymentLoading = false;
  bool _isLoading = true;
  List<Invoice> _invoices = [];

  set isPaymentLoading(bool paymentLoading) {
    setState(() {
      _isPaymentLoading = paymentLoading;
    });
  }

  set isLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  set invoices(List<Invoice> invoices) {
    setState(() {
      _invoices = invoices;
    });
  }

  void loadInvoices() async {
    isLoading = true;
    invoices = await InvoiceProvider().getInvoices();
    isLoading = false;
  }

  void refreshInvoices() async {
    invoices = await InvoiceProvider().getInvoices();
    _refreshController.refreshCompleted();
  }

  void loadPayment() async {
    setState(() {
      _isPaymentLoading = true;
    });
    try {
      PaymentLink paymentLink = await locator<PaymentService>().payBulk();
      isPaymentLoading = false;
      if (await canLaunch(paymentLink.data)) {
        await Navigator.of(context)
            .pushNamed(WEB_VIEW_SCREEN, arguments: paymentLink.data);
        loadInvoices();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: 'Could not launch (${paymentLink.data})',
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
    } on DioError catch (error) {
      setState(() {
        _isPaymentLoading = false;
      });
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: 'Failed to generate payment link - (${error.message})',
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
  void initState() {
    super.initState();
    loadInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isPaymentLoading,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(SCHOOL_SEARCH_SCREEN),
                    child: Text('Add Student'),
                  ),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () => loadPayment(),
                    child: Text('Pay All'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                // height: double.infinity,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SmartRefresher(
                        onRefresh: refreshInvoices,
                        header: WaterDropMaterialHeader(),
                        controller: _refreshController,
                        child: _invoices == null || _invoices.isEmpty
                            ? EmptyScreenTemplate(
                                message: 'You have no Invoice yet',
                              )
                            : ListView.separated(
                                itemCount: _invoices.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(height: 1),
                                itemBuilder: (context, index) => InvoiceItem(
                                  invoice: _invoices[index],
                                ),
                              ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
