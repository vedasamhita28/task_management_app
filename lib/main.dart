import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/auth/providers/auth_provider.dart';
import 'package:task_management_app/auth/temp.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/homepage/provider/homepage_provider.dart';
import 'package:task_management_app/router/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  NotificationsInit.initNotifications();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => UserListProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(Duration(seconds: 3));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
            useMaterial3: true,
            textTheme: GoogleFonts.robotoTextTheme(),
            scaffoldBackgroundColor: AppColors.primaryBgColor),
        routerConfig: appRouter);
  }
}
