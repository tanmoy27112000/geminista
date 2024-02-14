import 'package:flutter/material.dart';
import 'package:geminista/provider/chat_provider.dart';
import 'package:geminista/screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          useMaterial3: true,
        ),
        title: 'Material App',
        home: const SplashScreen(),
      ),
    );
  }
}
