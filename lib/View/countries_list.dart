import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/country_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 7),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.grey.shade700,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                onChanged: (value)
                {
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  label: Text('Search Country name'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade900,
                      width: 2,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.CountriesListApi(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                      if(!snapshot.hasData)
                        {
                          return ListView.builder(
                              itemBuilder: (context, index){
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Container(height: 50, width: 50, color: Colors.grey,),
                                          title: Container(height: 10, width: 90,color: Colors.grey),
                                          subtitle: Container(height: 10, width: 90,color: Colors.grey),
                                        )
                                      ],
                                    ),
                                );
                              });
                        }else{
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty)
                              {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)
                                        {
                                          return CountryDetails(
                                            name: snapshot.data![index]['country'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            totalrecovered: snapshot.data![index]['recovered'],
                                            totaldeaths: snapshot.data![index]['deaths'],
                                            totalcases: snapshot.data![index]['cases'],
                                            todayrecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                          );
                                        }));
                                        },
                                      child: ListTile(
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag'],
                                            )),
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      ),
                                    )
                                  ],
                                );
                              }else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                                {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)
                                            {
                                              return CountryDetails(
                                                name: snapshot.data![index]['country'],
                                                image: snapshot.data![index]['countryInfo']['flag'],
                                                totalrecovered: snapshot.data![index]['recovered'],
                                                totaldeaths: snapshot.data![index]['deaths'],
                                                totalcases: snapshot.data![index]['cases'],
                                                todayrecovered: snapshot.data![index]['todayRecovered'],
                                                test: snapshot.data![index]['tests'],
                                                active: snapshot.data![index]['active'],
                                                critical: snapshot.data![index]['critical'],
                                              );
                                            }));
                                  },
                                        child: ListTile(
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                snapshot.data![index]['countryInfo']['flag'],
                                              )),
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        ),
                                      )
                                    ],
                                  );
                                }else{
                              return Container();
                            }

                            });
                      }

                    })
            )
          ],
        ),
      ),
    );
  }
}
