import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speech_recognition/speech_recognition.dart';

class InstantFeedPage extends StatefulWidget {
  @override
  _InstantFeedPageState createState() => _InstantFeedPageState();
}

class _InstantFeedPageState extends State<InstantFeedPage> {



  var selectedEmployee, selectedType,month,emp,pCount=0,nCount=0;

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _feedbackType = <String>[
    'Positive ',
    'Negative ',
  ];

  List<String> _monthType = <String>[
    'Jan ',
    'Feb ',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',

  ];

  List<String> _empType = <String>[
    'Manas ',
    'Su ',
    'Barsa',
    'Harsh',
    'Chinmay',
    'Priyanka',
    'Kalyan',
    'Smruti',
    'Priti',
    'Jaya',
    'Alen',
    'Souvik'

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

  void createRecord(selectedType,resultText,emp,month){

    Firestore.instance.collection("Emp").add({
      'FeedBackType':'$selectedType',
      'FeedBack':'$resultText',
      'name':'$emp',
      'month':'$month'

    });


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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: <Widget>[
            new Text(
              "Months",
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
                  items: _monthType
                      .map((value) => DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                    value: value,
                  ))
                      .toList(),
                  onChanged: (selectedMonthType) {
                    print('$selectedMonthType');
                    setState(() {
                      month = selectedMonthType;
                    });
                  },
                  value: month,
                  isExpanded: false,
                  hint: Text(
                    'Choose Month',
                    style: TextStyle(color: Color(0xff11b719)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            new Text(
              "employee",
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
                  items: _empType
                      .map((value) => DropdownMenuItem(
                    child: Text(
                      value,
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                    value: value,
                  ))
                      .toList(),
                  onChanged: (selectedEmpType) {
                    print('$selectedEmpType');
                    setState(() {
                      emp = selectedEmpType;
                    });
                  },
                  value: emp,
                  isExpanded: false,
                  hint: Text(
                    'Choose Employee',
                    style: TextStyle(color: Color(0xff11b719)),
                  ),
                )
              ],
            ),
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
                 heroTag: "btn1",
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
                  heroTag: "btn2",
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
              //need to add font weight and style fontweight
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

                    onPressed: () {

                      createRecord(selectedType,resultText,emp,month);
                     },
                     //Using Transactions
                     // Firestore.instance.runTransaction((Transaction crudTransaction) async {
                     //   CollectionReference reference =
                     //       await Firestore.instance.collection('testcrud');

                     //   reference.add(carData);
                     // });


                 shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))),
          ],
        ),
      ),
    );
  }
}

