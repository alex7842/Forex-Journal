
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

import 'package:fx_journal/constants.dart';
import 'package:fx_journal/home.dart';
import 'package:fx_journal/signin.dart';
import 'package:fx_journal/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCWE430mRK4oApYTYM01sBNwtT0IKv2afY",
      appId: "1:245020719482:android:cb9b10611f83bf5acbbec3",
      messagingSenderId: "245020719482",
      projectId: "fx-journal-99b8b",
       storageBucket: "fx-journal-99b8b.appspot.com",
    ),
 );
  await FirebaseAppCheck.instance.activate(
   
  
    androidProvider: AndroidProvider.playIntegrity,
   
    appleProvider: AppleProvider.appAttest,
  );
//     await FirebaseAppCheck.instance.activate(
//     androidProvider: AndroidProvider.playIntegrity,
//  );
 SharedPreferences prefs= await SharedPreferences.getInstance();
 var e=prefs.getString('uid');
 print(e);
  runApp(MaterialApp(home: e==null ?Welcome():Home(id: e)));
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // color: Colors.amber[100],
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 100,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: 70,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Welcome User'.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                  Image.asset(
                  "assets/images/undraw.png",
                      width: 360,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amberAccent),  
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white60),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(66),
                            ),
                          )
                         
                        ),
                        child: Text(
                          'Login'.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryLightColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white60),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(66),
                            ),
                          ),
                        ),
                        child: Text(
                          'Signup'.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}