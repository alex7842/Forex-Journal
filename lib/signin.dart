import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fx_journal/Database.dart';


import 'package:fx_journal/home.dart';
import 'package:fx_journal/main.dart';


import 'package:fx_journal/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
    final auth=Authservice();

   final _formKey = GlobalKey<FormState>();

TextEditingController password_controller=TextEditingController();

TextEditingController email_controller=TextEditingController();
 bool _isSigningUp = false;

@override
void dispose() {
    // TODO: implement dispose
    super.dispose();
  
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
          },
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),


        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text("Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    Text("Login to your account",
                    style: TextStyle(
                      fontSize: 15,
                    color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                       Form(
            key: _formKey,
            child: Center(
              child: Column(
                
                 mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 // SizedBox(height: 100,),
                
                  TextFormField(
                    controller: email_controller,
                    keyboardType: TextInputType.emailAddress,
                     decoration: const InputDecoration(
                        labelText: 'Enter  Email',
                        hintText: 'Enter Your Email',
                        icon: Icon(Icons.email),
                      ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: password_controller,
                      obscuringCharacter: "*",
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter password',
                        hintText: 'Enter Your password',
                        icon: Icon(Icons.password_rounded),
                      ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                 
                 
                  
                  
                  
                ],
              ),
            ),
          ),
                    ],
                  ),
                ),
                  Padding(padding:
                  const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),

                          )



                        ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed:() {
                            if (_formKey.currentState!.validate()) {
                          
                            _signin(context);
                          }
                        },
                        color:Colors.amberAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                       child: _isSigningUp ? CircularProgressIndicator() : Text('Login', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color.fromARGB(255, 2, 2, 2),

                        ),
                        ),

                      ),
                    ),
                  ),


                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
               
                  children: <Widget>[
                   
                    InkWell(
                      onTap: () {
                         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Signup(),
          ));
                      },
                      child: Text(" Sign up", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      
                      ),),
                    ),
                    SizedBox(width: 96,),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Allows the bottom sheet to take full height when the keyboard appears
              builder: (context) => ForgotPasswordSheet(),
            );
                      },
child: Text("Forgot password ?",style: TextStyle(fontWeight: FontWeight.w500,),),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/content.png"),
                      fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }
//re
//re@gmail.com
//123456
//20
  void _signin(BuildContext context) async {
    final user = await auth.loginWithEmailAndPassword(
        email_controller.text, password_controller.text);
    if (user != null) {
       setState(() {
      _isSigningUp = true;
    });
      try{
      print("login sucesss");
     
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('uid', user.uid)
;   
   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(id:user.uid,),
          ));
      }
      catch(e){
        print(e);
      }
      finally{
         setState(() {
        _isSigningUp = false;
      });
      }
    } else {
      print("something error happend");
      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Invalid Password"),
                            content: Text("Password does not match"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
     
      
    }
  }

}

class ForgotPasswordSheet extends StatefulWidget {
  @override
  _ForgotPasswordSheetState createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController forgotController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Adjust padding to accommodate the keyboard
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Receive an email to reset your password",
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: forgotController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      hintText: 'Enter Your Registered Email',
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your registered email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: forgotController.text.trim());
                        Navigator.of(context).pop(); // Dismiss the progress dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Success"),
                            content: Text(
                                "Email has been Sent to ${forgotController.text}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        Navigator.of(context).pop(); // Dismiss the progress dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text("An error occurred: $e"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                        }
                      },
                      child: Text("Send Email",style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent,shadowColor: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//         child: Form(
//           key: _formKey1,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Receive an email to reset your password",
//                 style: TextStyle(fontSize: 23),
//               ),
//               SizedBox(height: 12),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: forgot_controller,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Email',
//                     hintText: 'Enter Your Registered Email',
//                     icon: Icon(Icons.email),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your registered email';
//                     }
//                     if (!value.contains('@') || !value.contains('.')) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(12),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     showDialog(
//                       context: context,
//                       builder: (context) => Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                     try {
//                       await FirebaseAuth.instance
//                           .sendPasswordResetEmail(email: forgot_controller.text.trim());
//                       Navigator.of(context).pop(); // Dismiss the progress dialog
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text("Success"),
//                           content: Text(
//                               "Email has been Sent to ${forgot_controller.text}"),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the dialog
//                                 Navigator.of(context).popUntil((route) => route.isFirst);
//                               },
//                               child: Text("OK"),
//                             ),
//                           ],
//                         ),
//                       );
//                     } catch (e) {
//                       Navigator.of(context).pop(); // Dismiss the progress dialog
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text("Error"),
//                           content: Text("An error occurred: $e"),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the dialog
//                               },
//                               child: Text("OK"),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                   child: Text("Send Email"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );