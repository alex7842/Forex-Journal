
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fx_journal/Database.dart';
import 'package:fx_journal/constants/edititem.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
   final String id;
 Map<String, dynamic>? userData;
  Map<String, dynamic>? profile;
   EditAccountScreen({required this.userData, required this.id,required this.profile});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";
  String imageUrl='';
  String balance='';

  TextEditingController namecontroller = TextEditingController();
  late TextEditingController accountcontroller;
  @override
 void initState() {
    super.initState();
   imageUrl=widget.profile?['profile'];
   balance=widget.userData?['balance'] ?? '0';
   accountcontroller = TextEditingController(text: balance); // Initialize here
   print(balance);
   print(imageUrl);
  
  }
   void updateUserData(String id,String account) async {
  await Authservice().updateUserData(id,account);
  setState(() {
    // Update UI or perform any necessary actions after data is updated
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async{
   updateUserData(widget.id,accountcontroller.text);
                  CollectionReference dataCollection =
                      FirebaseFirestore.instance.collection('data1');

                  
                  CollectionReference tradeCollection =
                      dataCollection.doc(widget.id).collection('profile');

                

                  Map<String, dynamic> tradeData = {'profile': imageUrl};

                  
                  if (widget.id != null && widget.id.isNotEmpty) {
                    await tradeCollection
                        .doc('1')
                        .set(tradeData)
                        .then((value) =>{ 
                            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data added Succesfully')),
            
          ),
          Navigator.pop(context),
            

                          print("Trade Data Added")
                        }
                        
                        
                        )
                        .catchError((error) =>
                            print("Failed to add trade data: $error"));
                  } else {
                    print("widget.id is null");
                  }
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(60, 50),
                elevation: 3,
              ),
              icon: Icon(Ionicons.checkmark, color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
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
                    TextButton(
                      onPressed: () async {
                         

                        ImagePicker imagePicker = ImagePicker();

                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
               
                if (file == null) {
                     ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No Image Selected')),
          );
                  print("file is null");
                  return;
                }
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                //Create a reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(file.name);

                //Handle errors/success
                try {
                  //Store the file
                  await referenceImageToUpload.putFile(File(file.path));
                  //Success: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  print(imageUrl);
                  setState(() {
                    
                  });
         
                } catch (error) {
                  print("Error uploading image: $error");
                }
                   
                   



                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
               EditItem(
                title: "Account Balance",
                widget: TextField(
                  keyboardType: TextInputType.number,
                  controller: accountcontroller,
                ),
              ),
              const SizedBox(height: 40),
             
              EditItem(
                title: "Gender",
                widget: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "man";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "man"
                            ? Colors.amberAccent
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.male,
                        color: gender == "man" ? Color.fromARGB(255, 0, 0, 0) : Colors.black,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "woman";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "woman"
                            ? Colors.amberAccent
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.female,
                        color: gender == "woman" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    )
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