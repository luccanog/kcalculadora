import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  String _infoText = "Basal metabolic rate";
  String selectedItem = 'Male';
  var _sex = ['Male', 'Female'];

  void _resetFields() {
    weightCtrl.clear();
    heightCtrl.clear();
    ageCtrl.clear();
    setState(() {
      _infoText = "Basal metabolic rate.";
    });
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      selectedItem = novoItem;
    });
  }

  void calculate() {
    String result = '';
    double weight = double.parse(weightCtrl.text);
    double height = double.parse(heightCtrl.text);
    double age = double.parse(ageCtrl.text);
    String sex = selectedItem;

    switch (sex) {
      case 'Male':
        result =
            (66 + (13.7 * weight) + (5.0 * height) - (6.8 * age)).toStringAsFixed(2);
        break;
      case 'Female':
        result =
            (665 + (9.6 * weight) + (1.8 * height) - (4.7 * age)).toStringAsFixed(2);
        break;
    }

    setState(() {
      _infoText = '$result Kcal';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('KCalc'),
            centerTitle: true,
            backgroundColor: Colors.black87,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              )
            ]),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.calculate_sharp, size: 120, color: Colors.black87),
              WeightInput(weightCtrl: weightCtrl),
              HeightInput(heightCtrl: heightCtrl),
              AgeInput(ageCtrl: ageCtrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sex",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                    ),
                  ),
                  DropdownButton<String>(
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                    ),
                    items: _sex.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String newSelectedItem) {
                      _dropDownItemSelected(newSelectedItem);
                    },
                    value: selectedItem,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: calculate,
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 25.0),
              )
            ],
          ),
        ));
  }
}

class AgeInput extends StatelessWidget {
  var ageCtrl = TextEditingController();
  AgeInput({this.ageCtrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ageCtrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Age(Years)",
        labelStyle: TextStyle(
          color: Colors.black87,
          fontSize: 25,
        ),
      ),
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 25,
      ),
    );
  }
}

class WeightInput extends StatelessWidget {
  var weightCtrl = TextEditingController();
  WeightInput({this.weightCtrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: weightCtrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Weight(Kg)",
        labelStyle: TextStyle(
          color: Colors.black87,
          fontSize: 25,
        ),
      ),
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 25,
      ),
    );
  }
}

class HeightInput extends StatelessWidget {
  var heightCtrl = TextEditingController();
  HeightInput({this.heightCtrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: heightCtrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Height(cm)",
        labelStyle: TextStyle(
          color: Colors.black87,
          fontSize: 25,
        ),
      ),
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 25,
      ),
    );
  }
}
