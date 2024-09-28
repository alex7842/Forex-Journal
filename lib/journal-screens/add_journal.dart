import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fx_journal/home.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class AddJournal extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? total ;
  final String id;
  AddJournal({required this.userData, required this.id,required this.total});

  @override
  State<AddJournal> createState() => _AddJournalState();

}

class _AddJournalState extends State<AddJournal> {
   late DateTime now;
  late String currentday;
  late String currentdate;

   final _formKey = GlobalKey<FormState>();
   TextEditingController tpController = TextEditingController();
   TextEditingController entryController = TextEditingController();
TextEditingController slController = TextEditingController();
   TextEditingController profitController = TextEditingController();
TextEditingController lossController = TextEditingController();
TextEditingController notesController = TextEditingController();
TextEditingController balanceController = TextEditingController();
TextEditingController lotController = TextEditingController(text: '1');
 String? _selectedValue;
 String? _selectedpair;
 String? _selectedtime;
  String? imageUrl='';
  String? imageUrl1='';
  
bool isTpEnabled = true;
bool isSlEnabled = true;
bool isprofitEnabled = true;
bool islossEnabled = true;
 FocusNode tpFocusNode = FocusNode();
FocusNode slFocusNode = FocusNode();
@override
void initState() {
 super.initState();
 now = DateTime.now();
 print(widget.id);
    currentday = DateFormat('EEEE').format(now);
   currentdate=DateFormat("MMM d, yyyy").format(now);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Journal"),
        backgroundColor: Colors.amberAccent,
        leading: IconButton(
          onPressed: (){

             Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(id:widget.id)),
      );
        }, icon: Icon(Icons.arrow_back_ios)),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: GlobalKey<FormBuilderState>(),
            child: Column(
              children: [
                 TextFormField(
      decoration: const InputDecoration(labelText: 'Today\'s Date',),
      initialValue: currentdate,
      readOnly: true,
    ),
    SizedBox(height: 12,),
    // Day
    TextFormField(
      decoration: const InputDecoration(labelText: 'Day'),
      initialValue: currentday,
     readOnly: true,
    ),
    SizedBox(height: 15,),
     TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Account Balance',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
      borderSide: const BorderSide(color: Colors.amberAccent), // Border color
    ),
    prefixIcon: const Icon(Icons.attach_money), // Icon on the left side
    suffixIcon: const Icon(Icons.check), // Icon on the right side
 ),
      
      controller: balanceController,
       validator: (value) {
     if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
 },
      // Add validation here
    ),
    const SizedBox(height: 8,),
    // Forex Currency Pairs
    
    // Buy/Sell Radio Button
    Column(
      children: [

        // Entry Point
   
        RadioListTile<String>(
          title: const Text('Buy'),
          value: 'Buy',
          groupValue: _selectedValue,
          onChanged: (String? value) {
            setState(() {
              _selectedValue = value;
               print(_selectedValue);
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Sell'),
          value: 'Sell',
          groupValue: _selectedValue,
          onChanged: (String? value) {
            setState(() {
              _selectedValue = value;
              print(_selectedValue);
            });
          },
        ),
      ],
    ),

    SizedBox(height: 10,),
    
       Row(
       
        children: [
         
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                     decoration: InputDecoration(labelText: 'Lot Size',
                     
                     border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10), // Rounded corners
                     borderSide: const BorderSide(color: Colors.amberAccent), // Border color
                   ),
                   prefixIcon: const Icon(Icons.line_axis_sharp), // Icon on the left side
                    // Icon on the right side
                ),
                     
                     controller: lotController,
                   
                     // Add validation here
                   ),
            ),
           
        
      SizedBox(width: 12,),
      Expanded(
        child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Choose Time Frame'),
            items: <String>[
          '1m', 
          '3m', 
          '5m', 
          '15m',
          '30m',
          '1hr',
          '2hr',
          '4hr',
          'Day',
          'W',
           ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              _selectedtime=newValue;
             print(_selectedtime);
                   },
          ),
      ),
      
        ],
      
      ),
    
