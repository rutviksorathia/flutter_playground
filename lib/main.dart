import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MaterialApp(
      title: 'Flutter Database Example',
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String count = "0";
  late DatabaseReference countRef;
  bool initialized = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final database = FirebaseDatabase.instance;
    database.setLoggingEnabled(false);
    countRef = database.ref().child("count");

    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    countRef.onValue.listen((event) {
      setState(() {
        count = event.snapshot.value.toString();
      });
    });

    if (!initialized) return Container();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Database Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Hello $count")],
        ),
      ),
    );
  }
}
