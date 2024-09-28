import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:fx_journal/selectcoin.dart';





class Item extends StatelessWidget {
 final item;
 final String id;
 Item({required this.item,required this.id});

 @override
 Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: myWidth * 0.06, vertical: myHeight * 0.04),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contest) => SelectCoin(selectItem: item,id:id)));
        },
        child: Container(
          width: myWidth*0.06,
          height: myHeight*0.10,
          decoration: BoxDecoration(shape: BoxShape.rectangle,boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 194, 192, 192).withOpacity(.1),
              blurRadius: 6.0,
              spreadRadius: .07,
            ), //BoxShadow
          ],),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                 height: myHeight * 0.07,
                 width: myWidth *0.06,
                 child: Image.network(
                    item.image,
                    fit: BoxFit.cover, // Adjust image fit
                 ),
                ),
              ),
              SizedBox(width: myWidth * 0.01,),
              Flexible(
                flex: 2,
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                      item.id,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                   
                 ],
                ),
              ),
              SizedBox(width: myWidth * 0.01),
              Flexible(
                flex: 2,
                child: Container(
                 height: myHeight * 0.05,
                 width: myWidth*0.3,
                 child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 2.0,
                    lineColor: item.marketCapChangePercentage24H >= 0
                        ? Colors.green
                        : Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.7],
                        colors: item.marketCapChangePercentage24H >= 0
                            ? [Colors.green, Colors.green.shade100]
                            : [Colors.red, Colors.red.shade100]),
                 ),
                ),
              ),
              SizedBox(width: myWidth * 0.04,height: myHeight*0.01,),
              Flexible(
                flex: 2,
                child: Column(
                  
                 
                 children: [
                    Text(
                      '\$ ' + item.currentPrice.toString(),
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Row(
                    
                      children: [
                        Text(
                          item.priceChange24H.toString().contains('-')
                              ? "-\$" +
                                 item.priceChange24H
                                      .toStringAsFixed(2)
                                      .toString()
                                      .replaceAll('-', '')
                              : "\$" + item.priceChange24H.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                        SizedBox(width: myWidth * 0.03),
                        Text(
                          item.marketCapChangePercentage24H.toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: item.marketCapChangePercentage24H >= 0
                                 ? Colors.green
                                 : Colors.red),
                        ),
                      ],
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
