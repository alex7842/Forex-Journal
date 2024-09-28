import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fx_journal/settings.dart';
import 'package:fx_journal/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fx_journal/Database.dart';
import 'package:fx_journal/coinlist.dart';
import 'package:fx_journal/component/Category.dart';
import 'package:fx_journal/component/seachtextfield.dart';
import 'package:fx_journal/constants.dart';
import 'package:fx_journal/journal-screens/add_journal.dart';
import 'package:fx_journal/journal-screens/dashboard.dart';
import 'package:fx_journal/journal-screens/reports.dart';
import 'package:fx_journal/signin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:fx_journal/constants/size.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String id;
  Home({required this.id});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  Map<String, dynamic>? userData;
  Map<String, dynamic>? profile;
  Map<String, dynamic>? total;
  // Define getUserData method here
  


  @override
  void initState() {
    super.initState();
    getUserData();
    gettotalData();
  }
  Future<void> gettotalData() async {
  
CollectionReference dataCollection1 = FirebaseFirestore.instance.collection('data1');


CollectionReference tradeCollection1 = dataCollection1.doc(widget.id).collection('total');


DocumentSnapshot<Map<String, dynamic>> snapshot2 = await tradeCollection1.doc("1").get() as DocumentSnapshot<Map<String, dynamic>>;
setState(() {
  
  total=snapshot2.data();

});

 }
 Future<void> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("data1")
        .doc(widget.id)
        .get();

CollectionReference dataCollection = FirebaseFirestore.instance.collection('data1');


CollectionReference tradeCollection = dataCollection.doc(widget.id).collection('profile');


DocumentSnapshot<Map<String, dynamic>> snapshot1 = await tradeCollection.doc("1").get() as DocumentSnapshot<Map<String, dynamic>>;




// CollectionReference dataCollection1 = FirebaseFirestore.instance.collection('data1');


// CollectionReference tradeCollection1 = dataCollection1.doc(widget.id).collection('total');


// DocumentSnapshot<Map<String, dynamic>> snapshot2 = await tradeCollection1.doc("1").get() as DocumentSnapshot<Map<String, dynamic>>;



setState(() {
  userData = snapshot.data();
  profile = snapshot1.data(); 
 
 
 
});
  }
 

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            Appbar(userData: userData,total:total),
            Container(
              child: Body(userData: userData, id: widget.id,total: total,),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
        drawer: MyDrawer(userData: userData, id: widget.id,profile:profile),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Bottom(userData: userData, id: widget.id,profile: profile,total:total)),
      ),
    );
  }
}

class Bottom extends StatefulWidget {
  final Map<String, dynamic>? userData;

  Map<String, dynamic>? profile;
  Map<String, dynamic>? total;
  final String id;
  Bottom({required this.userData, required this.id,required this.profile,required this.total});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: MotionTabBar(
        initialSelectedTab: "Home",
        useSafeArea: true,
        labels: ["Home", "Journal", "Settings"],
        icons: const [Icons.home, Icons.dashboard, Icons.settings],
        badges: [
          const MotionBadgeWidget(),
          Container(),
          const MotionBadgeWidget(
            isIndicator: true,
            color: Colors.red,
            size: 5,
            show: true,
          ),
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.black,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: const Color.fromARGB(255, 64, 255, 236),
        tabIconSelectedColor: const Color.fromARGB(255, 1, 0, 0),
        tabBarColor: const Color.fromARGB(255, 237, 237, 237),
        onTabItemSelected: (int value) {
          if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Setting(userData:widget.userData,id:widget.id,profile: widget.profile,)),
            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddJournal(userData: widget.userData,id: widget.id,total: widget.total,)),
            );
          }
        },
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? total;
  final String id;
  Body({required this.userData, required this.id,required this.total});
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double bot = MediaQuery.of(context).viewInsets.bottom + 10;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore Categories",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                      onPressed: () {
          //                Navigator.push(
          // context,
          // MaterialPageRoute(
          //   builder: (context) => Signup(),
          // ));
                      },
                      child: Text(
                        "See All",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: kPrimaryColor),
                      ),
                    )
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.999,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: categoryList[index],
                    id: widget.id,
                    userData: widget.userData,
                    index: index,
                    total:widget.total,
                  );
                },
                itemCount: categoryList.length,
              ),
              SizedBox(height: bot),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? total;
  final String id;
  int index;
  CategoryCard({required this.userData, required this.category, required this.id, required this.index,required this.total});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddJournal(userData:userData,id: id,total: total,)));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard(id:id,total:total,userData: userData,)));
        } else if (index == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoinList(id: id),
              ));
        } else if (index == 3) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Report(id: id)));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ), //BoxShadow
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  category.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }
}

