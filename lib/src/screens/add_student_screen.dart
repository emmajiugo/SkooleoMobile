import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skooleo/src/constants.dart';
import 'package:skooleo/src/models/school_fee.dart';
import 'package:skooleo/src/providers/invoice_provider.dart';
import 'package:skooleo/src/routes.dart';
import 'package:skooleo/src/utils.dart';

class AddStudentScreen extends StatefulWidget {
  final SchoolFee studentFee;

  const AddStudentScreen({Key key, @required this.studentFee})
      : super(key: key);

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _academicSessionController = TextEditingController();

  final _academicTermController = TextEditingController();

  final _studentClassController = TextEditingController();

  final _schoolNameController = TextEditingController();

  final _schoolAddressController = TextEditingController();

  final _studentNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _academicSessionController.text = widget.studentFee?.session;
    _academicTermController.text = widget.studentFee?.term;
    _studentClassController.text = widget.studentFee?.className;
    _schoolNameController.text = widget.studentFee?.schoolName;
    _schoolAddressController.text = widget.studentFee?.schoolAddress;
  }

  void postInvoice(InvoiceProvider model) async {
    if (_formKey.currentState.validate()) {
      bool success = await model.createInvoice(
          widget.studentFee.section,
          widget.studentFee.schoolId.toString(),
          widget.studentFee.feeSetupId.toString(),
          widget.studentFee.amount.toString(),
          widget.studentFee.feeName,
          widget.studentFee.session,
          widget.studentFee.term,
          widget.studentFee.className,
          _studentNameController.text);
      if (success) {
        Navigator.of(context)
            .pushNamed(SINGLE_INVOICE_SCREEN, arguments: model.invoiceId);
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => InvoiceProvider(),
        child: Consumer<InvoiceProvider>(
          builder: (context, model, child) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: kPrimaryColor,
                    ),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'SCHOOL FEES',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          formatAmount(widget.studentFee?.amount),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _academicSessionController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Academic Session',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _academicTermController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Academic Term',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _studentClassController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Student Class',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _schoolNameController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'School Name',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _schoolAddressController,
                            enabled: false,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'School Address',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _studentNameController,
                            decoration: InputDecoration(
                              labelText: 'Student Name',
                            ),
                            validator: (studentName) => studentName.isEmpty
                                ? 'Please input student name'
                                : null,
                          ),
                        ],
                      ),
                    ),
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
                          : () async => postInvoice(model),
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
    );
  }
}
