// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import '../widgets/image_row.dart';
import '../services/service_locator.dart';
import '../model/app_model.dart';
import 'package:intl/intl.dart';
import '../services/firebase_service.dart' as backend;

class PayersPage extends StatelessWidget {
  const PayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BowlBar(
        title: "Payers",
      ),
    );
  }
}

class AddPayerForm extends StatefulWidget {
  const AddPayerForm({Key? key}) : super(key: key);

  @override
  _AddPayerState createState() => _AddPayerState();
}

class _AddPayerState extends State<AddPayerForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _addPayerFormKey = GlobalKey<FormState>();
  String _currentBowler = 'Aku';
  String _currentDate = '';

  @override
  void initState() {
    locator<AppModel>().addListener(update);
    super.initState();
  }

  update() {
    if (!mounted) {
      return;
    }
    setState(() {
      _currentBowler = locator<AppModel>().bowler;
      if (kDebugMode) {
        print('currentBowler $_currentBowler');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: BowlBar(title: "Add payer"),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: _addPayerForm(context),
      ),
    );
  }

  Widget _addPayerForm(context) {
    return Form(
      key: _addPayerFormKey,
      child: Center(
          widthFactor: 33.0,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  initialValue: DateFormat('dd.MM.yyyy').format(DateTime.now()),
                  onSaved: (val) {
                    setState(() {
                      _currentDate = val!;
                    });
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              ImageRowWidget(),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          )),
    );
  }

  void _submitForm() {
    _addPayerFormKey.currentState!.save();
    try {
      backend.addPayer(_currentBowler, _currentDate);
      _showMessage("Saved payer $_currentBowler");
    } catch (err) {
      _showMessage("Error.. $err", Colors.red);
    }
  }

  void _showMessage(String message, [MaterialColor color = Colors.green]) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(message),
    ));
  }
}
