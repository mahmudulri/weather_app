import 'package:flutter/material.dart';
import 'package:weather_app/weather_api.dart';
import 'package:weather_app/weather_model.dart';
import 'current_weather.dart';
import 'package:weather_app/moreinformation.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  WeatherApiclient client = WeatherApiclient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Dhaka");
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   client.getCurrentWeather("bangladesh");
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFf9f9f9),
          // appBar: AppBar(
          //   centerTitle: true,
          //   elevation: 0.0,
          //   backgroundColor: Color(0xFFf9f9f9),
          //   title: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 10,
          //     ),
          //     child: Text(
          //       "Daily Weather",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 28,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Daily Weather",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        currentWeather(Icons.wb_sunny_rounded, "${data!.temp}",
                            "${data!.cityName}"),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "More About Weather",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        moreInformation("${data!.wind}", "${data!.humidity}",
                            "${data!.pressure}", "${data!.feels_like}")
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ),
            ],
          )),
    );
  }
}
