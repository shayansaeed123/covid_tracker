import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Services/states_services.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 7),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorlist = <Color> [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      // appBar: AppBar(
      //   title: Text('Covid Tracker'),
      //   centerTitle: true,
      //   backgroundColor: Colors.blueGrey,
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .08,),
                FutureBuilder(
                  future: statesServices.fetchWorldStatesRecord(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData)
                      {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.green,
                              controller: _controller,
                              size: 50.0,
                            ));
                      }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            chartRadius: 190,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartType: ChartType.ring,
                            colorList: colorlist,
                            animationDuration: Duration(milliseconds: 1200),
                          ),
                          Card(
                            margin: EdgeInsets.only(top: 15),
                            color: Colors.black,
                            elevation: 30,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                ReusebleRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReusebleRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReusebleRow(title: "Death", value: snapshot.data!.deaths.toString()),
                                ReusebleRow(title: "Active Cases", value: snapshot.data!.active.toString()),
                                ReusebleRow(title: "Active Critical", value: snapshot.data!.critical.toString()),
                                ReusebleRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                ReusebleRow(title: "TodayDeaths", value: snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .03,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CountriesList();
                              }));
                    },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 2.0,
                                      offset: Offset.zero,
                                      spreadRadius: 1.0
                                    )
                                  ],
                                  border: Border.all(color: Colors.white),
                                  color: Colors.grey.shade900
                              ),
                              child: Center(child: Text("Track Countries",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                            ),
                          )
                        ],
                      );
                    }
              }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ReusebleRow extends StatelessWidget {
  String title,value;
  ReusebleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(color: Colors.white)),
              Text(value,style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 6,),
          Divider()
        ],
      ),
    );
  }
}

