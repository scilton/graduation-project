import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/app_screens/admin_screens/admin_layout/admin_home_layout.dart';
import 'package:graduation_project/app_screens/centers_screens/center_layout/center_home_layout.dart';
import 'package:graduation_project/app_screens/login/login_screen.dart';
import 'package:graduation_project/app_screens/start_screens/splash.dart';
import 'package:graduation_project/app_screens/store_screens/store_layout/store_home_layout.dart';
import 'package:graduation_project/app_screens/volunteer_screens/volunteer_layout/volunteer_home_layout.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';
import 'package:graduation_project/shared/network/remote/dio_helper.dart';
import 'app_screens/start_screens/start_screen.dart';
import 'app_screens/user_screens/user_layout/user_home_layout.dart';


Future <void> firebaseMessagingBackgroundHandles(RemoteMessage message)async
{
  print(message.data.toString());
}


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

    var fcmToken= await FirebaseMessaging.instance.getToken();
print('token :$fcmToken');

FirebaseMessaging.onMessage.listen((event) {
  print(event.data.toString());
});

FirebaseMessaging.onMessageOpenedApp.listen((event) {
  print(event.data.toString());
});

FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandles);

   runApp(
       EasyLocalization(
         path: "assets/language",
       supportedLocales: const [
         Locale('ar'),
         Locale('en'),
       ],
       fallbackLocale: const Locale('en'),
       child: MyApp()));
  DioHelper.init();
  await CashHelper.init();


}

class MyApp extends StatelessWidget {


     MyApp({Key? key}) : super(key: key) ;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routes: {
                'userHome':(context)=>const UserHomeLayout(),
                'centerHome':(context)=>const CenterHomeLayout(),
                'storeHome':(context)=>const StoreHomeLayout(),
                'volunteerHome':(context)=>const VolunteerHomeLayout(),
                'adminHome':(context)=>const AdminHomeLayout(),
                'start':(context)=>const StartScreen(),
                'login':(context)=>const LoginScreen(),
              }
              ,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 1.0,
                color: Colors.white,
                iconTheme: IconThemeData(
                  size: 50.0,
                  color: Colors.black26,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home:   const Splash(),

          );
  }
}
