import 'package:flutter/material.dart';
import 'package:fx_journal/home.dart';

import 'package:http/http.dart' as http;
import 'package:fx_journal/coinmodaljson.dart';
import 'package:fx_journal/item.dart';

class CoinList extends StatefulWidget {


  @override
  State<CoinList> createState() => _CoinListState();
    final String id;
 const  CoinList({required this.id});
}

class _CoinListState extends State<CoinList> {
  TextEditingController searchController = TextEditingController();
  String url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
  bool isRefreshing = true;
  List<CoinModel>? coinMarket;

  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 215, 64, 1),
        title: Text("Crypto Market"), 
        leading: IconButton(
icon:Icon(Icons.arrow_back),
onPressed: (){
   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(id:widget.id),
          ));
},
        ),
        ),
      
      body: Container(
        child: isRefreshing
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFBC700),
                ),
              )
            : coinMarket == null || coinMarket!.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'No Results Found',
                        style: TextStyle(fontSize: 18),
                      ),
                      
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: coinMarket!.length,
                    itemBuilder: (context, index) {
                      return Item(
                        item: coinMarket![index],
                        id:widget.id
                      );
                    },
                  ),
      ),
    );
  }

  Future<void> getCoinMarket() async {
    setState(() {
      isRefreshing = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefreshing = false;
    });

    if (response.statusCode == 200) {
      var x = response.body;
      setState(() {
        coinMarket = coinModelFromJson(x);
        
      });
    } else {
      print('Failed to load coins: ${response.statusCode}');
    }
  }
}
