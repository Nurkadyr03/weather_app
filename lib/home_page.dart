import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_text.dart';
import 'package:weather_app/constants/app_text_style.dart';

import 'components/custom_icon_button.dart';
import 'constants/api_const.dart';

import 'models/weather.dart';

// List nameCityes=[
// "Osh",
// "Bishkek",
// "Moscow",
// "Budapest",

// ];

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key?key,required this.nameCityes}):super(key: key);
  String nameCityes;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String? nameCityes;
  Future<Weather?>? fetchData() async {
    //await Future.delayed(Duration(seconds: 3));
    final dio = Dio();
    final response = await dio.get(ApiConst.adress("${widget.nameCityes}"));
    if (response.statusCode == 200) {
      final Weather weather = Weather(
        id: response.data["weather"][0]["id"],
        main: response.data["weather"][0]["description"],
        description: response.data["weather"][0]["description"],
        icon: response.data["weather"][0]["icon"],
        city: response.data["name"],
        temp: response.data["main"]["temp"],
        country: response.data["sys"]["country"],
       
      );
      return weather;
    }
    return null;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   festData();
  // }

  @override
  Widget build(BuildContext context) {
    log('max W ==> ${MediaQuery.of(context).size.width}');
    log('max H ==> ${MediaQuery.of(context).size.height}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppText.appBarTitle,
      ),
      body: FutureBuilder<Weather?>(
        future: fetchData(),
        builder: (context, joop) {
          if (joop.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (joop.connectionState == ConnectionState.none) {
            return const Center(
              child: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4),
            );
          } else if (joop.connectionState == ConnectionState.done) {
            if (joop.hasError) {
              return Center(
                child: Text("${joop.hasError}"),
              );
            } else if (joop.hasData) {
              final weather = joop.data!;

              return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/weather.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(icon: Icons.near_me),
                            CustomIconButton(icon: Icons.location_city),
                          ],
                        ),
                        Row(
                          children: [
                            
                            Text("${(weather.temp-273.15).toInt()}" ,style: AppTextStyle.body1),
                           const SizedBox(
                            height: 100,
                            width: 50,
                             child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Text("°C", style: TextStyle(color:Colors.white,fontSize: 40 ),),
                               ],
                             ),
                           ),
                            Image.network(ApiConst.getIcon(weather.icon,4 ),
                                height: 220, fit: BoxFit.fitHeight),
                          ],
                        ),
                         Text(weather.description,
                            style: AppTextStyle.bodyText),
                            const SizedBox(height: 10),
                         Expanded(
                           child: Center(
                             child: Text(weather.city,
                                textAlign: TextAlign.right,
                                style: AppTextStyle.body1),
                           ),
                         ),
                      ],
                    ),
                  ),
                );
              
             
            }else{return const Text('others debag...');}
          }else{return const Text('others debag...');}
        },
      ),
      // body: Center(
      //   child: FutureBuilder(
      //     future: festData(),
      //     builder: (ctx, sn) {
      //       if (sn.hasData) {
      //         return Column(
      //           children: [
      //             Text(sn.data!.id.toString()),
      //             Text(sn.data!.description),
      //             Text(sn.data!.main),
      //             Text(sn.data!.icon),
      //             Text(sn.data!.city),
      //             Text(sn.data!.country),
      //             Text(sn.data!.temp.toString()),
      //           ],
      //         );
      //       } else if (sn.hasError) {
      //         return Text(
      //           sn.error.toString(),
      //         );
      //       } else {
      //         return CircularProgressIndicator();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
