import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:fx_journal/Database.dart';
import 'package:fx_journal/home.dart';
import 'package:fx_journal/signin.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  TextEditingController name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
   bool _isSigningUp = false;

  @override
  void dispose() {
    super.dispose();
    name_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
                Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 17),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome to Fx Journal",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: name_controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter  Name',
                    hintText: 'Enter Your Name',
                    icon: Icon(Icons.verified_user_sharp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: email_controller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter  Gmail',
                    hintText: 'Enter Your Gmail',
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gmail';
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
                SizedBox(height: 20),
                Builder(
                  builder: (context) {
                    return MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                      
                          _signUp(context);
                        }
                      },
                     child: _isSigningUp ? CircularProgressIndicator() : Text('Sign Up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500)),
                      color: Colors.amberAccent, // Add color to the button
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: Text(
                        "Login",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) async {
     setState(() {
      _isSigningUp = true;
    });
     
    String username = 'alex1958229@gmail.com';
    String password = 'nevy ymwj ppeb ygkr';
   
    final user = await auth.createUserWithEmailAndPassword(
        email_controller.text, password_controller.text);
     
    if (user != null) {
     try{
      print("user created successfully");
      
      
      print(user.uid);
      
       CollectionReference dataCollection3 =
              FirebaseFirestore.instance.collection('data1');

                  
                  CollectionReference tradeCollection3 =
                      dataCollection3.doc(user.uid).collection('profile');

                

                  Map<String, dynamic> tradeData3 = {'profile': 'https://as2.ftcdn.net/v2/jpg/05/86/91/55/1000_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg'};

      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('data1');



      CollectionReference dataCollection1 =
          FirebaseFirestore.instance.collection('data1');

      CollectionReference tradeCollection1 =
          dataCollection1.doc(user.uid).collection('total');

      Map<String,dynamic> tradeData = {
        'profit': '0',
        'loss': '0',
        'lot':'1',
        'twin':'0',
      };
      await tradeCollection1
          .doc('1')
          .set(tradeData)
          .then((value) => {print("total profit/loss data added")})
          .catchError((error) => print("Failed to add trade data: $error"));

      await dataCollection.doc(user.uid).set({
        'text': name_controller.text,
        'email': email_controller.text,
        'balance':'0',
        'password': password_controller.text,
      });
       await tradeCollection3
                        .doc('1')
                        .set(tradeData3)
                        .then((value) =>{ 
                        
            

                          print("Trade Data Added")
                        }
                        
                        
                        )
                        .catchError((error) =>
                            print("Failed to add trade data: $error"));
                   Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(id: user!.uid)),
      );
     
      final smtpServer = gmail(username, password);
      final message = Message()
        ..from = Address(username, 'FX Journal')
        ..recipients.add(email_controller.text)
        ..subject = 'Sign up Successful - Welcome to FX Journal'
        ..html = '''
      <h1>Welcome to FX Journal!</h1>
      <p>Your login was successful. We're excited to have you on board.</p>
      <p>Thank you for choosing FX Journal.</p>
      <img src="https://images.pexels.com/photos/5668859/pexels-photo-5668859.jpeg?auto=compress&cs=tinysrgb&w=600" style="width:500px;height:500px" alt="FX Journal Logo">
      <p>Team - Fx Journal<p/>
      <p>For queries contact email:alex1958229@gmail.com</p>
    ''';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
     }
     catch(e){
      print(e);
     }
     finally{
 setState(() {
        _isSigningUp = false;
      });

     }
    }
    else{
         showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Warning"),
          content: Text("User already exits"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                 setState(() {
        _isSigningUp = false;
      });
 // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } 
    
   
  }
}
