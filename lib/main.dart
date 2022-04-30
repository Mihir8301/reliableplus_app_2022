import 'package:reliable_app/splash_screen.dart';
import 'package:reliable_app/utils/my_print.dart';
import 'package:reliable_app/utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reliable_app/controllers/navigation_controller.dart';
import 'package:reliable_app/controllers/providers/connection_provider.dart';
import 'package:reliable_app/controllers/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  MyPrint.printOnConsole("Void main called");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MyPrint.printOnConsole("MyApp Init called");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectionProvider>(create: (_) => ConnectionProvider(), lazy: false,),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider(),),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    MyPrint.printOnConsole("MainApp Init called");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //MyPrint.printOnConsole("MainApp build called");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationController().mainAppKey,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: NavigationController().onGeneratedRoutes,
      theme: ThemeData(
        primaryColor: Styles.primaryColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Styles.primaryColor,
        ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}

