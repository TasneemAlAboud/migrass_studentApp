import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/feature/ui/Screenes/DrawerScreen/drawer_screen.dart';
import 'package:student/feature/ui/Screenes/Home_Screen/HomeScreen/home_screen.dart';
import 'package:student/feature/ui/Screenes/Login/SplashUi.dart';
import 'package:student/feature/ui/Screenes/MyExam_Screen/MyExamScreen.dart';
import 'package:student/feature/ui/Screenes/MyMarks_Screen/MyMarksScreen.dart';
import 'package:student/feature/ui/Screenes/achivment_screen/my_achivment.dart';
import 'package:student/feature/ui/Screenes/lessons_screen/my_lesson.dart';
import 'core/notifications/firebase_notification.dart';
import 'feature/ui/Screenes/Home_Screen/NavigationScreen.dart';
import 'firebase_options.dart';






void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 // final prefs = await SharedPreferences.getInstance();
 // await prefs.remove('token') ;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home://CustomDrawer(),
      //loginScreen(),
     // HomeScrren(),
    //  NavigationScreen(),
      //Myexamscreen(),
     // Mymarksscreen(),
     // RecordingScreen(),
     // NavigationScreen(),
     // MyAchivment(),
    //  MyLesson( lessonName: "نجوم",
     //   circleId: 3, ),
      SplashScreen(),
      //ChallangeScreen(),
    );
  }
}