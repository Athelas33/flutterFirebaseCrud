import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black87, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AccountProvider()),
    //stream provider ile durum yönetimi için firebase eşlenilmesi
    /*  StreamProvider<User>(
      create: (context) => FirebaseAuth.instance.authStateChanges(),
      initialData: AccountProvider.user,
    ) */
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
        context.read<AccountProvider>().isAuthenticated = firebaseUser != null;
        if (firebaseUser == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return GetMaterialApp(
              home: Scaffold(
            body: Center(
              child: Text("Bir hata ile karşılaşıldı."),
            ),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                fontFamily: "Arimo",
                iconTheme: IconThemeData(color: Colors.blue),
                primaryColor: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    backgroundColor: Color.fromRGBO(10, 10, 10, 1),
                    elevation: 0.0)),
            home: MyMainPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return GetMaterialApp(
            home: Scaffold(
          body: Center(
            child: Text("Yükleniyor.."),
          ),
        ));
      },
    );
  }
}
