import 'package:dars_55_home/blocs/restoran_cupit.dart';
import 'package:dars_55_home/firebase_options.dart';
import 'package:dars_55_home/views/screens/home_screen.dart';
import 'package:dars_55_home/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "name",
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context){
            return RestoranCupit();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }

            if (snapshot.hasError)
              return const Text(
                "Xatolik kelilb chiqdi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              );

            print("Bu snapshotdan kelayotgan malumot $snapshot");

            return snapshot.data == null ? const LoginScreen() : const HomeScreen();
          },
        ),
      ),
    );
  }
}
