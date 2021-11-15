import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/screens/update_screen.dart';
import 'package:flutterfirebasecrud/services/package_manager.dart';
import 'package:flutterfirebasecrud/shared/first_connection_app.dart';
import 'package:flutterfirebasecrud/shared/loading.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/states/connectivity_provider.dart';
import 'package:flutterfirebasecrud/widgets/app/global_error_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _a = FirebaseFirestore.instance;
var currentVersion = "0";
bool definitiveUpdate;
bool updateDialog;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black87, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  PackageManager.getVersion();
  await _a.collection('myapp_version').doc("CDO02ebSGzi2f1KJZN5B").get().then(
      (DocumentSnapshot value) {
    debugPrint("_a.collection kısmı burası void main de");
    if (Platform.isAndroid) currentVersion = value['androidversion'];
    definitiveUpdate = value['definitiveupdate'];

    if (Platform.isIOS) currentVersion = value['iosversion'];
    definitiveUpdate = value['definitiveupdate'];
  }).catchError(
      (e) => print("Version getirilirken hata olustu hata : " + e.toString()));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AccountProvider()),
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
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
  Widget defaultPage;
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  @override
  void initState() {
    context.read<AccountProvider>().isAuthenticated = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ConnectivityProvider>().startObserving();
    });
    print(currentVersion);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, provider, _) {
      if (!provider.isOnline) {
        return MaterialApp(
          home: Scaffold(
            body: FirstConnectionApp(),
          ),
        );
      } else {
        return FutureBuilder(
            // Initialize FlutterFire:
            future: _initFirebaseSdk,
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return GetMaterialAppWidget(defaultPage: GlobalErrorWidget());
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                debugPrint("conntection_state kısmı burası");
                if (currentVersion != PackageManager.versionNo) {
                  print(
                      'PackageManager version no =${PackageManager.versionNo.toString()}+"current version =$currentVersion');
                  defaultPage =
                      definitiveUpdate == false ? MyMainPage() : UpdateScreen();
                  updateDialog = true;
                } else {
                  print("IM HERE");
                  updateDialog = false;
                  defaultPage = MyMainPage();
                }
                return GetMaterialAppWidget(
                    theme: ThemeData(
                        fontFamily: "Montserrat",
                        iconTheme: IconThemeData(color: Colors.blue),
                        textTheme: TextTheme(
                          headline1: TextStyle(
                            fontSize: 16.0,
                          ),
                          headline6: TextStyle(
                            fontSize: 16.0,
                          ),
                          bodyText1: TextStyle(fontSize: 14.0),
                          bodyText2: TextStyle(fontSize: 14.0),
                          button: TextStyle(fontSize: 15.0),
                        ),
                        primaryColor: Colors.blue,
                        scaffoldBackgroundColor: Colors.white,
                        appBarTheme: AppBarTheme(
                            backgroundColor: Color.fromRGBO(10, 10, 10, 1),
                            elevation: 0.0)),
                    defaultPage: defaultPage);
              } else {
                print("IM HERE2");
                return GetMaterialAppWidget(defaultPage: Loading());
              }

              // Otherwise, show something whilst waiting for initialization to complete
            });
      }
    });
    // Otherwise, show something whilst waiting for initialization to complete
  }
}

class GetMaterialAppWidget extends StatelessWidget {
  const GetMaterialAppWidget(
      {Key key,
      this.theme,
      @required this.defaultPage,
      this.localizationDelegates})
      : super(key: key);

  final ThemeData theme;
  final Widget defaultPage;

  final localizationDelegates;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: localizationDelegates,

      opaqueRoute: true,
      debugShowCheckedModeBanner: false,
      title: "EA Blog App",
      theme: theme,
      home:
          defaultPage, //GetOfferPremium(data: OfferResponseModel(), bransID: 1),
    );
  }
}
