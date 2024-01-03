import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String name;
  String image;
  int totalcases, totaldeaths,totalrecovered,active,critical,todayrecovered,test;

  CountryDetails({
    required this.name,
    required this.critical,
    required this.active,
    required this.image,
    required this.test,
    required this.todayrecovered,
    required this.totalcases,
    required this.totaldeaths,
    required this.totalrecovered
  });
  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 10,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .08),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.green.shade100,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .07,),
                      ReusebleRow(title: 'Cases', value: widget.totalcases.toString()),
                      ReusebleRow(title: 'Recovered', value: widget.totalrecovered.toString()),
                      ReusebleRow(title: 'Active', value: widget.active.toString()),
                      ReusebleRow(title: 'Test', value: widget.test.toString()),
                      ReusebleRow(title: 'Today Recovered', value: widget.todayrecovered.toString()),
                      ReusebleRow(title: 'Critical', value: widget.totaldeaths.toString()),
                      ReusebleRow(title: 'Total Recovered', value: widget.totalrecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
