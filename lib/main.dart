import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/async.dart';
void main() {
  runApp(MyApp());
}
Color galbenPastel = Colors.white;
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('path' + 'assets/vloggeri.txt');
}

Future<String> get getFilePath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> getFile(String fileName) async {
  final path = await getFilePath;

  return File('$path/$fileName');
}

Future<File> saveToFile(String fileName, String data) async {
  final file = await getFile(fileName);
  return file.writeAsString(data);
}

Future<String> readFromFile(String fileName) async {
  try {
    final file = await getFile(fileName);
    String fileContents = await file.readAsString();
    return fileContents;
  } catch (e) {
    return "";
  }
}

Future<String> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();
    print(contents);
    return contents;
  } catch (e) {
    // If encountering an error, return 0.
    return '';
  }
}

Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

List<String> lista = new List<String>();
void GetList(String categorie) async {
  String fisier = await getFileData('assets/' + categorie + '.txt');
  String name= '';
  int i = 0;
  for (i; i < fisier.length; i++) {
    if (fisier[i] != '\n')
      name = name + fisier[i];
    else {
      print(name);
      lista.add(name);
      name = '';

    }
  }
  lista.add(name);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SelectGamePage(),
    );
  }
}
class endPage extends StatefulWidget {
  int corecte;
  int contor;
  endPage(this.corecte , this.contor);
  @override
  _endPageState createState() => _endPageState();
}

class _endPageState extends State<endPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Center(child: Text('Felicitari, ati obtinut ' + widget.corecte.toString() + ' puncte!', textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(160, 196, 255, 1) , fontSize: 25 , fontWeight: FontWeight.bold,fontFamily: 'sf',),)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.6,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15) , bottomRight: Radius.circular(15)),
              ),
              child: RaisedButton(
                color: Color.fromRGBO(189, 178, 255, 1),
                onPressed: () {
                  round ++;
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => SelectGamePage()));
                },
                child: Text('Inapoi la pagina principala', style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'sf',),),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
class Intermediar extends StatefulWidget {
  int corecte;
  int contor;
  Intermediar(this.corecte , this.contor);
  @override
  _IntermediarState createState() => _IntermediarState();
}
int round = 0;
String winner = '';
int g1 = 0;
int g2 = 0;
int punctaj1 = 0;
int punctaj2 = 0;
class _IntermediarState extends State<Intermediar> {
  @override
  Widget build(BuildContext context) {
    if (round == 1) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      if (round % 2 == 0)
        punctaj1 = widget.corecte;
      if (round % 2 == 1) {
        punctaj2 = widget.corecte;
      }
        if (punctaj1 > punctaj2) {
          g1 ++;
        }
        if (punctaj1 < punctaj2)
          g2 ++;
      if (g1 > g2)
        winner = 'cu numarul 1';
      else
        winner = 'cu numarul 2';
      return Scaffold(
        backgroundColor: galbenPastel,
        body: Column(
          children: <Widget>[
            Spacer(),
            Center(child: Text('Echipa ' + winner + ' a castigat! ', textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(160, 196, 255, 1) , fontSize: 25 , fontWeight: FontWeight.bold,fontFamily: 'sf',),)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15) , bottomRight: Radius.circular(15)),
                ),
                child: RaisedButton(
                  color: Color.fromRGBO(189, 178, 255, 1),
                  onPressed: () {
                    round ++;
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) => SelectGamePage()));
                  },
                  child: Text('Inapoi la pagina principala', style: TextStyle(color: Colors.white , fontSize: 20,fontFamily: 'sf',),),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      );
    }
    else {
      print('entered');
      if (round % 2 == 0)
        punctaj1 = widget.corecte;
      if (round % 2 == 1) {
        punctaj2 = widget.corecte;
        if (punctaj1 > punctaj2) {
          g1 ++;
        }
        if (punctaj1 < punctaj2)
          g2 ++;
      }
        print('passed');
        return GestureDetector(
          onTap: (){
            round ++;
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft]);
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => TeamGamePage()));
          },
          child: Scaffold(
            backgroundColor: galbenPastel,
            body: Column(
              children: <Widget>[
                Spacer(),
                Center(child: Text(
                    'Felicitari Echipa ' + (round % 2 + 1).toString() + '! Ati obtinut ' +
                        widget.corecte.toString() +
                        ' puncte!' ,style: TextStyle(fontSize: 30, color: Color.fromRGBO(160, 196, 255, 1) , fontWeight: FontWeight.w500, fontFamily: 'sf',),),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Echipa numarul ' + (2 - round).toString() + ', cand sunteti gata apasati pe ecran!',style: TextStyle(fontSize: 30, color: Color.fromRGBO(189, 178, 255, 1),fontFamily: 'sf',) ,),
                ),
                Spacer(),
              ],
            ),
          ),
        );
    }
  }
}
class SelectGamePage extends StatefulWidget {
  @override
  _SelectGamePageState createState() => _SelectGamePageState();
}