class Appbar extends StatefulWidget {
  @override
  State<Appbar> createState() => _AppbarState();
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? total;

  Appbar({required this.userData,required this.total});
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 192,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 242, 255, 0),
            Color.fromARGB(255, 34, 251, 255),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",style: TextStyle(fontSize: 24),),
                     Text("${widget.userData?['text'] ?? 'Guest'}".toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
                ],
              ),
               
              Container(
                height: 50,
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/user 11.png'),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SearchTextField(total:widget.total),
        ],
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
  final String id;
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? profile;

  MyDrawer({required this.userData, required this.id,required this.profile});
}

class _MyDrawerState extends State<MyDrawer> {
  final auth = Authservice();
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
   imageUrl=widget.profile?['profile'] ??'https://as2.ftcdn.net/v2/jpg/05/86/91/55/1000_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg';
   print(imageUrl);
  
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            
            accountName: Text('${widget.userData?['text'] ?? 'user'}'.toUpperCase(),style: TextStyle(fontSize: 15),),
            accountEmail: Text("${widget.userData?['email']?? 'user@gmail.com'}",style: TextStyle(fontSize: 15),),
            currentAccountPicture: Stack(
              children: [

                imageUrl.isNotEmpty
                    ? CircleAvatar(
                        radius: 68,
                        backgroundImage:NetworkImage(imageUrl),
                      )
                    : const CircleAvatar(
                        radius: 68,
                        backgroundImage: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/05/86/91/55/1000_F_586915596_gPqgxPdgdJ4OXjv6GCcDWNxTjKDWZ3JD.jpg"),
                      ),
         
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
                   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Report(id: widget.id,)),
    );
            },
            child: ListTile(
              title: const Text("Reports"),
              leading: IconButton(
                onPressed: ()  {
            
                },
                icon: const Icon(Icons.book),
              ),
            ),
          ),
          const Divider(
            height: 2.0,
          ),
          GestureDetector(
            onTap: (){
    //            Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Home(id:user!.uid)),
    // );
            },
            child: ListTile(
              title: const Text("Contact Us"),
              leading: IconButton(
               
                onPressed: () async{
               
                },
                icon: const Icon(Icons.contact_mail_outlined),
              ),
            ),
          ),
          const Divider(
            height: 2.0,
          ),
             GestureDetector(
              onTap: (){
                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Setting(userData:widget.userData,id:widget.id,profile: widget.profile,)),
                 );
              },
               child: ListTile(
                           title: const Text("Settings"),
                           leading: IconButton(
                onPressed: ()  {
                
               
                },
                icon: const Icon(Icons.settings),
                           ),
                         ),
             ),
          const Divider(
            height: 2.0,
          ),
          // Add more list items here as needed
        ],
      ),
    );
  }
}

















        //  ElevatedButton(
        //        onPressed: () async
        //       {
        //        await auth.signout();
        //        SharedPreferences prefs= await SharedPreferences.getInstance();
        //        prefs.remove('email');
        //        Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => SignIn(),
        //               ),
        //             );

        //       },
        //       child: Text("Sign out")

             
        //     ),









