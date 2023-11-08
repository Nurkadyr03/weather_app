import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WEATHER APP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
               
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>HomePage(nameCityes: "Bishkek",)));
              },
              child: const Text('Bishkek'),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
               
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>HomePage(nameCityes: "Osh",)));
              },
              child: const Text('Osh'),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
               
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>HomePage(nameCityes: "Moscow",)));
              },
              child: const Text('Moscow'),
            ),
          ),Center(
            child: InkWell(
              onTap: () {
               
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>HomePage(nameCityes: "Budapest",)));
              },
              child: const Text('Budapest'),
            ),
          ),
        ],
      ),
    );
  }
}
