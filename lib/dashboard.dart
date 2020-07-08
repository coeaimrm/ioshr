import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_recognition/speech_recognition.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var selectedEmployee, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _feedbackType = <String>[
    'Positive ',
    'Negative ',
  ];
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              color: Colors.white,
            ),
            onPressed: () {}),
        title: Container(
          alignment: Alignment.center,
          child: Text("HR App",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              size: 20.0,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Form(
        key: _formKeyValue,
        autovalidate: true,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            new Text(
              "employee",
              style: new TextStyle(fontSize:40.0,
                  color: const Color(0xFF312c2c),
                  fontWeight: FontWeight.w300,
                  fontFamily: "Roboto"),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("employee").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    const Text("Loading.....");
                  else {
                    List<DropdownMenuItem> employeeItems = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      DocumentSnapshot snap = snapshot.data.documents[i];
                      employeeItems.add(
                        DropdownMenuItem(
                          child: Text(
                            snap.documentID,
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                          value: "${snap.documentID}",
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.bars,
                            size: 25.0, color: Color(0xff11b719)),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          items: employeeItems,
                          onChanged: (employeeValue) {
                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Employee is $employeeValue',
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selectedEmployee = employeeValue;
                            });
                          },
                          value: selectedEmployee,
                          isExpanded: false,
                          hint: new Text(
                            "Choose employee",
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                        ),
                      ],
                    );
                  }
                }),
            SizedBox(
              height: 50.0,
            ),
            new Text(
              "Feedback type",
              style: new TextStyle(fontSize:40.0,
                  color: const Color(0xFF312c2c),
                  fontWeight: FontWeight.w300,
                  fontFamily: "Roboto"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.bars,
                  size: 25.0,
                  color: Color(0xff11b719),
                ),
                SizedBox(width: 50.0),
                DropdownButton(
                  items: _feedbackType
                      .map((value) => DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                    value: value,
                  ))
                      .toList(),
                  onChanged: (selectedFeedbackType) {
                    print('$selectedFeedbackType');
                    setState(() {
                      selectedType = selectedFeedbackType;
                    });
                  },
                  value: selectedType,
                  isExpanded: false,
                  hint: Text(
                    'Choose Feedback Type',
                    style: TextStyle(color: Color(0xff11b719)),
                  ),
                )
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.cancel),
                  mini: true,
                  backgroundColor: Colors.deepOrange,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.cancel().then(
                            (result) => setState(() {
                          _isListening = result;
                          resultText = "";
                        }),
                      );
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.mic),
                  onPressed: () {
                    if (_isAvailable && !_isListening)
                      _speechRecognition
                          .listen(locale: "en_US")
                          .then((result) => print('$result'));
                  },
                  backgroundColor: Colors.pink,
                ),
                FloatingActionButton(
                  child: Icon(Icons.stop),
                  mini: true,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (_isListening)
                      _speechRecognition.stop().then(
                            (result) => setState(() => _isListening = result),
                      );
                  },
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.cyanAccent[100],
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Text(
                resultText,
                style: TextStyle(fontSize: 24.0),
              ),

            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
                color: Color(0xff11b719),
                textColor: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Submit", style: TextStyle(fontSize: 24.0)),
                      ],
                    )),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ],
        ),
      ),
    );
  }
}