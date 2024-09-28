
import 'package:flutter/material.dart';
import 'package:fx_journal/Database.dart';
import 'package:fx_journal/constants/forwardbutton.dart';
import 'package:fx_journal/constants/settingitem.dart';
import 'package:fx_journal/constants/settingswitch.dart';
import 'package:fx_journal/editaccountscreen.dart';
import 'package:fx_journal/home.dart';
import 'package:fx_journal/signin.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Setting extends StatefulWidget {
 final String id;
 Map<String, dynamic>? userData;
  Map<String, dynamic>? profile;
 Setting({required this.userData, required this.id,required this.profile});

  @override
  State <Setting> createState() =>  _SettingState();
}

class  _SettingState extends State <Setting> {

  String imageUrl='';
   final auth = Authservice();
  @override
 void initState() {
    super.initState();
   imageUrl=widget.profile?['profile'] ?? 'https://as2.ftcdn.net/v2/jpg/05/86/91/55/1000_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg';
   print(imageUrl);
  
  }
   
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(id:widget.id)),
    );

          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                     imageUrl.isNotEmpty
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage(imageUrl),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/05/86/91/55/1000_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg"),
                      ),
                    const SizedBox(width: 10),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.userData?['text']?? 'user'}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${widget.userData?['email'] ?? 'user@gmail.com'}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  EditAccountScreen(userData:widget.userData,id:widget.id,profile: widget.profile,),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                value: "enable",
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
        
              SettingItem(
                title: "Logout",
                icon: Ionicons.log_out,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () async{


showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Are you sure want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {

                 await auth.signout();
               SharedPreferences prefs= await SharedPreferences.getInstance();
               prefs.remove('uid');
               Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                
 String username = 'alex1958229@gmail.com';
  String password = 'nevy ymwj ppeb ygkr';
  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  

  // Create our message.
  final message = Message()
    ..from = Address(username, 'FX Journal')
    ..recipients.add('${widget.userData!['email']}')
    ..subject = 'Log out Successful - Team FX Journal'
    ..html = '''
      <h1>Fx Journal -Log in again to continue your journals</h1>
      <p>Your have been logout at ${DateTime.now()}.</p>
      <p>Thank you for choosing FX Journal.<br></br>Team- Fx Jouranl</p>
      <img src="https://images.pexels.com/photos/2072165/pexels-photo-2072165.jpeg" style="width:500px;height:500px" alt="FX Journal Logo">
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




              },
              child: Text("Sure"),
            ),
          ]
        );
      });




                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}