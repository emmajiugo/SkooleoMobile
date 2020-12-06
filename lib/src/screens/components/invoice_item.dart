import 'package:flutter/material.dart';
import 'package:skooleo/src/models/invoice.dart';
import 'package:skooleo/src/utils.dart';

import '../../routes.dart';

class InvoiceItem extends StatelessWidget {
  final Invoice invoice;

  const InvoiceItem({Key key, @required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(SINGLE_INVOICE_SCREEN,
            arguments: invoice.invoiceReference),
        contentPadding: EdgeInsets.all(20.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INVOICE #${invoice.invoiceReference}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              invoice.studentName,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Amount:\n${formatAmount(invoice.amount.toString())}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Class:\n${invoice.className}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Term:\n${invoice.term}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Session:\n${invoice.session}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          child: Text(
            invoice.status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: invoice.status == 'PAID' ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
