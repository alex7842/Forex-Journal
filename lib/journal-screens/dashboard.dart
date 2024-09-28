import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fx_journal/home.dart';
import 'package:intl/intl.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashBoard extends StatefulWidget {
   final Map<String, dynamic>? total;
   final Map<String, dynamic>? userData;
  final String id;
  DashBoard({required this.id, required this.total,required this.userData});


  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard > {
    late DateTime now;
  late String currentMonth;
  late int tprofit;
  late int tloss;
  late int tlot;
 
  late double profitPercentage;
  late double lossPercentage;

  late  double winRate;
  late String formattedProfitAccuracy;
  late int  netProfitLoss;
  late double profit;
  late double loss;
  late int twin;
  late String formattedProfitPercentage;
  late String formattedLossPercentage;
  late String formattedWinRate;
  late double profitAccuracy;
  late int tbalance;
  late   int totalTrades;
  


   //re@gmail.com

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    currentMonth = DateFormat('MMMM').format(now);
     print("Current month: $currentMonth");
   tprofit = (int.tryParse(widget.total?['profit'] ?? '0') ?? 0);
tloss = (int.tryParse(widget.total?['loss'] ?? '0') ?? 0);
tlot = (int.tryParse(widget.total?['lot'] ?? '1') ?? 1);
twin = (int.tryParse(widget.total?['twin'] ?? '0') ?? 0);
tbalance = (int.tryParse(widget.userData?['balance'] ?? '0') ?? 0);
  profitPercentage = tbalance != 0 ? (tprofit / tbalance) * 100 : 0;
 lossPercentage = tbalance != 0 ? (tloss / tbalance) * 100 : 0;
 winRate = tlot != 0 ? ((twin / tlot) * 100)/1000 : 0;

// Calculate total trades
 totalTrades = (twin + tloss);

// Calculate profit accuracy
 profitAccuracy = totalTrades != 0 ? ((tprofit / totalTrades) * 100) / 1000 : 0;

// Clamp the values between 0 and 1
profitPercentage = max(0, min(100, profitPercentage));
lossPercentage = max(0, min(100, lossPercentage));
winRate = max(0, min(100, winRate));
profitAccuracy = max(0, min(100, profitAccuracy));

// Format to two decimal places
 formattedProfitPercentage = profitPercentage.toStringAsFixed(2);
 formattedLossPercentage = lossPercentage.toStringAsFixed(2);
 formattedWinRate = winRate.toStringAsFixed(2);
 formattedProfitAccuracy = profitAccuracy.toStringAsFixed(2);


print("Profit: $tlot");
print("Profit Percentage: $formattedProfitPercentage%");
print("Loss Percentage: $formattedLossPercentage%");
print("Win Rate: $formattedWinRate%");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: IconButton(onPressed: 
        (){
             Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home(id: widget.id)),
      );
        }, icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:3,bottom: 18,top:17),
                  child: Row(
                    children: [
                  const Text("Current Month : ",style: TextStyle(fontSize: 21)),
                  Text("${currentMonth}",style: const TextStyle(fontSize: 21,))
                    ]),
                ),
                Container(
                decoration: const BoxDecoration(
                  
                    
                    borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0), // Adjust the radius as needed
                bottomRight: Radius.circular(10.0), // Adjust the radius as needed
                    ),
                  ),
                 height: 260,
                 child: ListView(
                  
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true, // Use shrinkWrap to ensure the ListView takes only the necessary space
                    children: <Widget>[
                Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                   // Matching background color
                  child: Tooltip(
                    message: "Progress ${formattedProfitPercentage}%", // Tooltip message
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text("Total Profit",style: TextStyle(fontSize: 19,color:Color.fromARGB(255, 0, 0, 0))),
                          const SizedBox(height: 6,),
                         CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          radius: 90,
                          lineWidth: 21,
                          percent: profitPercentage/100,
                          progressColor: const Color.fromARGB(255, 8, 164, 71),
                          backgroundColor: const Color.fromARGB(255, 78, 199, 121),
                          circularStrokeCap: CircularStrokeCap.round,
                               center:  Text("${formattedProfitPercentage} %",style: TextStyle(fontSize: 34,color: Color.fromARGB(255, 0, 0, 0)),),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: const Color.fromARGB(255, 255, 255, 255), // Matching background color
                  child: Tooltip(
                    message: 'Progress ${formattedLossPercentage}%', // Tooltip message
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                            const Text("Total Loss",style: TextStyle(fontSize: 19,color:Color.fromARGB(255, 0, 0, 0),)),
                          const SizedBox(height: 6,),
                         CircularPercentIndicator(
                          animation: true,
                          
                          animationDuration: 1000,
                          radius: 90,
                          lineWidth: 21,
                          percent: lossPercentage/100,
                          progressColor: const Color.fromARGB(255, 235, 41, 41),
                          backgroundColor: const Color.fromARGB(255, 237, 122, 122),
                          circularStrokeCap: CircularStrokeCap.round,
                               center:  Text("${formattedLossPercentage}%",style: TextStyle(fontSize: 34,color: Color.fromARGB(255, 0, 0, 0)),),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  
                  color: const Color.fromARGB(255, 255, 255, 255), // Matching background color
                  child: Tooltip(
                    message: 'Progress ${winRate}', // Tooltip message
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                            const Text("Win Rate",style: TextStyle(fontSize: 19,color:Color.fromARGB(255, 0, 0, 0))),
                          const SizedBox(height: 6,),
                         CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          radius: 90,
                          lineWidth: 21,
                          percent: winRate/1000,
                          progressColor: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple.shade200,
                          circularStrokeCap: CircularStrokeCap.round,
                          center:  Text("${formattedWinRate}%",style: TextStyle(fontSize: 34,color: Color.fromARGB(255, 0, 0, 0)),),
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
                    ],
                 ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                   color: Color.fromARGB(255, 255, 242, 242),
                   
                      borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0), // Adjust the radius as needed
                  bottomRight: Radius.circular(10.0), 
                  // Adjust the radius as needed
                  //20
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(top:12),
                      child: Column(
                        
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text("Profit/Loss Ratios",style: TextStyle(fontSize: 22),)),
                            const SizedBox(height:6),
                         Container(
                          height: 120,
                          color: const Color.fromARGB(255, 173, 255, 215),
                          child:  Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,             
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            Text("Profit:${tprofit}",style: const TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                             Text("Wins: ${twin}",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                                ],),
                                
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                            Text("Accuracy: ${formattedProfitAccuracy}%",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                            Text("Profit %: ${formattedProfitPercentage}%",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                                ],)
                              ],
                            ),
                          ),
                          
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            color: const Color.fromARGB(255, 247, 166, 166),
                      height: 120,
                            child:  Padding(
                            padding:  const EdgeInsets.all(13.0),
                            child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,             
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            Text("Loss: -${tloss}",style: const TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                             Text("Net P/L: ${formattedLossPercentage}%",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                                ],),
                                
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                            Text("Loss %:-${formattedLossPercentage}",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w500),),
                           
                                ],)
                              ],
                            ),
                          ),
                          
                          ),
                        ],
                      ),
                    ),
                   
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 250,
                  color:const Color.fromARGB(255, 255, 255, 255),
                  child:Column(
                    children: [
                      const Text("Overall Analysis",style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 18,),
                      MultiCircularSlider(
                                  size: MediaQuery.of(context).size.width * 0.7,
                                  values:  [0.6,0.1,0.2,0.1],
                                  colors: const [ Color.fromARGB(255, 255, 74, 74),  Color(0xFF29D3E8),  Color(0xFF18C737),  Color(0xFFFFCC05)],
                                  showTotalPercentage: true,
                                  label: 'P/L Statistics',
                                  animationDuration: const Duration(milliseconds: 500),
                                  animationCurve: Curves.easeIn,
                                  innerIcon: const Icon(Icons.compass_calibration_sharp),
                                
                                  trackColor: const Color.fromARGB(255, 39, 74, 253),
                                  progressBarWidth: 22.0,
                                  progressBarType:MultiCircularSliderType.circular,
                                  trackWidth: 22.0,
                                  labelTextStyle: const TextStyle(),
                                  percentageTextStyle: const TextStyle(),
                                ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}