class _SelectGamePageState extends State<SelectGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: galbenPastel,
      body: Column(
        children: <Widget>[
          Spacer(),
          Text('Ghicește!' , style: TextStyle(fontSize: 40 , color: Colors.black, fontWeight: FontWeight.bold ,fontFamily: 'sf',),),
          Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    child: ButtonTheme(

                      buttonColor: Color.fromRGBO(189, 178, 255, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: MediaQuery.of(context).size.width * 0.46,
                      height: MediaQuery.of(context).size.width * 0.46,
                      child: RaisedButton(
                        child: Text('Solo' , style: TextStyle(color:Colors.white, fontSize: 25,fontFamily: 'sf',) ,),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(1)));
                        },
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                    child: ButtonTheme(
                      buttonColor: Color.fromRGBO(160, 196, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      minWidth: MediaQuery.of(context).size.width * 0.46,
                      height: MediaQuery.of(context).size.width * 0.46,
                      child: RaisedButton(
                        child: Text('Pe Echipe' , style: TextStyle(color: Colors.white, fontSize: 25,fontFamily: 'sf',) ,),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(2)));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  String categorie;
  GamePage(this.categorie);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  StreamSubscription<dynamic> _streamSubscriptions;
  String text;
  String _data;
  var celeblist;
  int contor = 0;
  int _start = 60;
  int corecte = 0;
  int _current = 60;
  var sub;
  DateTime last = DateTime.now();
  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {

      _streamSubscriptions.cancel();
      print("Done");
      sub.cancel();
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => endPage(corecte, contor)));
    });
  }
  void initState() {
    _streamSubscriptions = AeyriumSensor.sensorEvents.listen((event) {
      if(contor == (lista.length - 1)) {
        _streamSubscriptions.cancel();
        sub.cancel();
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => endPage(corecte, contor)));

      }
      if (event.pitch.toDouble() >= 1 && (contor + 1) < lista.length  && last.difference(DateTime.now()).inSeconds < -2) {
        text = 'guess';
        contor ++;
        corecte ++;
        last = DateTime.now();
      }
      if (event.pitch.toDouble() <= -1 && (contor + 1) < lista.length && last.difference(DateTime.now()).inSeconds < -2 ) {
        text = 'pass';
        contor ++;
        last = DateTime.now();
      }
      setState(() {
          text = text;
          contor = contor;
          _data = "Pitch ${event.pitch} , Roll ${event.roll} $text";
      });
    });
    lista.shuffle();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(189, 178, 255, 1),
      body: Column(
        children: <Widget>[
          Spacer(),
          Center(child: Text(lista[contor] , style: TextStyle(fontSize: 40,fontFamily: 'sf', color: Color.fromRGBO(253, 255, 182,1)),)),
          Spacer(),
          Text(_current.toString() , style: TextStyle(fontSize: 30,fontFamily: 'sf',color: Color.fromRGBO(253, 255, 182,1)),),
        ],
      ),
    );
  }
}
class TeamGamePage extends StatefulWidget {
  @override
  _TeamGamePageState createState() => _TeamGamePageState();
}