SizedBox(height: 13,),
    DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Choose Currency Pair'),
      items: <String>[
    'EUR/USD', 
    'GBP/USD',
    'AUD/USD', 
    'NZD/USD', 
     'XAU/USD',
     'USD/JPY', 
    'USD/CHF', 
    'USD/CAD', 
     'CAD/USD',
    'EUR/GBP', 
    'EUR/AUD', 
    'GBP/JPY', 
    'AUD/JPY', 
    'EUR/CAD', 
    'NZD/JPY', 
    'GBP/AUD',
    'EUR/JPY',
    'AUD/NZD',
    'AUD/CAD',
    'EUR/CHF',
    'GBP/AUD',
    'US30' ]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        _selectedpair=newValue;
       print(_selectedpair);
             },
    ),
    const SizedBox(height: 13,),
    // Entry Point
    TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Entry Point',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), // Rounded corners
      borderSide: const BorderSide(color: Colors.amberAccent), // Border color
    ),
    prefixIcon: const Icon(Icons.input), // Icon on the left side
    
 ),
      
      controller: entryController,
       validator: (value) {
     if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
 },
      // Add validation here
    ),
    const SizedBox(height: 8,),
    // TP and SL
    Row(
      children: [
        Expanded(
          child:TextFormField(
             controller: tpController,
            keyboardType: TextInputType.number,
            
            decoration: InputDecoration(labelText: 'Target',border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.amberAccent),
    ),
    prefixIcon: const Icon(Icons.arrow_upward),),
            //enabled: isprofitEnabled,
            // Add validation here
          ), 
        ),
        const SizedBox(width: 8),
        Expanded(
          child:TextFormField(
             controller: slController,
            keyboardType: TextInputType.number,
           
            decoration: InputDecoration(labelText: 'StopLoss',border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.amberAccent),
    ),
    prefixIcon: const Icon(Icons.exit_to_app_outlined),),
          
          ),
        ),
      ],
    ),
     const SizedBox(height: 8,),
    // Profit and Loss
    Row(
      children: [
        Expanded(
          child: TextFormField(
             controller: profitController,
             keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Profit',border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.amberAccent),
    ),
    prefixIcon: const Icon(Icons.attach_money),),
            //enabled: isprofitEnabled,
            // Add validation here
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
             controller: lossController,
               keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Loss',border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.amberAccent),
    ),
    prefixIcon: const Icon(Icons.money_off),),
           // enabled: islossEnabled,
            // Add validation here
          ),
        ),
      ],
    ),
     const SizedBox(height: 8,),
    // Notes
    Column(
      children: [
        TextFormField(
          controller: notesController,
          decoration: InputDecoration(labelText: 'Notes',border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.amberAccent),
        ),
          ),
          maxLines: 5,
          // Add validation here
        ),
        const SizedBox(height: 15), // Add some space between the TextFormField and the buttons
    Row(

      children: [ 
       Column(
         children: [
           OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                // Set the background color
               
               side: const BorderSide(color: Color.fromARGB(255, 32, 32, 32), width: 2), // Set the border color and width
            ),
            onPressed: () async {
                String id3=randomAlphaNumeric(5);
                 ImagePicker imagePicker = ImagePicker();
                        
                     XFile? file =
                            await imagePicker.pickImage(source: ImageSource.gallery);
                       // print('${file?.path}');
                           if (file == null){
                            print("file is null");
                            return;
                           }
                         
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
           
                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child('${id3}.jpg');
           
                        //Handle errors/success
                        try {
                          //Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          //Success: get the download URL
                          imageUrl = await referenceImageToUpload.getDownloadURL();
                          print(imageUrl);
                           setState(() {});
                     
                        } catch (error) {
                         print("Error uploading image: $error");
                        }
           
                  
              // Handle before image upload
            },
            icon: const Icon(Icons.image,color: Colors.black,),
            label: const Text('Before'),
                 ),
                   const SizedBox(height: 13,),
           
         ],
       ),
    
    const SizedBox(width: 100,), // Add some space between the buttons
   Column(
     children: [
       OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
        // backgroundColor: Colors.amberAccent, // Set the background color
        side: const BorderSide(color: Color.fromARGB(255, 37, 37, 37), width: 2), // Set the border color and width
        ),
          onPressed: () async{
              String id2=randomAlphaNumeric(5);
                ImagePicker imagePicker = ImagePicker();
                        
                     XFile? file =
                            await imagePicker.pickImage(source: ImageSource.gallery);
                       // print('${file?.path}');
                           if (file == null){
                            print("file is null");
                            return;
                           }
                 
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');
       
                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child('${id2}.jpg');
       
                        //Handle errors/success
                        try {
                          //Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          //Success: get the download URL
                           imageUrl1 = await referenceImageToUpload.getDownloadURL();
                          print(imageUrl1);
                           setState(() {});
                        
                        } catch (error) {
                         print("Error uploading image: $error");
                        }
       
                  
            // Handle after image upload
          },
          icon: const Icon(Icons.image,color: Colors.black,),
          
          label: const Text('After'),
        ),
        const SizedBox(height: 13,),
       
     ],

   ),
      ],
    ),
       
      ],

    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageUrl!.isNotEmpty? Container(
                  height: 80,
                  width:80,
                  decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
                ):Container(
                
                ),

                  imageUrl1!.isNotEmpty? Container(
              height: 80,
              width:80,
              decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl1!),
            fit: BoxFit.cover,
          ),
        ),
            ):Container(
            
            ),
        ],
        
      ),

      
    const SizedBox(height: 10,),

    Text("Wait until image is loaded on screen",style: TextStyle(color: Colors.grey),),
    const SizedBox(height: 10,),
    
    TextButton(
  onPressed: () async{
   // if (_formKey.currentState!.validate()) {
// Create a reference to the 'data1' collection
showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Data cannot be modified after submission."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {

 
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data added Successfully')));
            showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Data added Succesfully"),
          content: const Text("Data added to reports"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Okay"),
            ),
           
          ],
        );
      }
            );

