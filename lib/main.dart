import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasecrud/models/mainpage_post_model.dart';
import 'package:flutterfirebasecrud/models/user_credential.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/services/auth.dart';
import 'package:flutterfirebasecrud/services/database.dart';
import 'package:flutterfirebasecrud/shared/loading.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/app/global_error_widget.dart';
import 'package:get/get.dart';
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
    StreamProvider<User>(
      create: (context) => FirebaseAuth.instance.authStateChanges(),
    ),

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
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  @override
  void initState() {
    context.read<AccountProvider>().isAuthenticated = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Arimo",
          iconTheme: IconThemeData(color: Colors.blue),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(10, 10, 10, 1), elevation: 0.0)),
      home: FutureBuilder(
          future: _initFirebaseSdk,
          builder: (_, snapshot) {
            if (snapshot.hasError) return GlobalErrorWidget();

            if (snapshot.connectionState == ConnectionState.done) {
              // Assign listener after the SDK is initialized successfully
              FirebaseAuth.instance.authStateChanges().listen((User user) {
                if (user == null) {
                  context.read<AccountProvider>().isAuthenticated = false;
                  Get.to(MyMainPage());
                } else {
                  context.read<AccountProvider>().isAuthenticated = true;
                  Get.to(MyMainPage());
                }
              });
            }

            return Loading();
          }),
    );
  }

  // Otherwise, show something whilst waiting for initialization to complete

}