class _TeamGamePageState extends State<TeamGamePage> {
  StreamSubscription<dynamic> _streamSubscriptions;
  String text;
  String _data;
  var celeblist;
  int contor = 0;
  int _start = 60;
  int corecte = 0;
  int _current = 60;
  var sub;
  DateTime last = DateTime.now();
  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {

      _streamSubscriptions.cancel();
      print("Done");
      sub.cancel();
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>Intermediar(corecte, contor)));
    });
  }
  void initState() {
    _streamSubscriptions = AeyriumSensor.sensorEvents.listen((event) {
      if(contor == (lista.length - 1)) {
        _streamSubscriptions.cancel();
        sub.cancel();
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => Intermediar(corecte, contor)));

      }
      if (event.pitch.toDouble() >= 1 && (contor + 1) < lista.length  && last.difference(DateTime.now()).inSeconds < -2) {
        text = 'guess';
        contor ++;
        corecte ++;
        last = DateTime.now();
      }
      if (event.pitch.toDouble() <= -1 && (contor + 1) < lista.length && last.difference(DateTime.now()).inSeconds < -2 ) {
        text = 'pass';
        contor ++;
        last = DateTime.now();
      }
      setState(() {
        text = text;
        contor = contor;
        _data = "Pitch ${event.pitch} , Roll ${event.roll} $text";
      });
    });
    lista.shuffle();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(189, 178, 255, 1),
      body: Column(
        children: <Widget>[
          Spacer(),
          Center(child: Text(lista[contor] , style: TextStyle(fontSize: 40,fontFamily: 'sf', color: Color.fromRGBO(253, 255, 182,1)),)),
          Spacer(),
          Text(_current.toString() , style: TextStyle(fontSize: 30,fontFamily: 'sf',color: Color.fromRGBO(253, 255, 182,1)),),
        ],
      ),
    );
  }
}

int gamesPlayed = 0;
class GameWaitingPage extends StatefulWidget {
  String categorie;
  int mode;
  GameWaitingPage(this.categorie , this.mode);
  @override
  _GameWaitingPageState createState() => _GameWaitingPageState();
}

class _GameWaitingPageState extends State<GameWaitingPage> {
  void initState() {
    lista.clear();
    GetList(widget.categorie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.mode == 1)
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => GamePage(widget.categorie)));
        else{
          round = 0;
          g1 = 0;
          g2 = 0;
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  TeamGamePage()));
        }
      },
      child: Scaffold(
        backgroundColor: galbenPastel,
        body: Center(
          child: Text(
            'Apasa pe ecran pentru a incepe jocul!',
            style: TextStyle(fontSize: 40, color :Color.fromRGBO(189, 178, 255, 1),fontFamily: 'sf',),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int mode;
  MyHomePage(this.mode);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _data = "";
  String text = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mode);
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: galbenPastel,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SafeArea(
            child: new Column(
              children: <Widget>[
                Center(
                    child: Text(
                  'Ghicește!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sf',
                  ),
                  textAlign: TextAlign.center,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text('Cele mai jucate' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25,fontFamily: 'sf',),),
                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      physics:const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color.fromRGBO(255, 173, 173, 1),Color.fromRGBO(255, 80, 80, 1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: ButtonTheme(
                              height: 50,
                              buttonColor: Colors.transparent,
                              minWidth: MediaQuery.of(context).size.width * 0.6,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                onPressed: () {
                                  SystemChrome.setPreferredOrientations(
                                      [DeviceOrientation.landscapeLeft]);
                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GameWaitingPage('vloggeri', widget.mode)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text('1' , style: TextStyle(color: galbenPastel , fontSize: 30 , fontFamily: 'sf'),),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Vloggeri',
                                          style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: 'sf',)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color.fromRGBO(160, 196, 255, 1),Color.fromRGBO(110, 164, 255, 1)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: ButtonTheme(
                              height: 50,
                              buttonColor: Colors.transparent,
                              minWidth: MediaQuery.of(context).size.width * 0.6,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                onPressed: () {
                                  SystemChrome.setPreferredOrientations(
                                      [DeviceOrientation.landscapeLeft]);
                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                  Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GameWaitingPage('actori', widget.mode)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text('2' , style: TextStyle(color: galbenPastel , fontSize: 30, fontFamily: 'sf'),),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Actori',
                                          style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: 'sf',)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
