import 'package:flutter/material.dart';
import 'package:quickorder/screens/SplashScreen.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ================= اسم التطبيق =================
      title: "إدارة الطلبات",

      // ================= دعم العربي =================
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },

      // ================= الثيم =================
      theme: ThemeData(
        useMaterial3: true,

        brightness: Brightness.dark,

        fontFamily: "Cairo",

        scaffoldBackgroundColor: const Color(0xff050816),

        primaryColor: Colors.cyanAccent,

        splashFactory: InkRipple.splashFactory,

        // ================= الألوان =================
        colorScheme: ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.blue.shade400,
          surface: const Color(0xff0B1220),
        ),

        // ================= الـ AppBar =================
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,

          backgroundColor: Colors.transparent,

          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),

          iconTheme: const IconThemeData(color: Colors.white, size: 28),
        ),

        // ================= الأزرار =================
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,

            foregroundColor: Colors.black,

            backgroundColor: Colors.cyanAccent,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            textStyle: const TextStyle(
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),

        // ================= Floating Button =================
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.cyanAccent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        // ================= Bottom Navigation =================
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff0B1220),

          selectedItemColor: Colors.cyanAccent,

          unselectedItemColor: Colors.white54,

          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),

          unselectedLabelStyle: TextStyle(fontFamily: "Cairo"),

          type: BottomNavigationBarType.fixed,
        ),

        // ================= حقول الإدخال =================
        inputDecorationTheme: InputDecorationTheme(
          filled: true,

          fillColor: const Color(0xff111827),

          hintStyle: TextStyle(
            color: Colors.white.withOpacity(.45),
            fontFamily: "Cairo",
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.white.withOpacity(.04)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.cyanAccent, width: 1.3),
          ),
        ),

        // ================= الـ SnackBar =================
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xff111827),

          behavior: SnackBarBehavior.floating,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold,
          ),
        ),

        // ================= النصوص =================
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontFamily: "Cairo"),

          bodyMedium: TextStyle(color: Colors.white70, fontFamily: "Cairo"),

          titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ================= البداية =================
      home: const SplashScreen (),
    );
  }
}