int tprofit = (int.tryParse(widget.total?['profit'] ?? '0') ?? 0) + (int.tryParse(profitController.text) ?? 0);
int tloss = (int.tryParse(widget.total?['loss'] ?? '0') ?? 0) + (int.tryParse(lossController.text) ?? 0);
int tlot = (int.tryParse(widget.total?['lot'] ?? '0') ?? 0) + (int.tryParse(lotController.text) ?? 0);
int twin = (int.tryParse(widget.total?['twin'] ?? '0') ?? 0);
if (profitController.text.isNotEmpty){
  twin=twin+1;
}

// Convert the results to strings
String tprofitString = tprofit.toString();
String tlossString = tloss.toString();
String tlotString = tlot.toString();
String twinString = twin.toString();

      CollectionReference dataCollection1 =
          FirebaseFirestore.instance.collection('data1');

      CollectionReference tradeCollection1 =
          dataCollection1.doc(widget.id).collection('total');

      Map<String, dynamic> tradeData1 = {
        'profit': tprofitString,
        'loss': tlossString,
        'lot':tlotString,
        'twin':twinString,
      };
      await tradeCollection1
          .doc('1')
          .set(tradeData1)
          .then((value) => {print("total profit/loss data added")})
          .catchError((error) => print("Failed to add trade data: $error"));
                
        CollectionReference dataCollection = FirebaseFirestore.instance.collection('data1');

 // Create a reference to the 'trade' subcollection under the user document
  String id1=randomAlphaNumeric(5);
 CollectionReference tradeCollection = dataCollection.doc(widget.id).collection('trade');

 Map<String, dynamic> tradeData  = {
  'balance':balanceController.text.isEmpty ?"null":balanceController.text,
  'timeframe':_selectedtime ?? '',
  'lotsize':lotController.text.isEmpty ?"null":lotController.text,
  'tp': tpController.text.isEmpty ? "null" : tpController.text,
 'date': currentdate,
 'day': currentday,
 'notes': notesController.text.isEmpty ? "null" : notesController.text,
 'profit': profitController.text.isEmpty ? "null" : profitController.text,
 'loss': lossController.text.isEmpty ? "null" : lossController.text,
 'sl': slController.text.isEmpty ? "null" : slController.text,
 'before': imageUrl1 ?? '',
 'after': imageUrl ?? '',
 'pair': _selectedpair ?? '',
 'entry': entryController.text.isEmpty ? "null" : entryController.text,
 'buy/sell': _selectedValue ?? '',
 };

 // Add the new document with the user ID as the document name
if (widget.id != null && widget.id.isNotEmpty && _selectedpair!=null ) {
  if(_selectedValue!=null){
  await tradeCollection.doc(id1).set(tradeData).then((value) => print("Trade Data Added"))
      .catchError((error) => print("Failed to add trade data: $error"));
  }
  else{
     ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Select Buy/Sell')),
          );

  }
} else {
  print("widget.id is null");
   ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Select an currency pair')),
          );
}

                Navigator.pop(context);
                 ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data added Successfully')),
          ); // Close the dialog
              },
              child: const Text("Submit"),
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
    foregroundColor:  MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0))
  
      
    ),
            ),
          ],
        );
      },
    );
 
     
    //}
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
    foregroundColor: MaterialStateProperty.all(Colors.black),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  child: const Text('Submit'),
)
                // Your form fields go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
