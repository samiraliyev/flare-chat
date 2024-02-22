import 'package:firebase_core/firebase_core.dart';
import 'package:flare_chat_app/Bloc/Authentication/auth_cubit.dart';
import 'package:flare_chat_app/Bloc/Home/home_cubit.dart';
import 'package:flare_chat_app/Bloc/SignIn/sign_in_cubit.dart';
import 'package:flare_chat_app/Bloc/SignUp/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DI/injection.dart';
import 'UI/Pages/Splash/splash_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setup();
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.setBool('logged', false);
  // await prefs.remove('userId');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthCubit()..checkAuth(),
    ),
    BlocProvider(
      create: (context) => SignInCubit(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..fetchMessageItem(),
    ),
    BlocProvider(
      create: (context) => SignUpCubit(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlareChat',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
