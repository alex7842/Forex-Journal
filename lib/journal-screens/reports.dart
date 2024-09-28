import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fx_journal/Database.dart';
import 'package:fx_journal/home.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:photo_view/photo_view.dart';

class Report extends StatefulWidget {
  final String id;
  Report({required this.id});

  @override
  State<Report> createState() => _Report();
}

class _Report extends State<Report> {
  //late Stream<QuerySnapshot> _tradeDataStream;

  @override
  void initState() {
    super.initState();
  }

  Future<QuerySnapshot> getTradeData() async {
    return FirebaseFirestore.instance
        .collection('data1')
        .doc(widget.id)
        .collection('trade')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Journals'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(id: widget.id)),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: TradeList(id: widget.id),
      ),
    );
  }
}

class TradeList extends StatefulWidget {
  final String id; // Make sure to pass the userUID to this widget

  TradeList({required this.id});

  @override
  State<TradeList> createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  Future<QuerySnapshot> getTradeData() async {
    return FirebaseFirestore.instance
        .collection('data1')
        .doc(widget.id)
        .collection('trade')
        .get();
  }
@override
Widget build(BuildContext context) {
  return FutureBuilder<QuerySnapshot>(
    future: getTradeData(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.done) {
        List<DocumentSnapshot> docs = snapshot.data!.docs;

        // Check if there are documents to sort
        if (docs.isNotEmpty) {
          // Sort documents by date
         docs.sort((a, b) {
  String dateA = a['date'];
  String dateB = b['date'];

  // Splitting the date strings
  List<String> partsA = dateA.split(' ');
  List<String> partsB = dateB.split(' ');

  // Reformatting for comparison
  String formattedDateA = '${partsA[2]}-${partsA[0]}-${partsA[1]}'; // "YYYY-MM-DD"
  String formattedDateB = '${partsB[2]}-${partsB[0]}-${partsB[1]}'; // "YYYY-MM-DD"

  // Comparing the reformatted date strings
  return formattedDateA.compareTo(formattedDateB); // Ascending order
});

        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot doc = docs[index];
            Map<String, dynamic> trade = doc.data() as Map<String, dynamic>; // Now 'trade' reflects the sorted data
            String tradeDocId = doc.id;


                    return ExpansionTile(
                      backgroundColor: Color.fromARGB(255, 248, 244, 173),
                      title: Text(
                        trade['pair'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(trade['date'] ?? ''),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Buy/sell : ${trade["buy/sell"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "Timeframe : ${trade["timeframe"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Entry point : ${trade["entry"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "lots : ${trade["lotsize"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Target : ${trade["tp"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "Stop loss : ${trade["sl"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Profit : ${trade["profit"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "Loss : ${trade["loss"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Balance: ${trade["balance"] ?? ''}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text("Before"),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 70,
                                          width: 80,
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .transparent, // Set background color to transparent
                                          ),
                                          child: Stack(
                                            children: [
                                              if (trade['after'] != null &&
                                                  trade['after'].isNotEmpty)
                                                Positioned.fill(
                                              child: InstaImageViewer(
 child: ClipRect(
    child: Image.network(
      trade['after'],
      fit: BoxFit.cover,
    ),
 ),
),

                                                   
                                                  
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text("after"),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 70,
                                          width: 80,
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .transparent, // Set background color to transparent
                                          ),
                                          child: Stack(
                                            children: [
                                              if (trade['before'] != null &&
                                                  trade['before'].isNotEmpty)
                                                Positioned.fill(
                                                    child: InstaImageViewer(
 child: ClipRect(
    child: Image.network(
      trade['before'],
      fit: BoxFit.cover,
    ),
 ),
),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                             Padding(
  padding: const EdgeInsets.all(1.0),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 600, // Consider making this dynamic based on screen size or wrapping in an Expanded widget if inside a Flex widget like Column/Row
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible( // Wrap your Text widget with Flexible
            child: Text(
              "Notes: ${trade["notes"]?? ''}",
              style: const TextStyle(fontSize: 16),
              // Optional: Use this if you want to show '...' when text overflows
            ),
          ),
          // Add other widgets here if needed
        ],
      ),
    ),
  ),
),

                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text("Are you sure"),
                                              content: const Text(
                                                  "Trade data will Permanently Deleted"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: const Text("cancel"),
                                                ),
                                                TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .amberAccent)),
                                                  onPressed: () {
                                                    Authservice()
                                                        .deleteTradeDocument(
                                                            widget.id,
                                                            tradeDocId);
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Data Deleted Successfully')),
                                                    );
                                                    // Close the ExpansionTile
                                                  },
                                                  child: const Text("Sure"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
      );}else{

               Center(
                  child: Container(
                    height: 300,
                    width: 320,
                    child: Image.asset(
                      'assets/images/empty.jpg',
                    ),
                  ),
                );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
