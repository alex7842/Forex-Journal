import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgot extends StatefulWidget {
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
    TextEditingController forgot_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
     Column(
       children: [
         Container(
                  height: 8, // Adjust as needed
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70.0),
                      topRight: Radius.circular(70.0),
                    ),
                  ),
                ),
       
    
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Recieve an email to reset your password",style: TextStyle(fontSize: 23)),
                      SizedBox(height: 12,),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: forgot_controller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Enter Email',
                            hintText: 'Enter Your Registerd Email',
                            icon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your  registered email';
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
                        child: ElevatedButton(
                          onPressed:() async {
                            showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
                            try{
                            await FirebaseAuth.instance.sendPasswordResetEmail(email:forgot_controller.text.trim());
                             ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text("Email has been Sent to ${forgot_controller.text}"),
                        ),
                      );
                      Navigator.of(context).popUntil((route) =>route.isFirst);
                            }
                            catch(e){
                               ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text("Error occured ${e}"),
                          
                        ),
                      );
                      print("somenting went wrong");
                            }
                          },
                        
                        child: Text("Reset Password")
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ],
     );
  }
}