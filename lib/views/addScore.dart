// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../widgets/bowlbar.dart';
import '../services/firebase_service.dart' as backend;

class AddScoreForm extends StatefulWidget {
  const AddScoreForm({Key? key}) : super(key: key);

  @override
  _AddScoreState createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScoreForm> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final _addScoreFormKey = GlobalKey<FormState>();
  final _serieController = TextEditingController();
  final _akuController = TextEditingController();
  final _mikkoController = TextEditingController();
  final _olliController = TextEditingController();

  int _akuScore = 0;
  int _mikkoScore = 0;
  int _olliScore = 0;
  int _serie = 0;

  @override
  void initState() {
    super.initState();
    _serieController.text = '1';
    _akuController.text = '0';
    _mikkoController.text = '0';
    _olliController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BowlBar(title: "Add score"),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: _addScoreForm(),
      ),
    );
  }

  Widget _addScoreForm() {
    return Form(
      key: _addScoreFormKey,
      child: Center(
        widthFactor: 33.0,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
              //controller: _controller,
              decoration: InputDecoration(
                labelText: "Serie",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              //initialValue: '1',
              keyboardType: TextInputType.number,
              controller: _serieController,
              validator: (value) => _validateScore(value!),
              onTap: () {
                _serieController.text = '';
              },
              onSaved: (val) {
                setState(() {
                  _serie = int.parse(val!);
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Aku",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                //initialValue: '0',
                keyboardType: TextInputType.number,
                controller: _akuController,
                validator: (value) => _validateScore(value!),
                onTap: () {
                  _akuController.text = '';
                },
                onSaved: (val) {
                  setState(() {
                    _akuScore = int.parse(val!);
                  });
                }),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Mikko",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                //initialValue: '0',
                keyboardType: TextInputType.number,
                controller: _mikkoController,
                validator: (value) => _validateScore(value!),
                onTap: () {
                  _mikkoController.text = '';
                },
                onSaved: (val) {
                  setState(() {
                    _mikkoScore = int.parse(val!);
                  });
                }),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Olli",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
                //initialValue: '0',
                keyboardType: TextInputType.number,
                controller: _olliController,
                validator: (value) => _validateScore(value!),
                onTap: () {
                  _olliController.text = '';
                },
                onSaved: (val) {
                  setState(() {
                    _olliScore = int.parse(val!);
                  });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_addScoreFormKey.currentState!.validate()) {
                    _addScoreFormKey.currentState!.save();
                    _submitForm();
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? _validateScore(String value) {
    int val = int.parse(value); 
    if (val > 300 || val < 0) {
      return "Please enter value between 0 and 300";
    }
    return null;
  }

  void _submitForm() {
    backend.addScore(_akuScore, _mikkoScore, _olliScore, _serie);
    showMessage("Success!");
    _clearForm();
  }

  void _clearForm() {
    setState(() {
      int nextSerie = int.parse(_serieController.text) + 1;
      _serieController.text = nextSerie.toString();
      _akuController.text = '0';
      _mikkoController.text = '0';
      _olliController.text = '0';
    });
  }

  void showMessage(String message, [MaterialColor color = Colors.green]) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: color, content: Text(message)));
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }
}
