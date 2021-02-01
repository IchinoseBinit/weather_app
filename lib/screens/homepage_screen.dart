import 'package:flutter/material.dart';
import 'package:startwithflutter/components/myText.dart';
import 'package:startwithflutter/data/weather_data_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic weatherInfo;

  @override
  void initState() {
    super.initState();

    fetchWeatherInfo().then((value) {
      setState(() {
        weatherInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherInfo != null) {
      return Scaffold(
        appBar: AppBar(
          title: MyTextWidget(
            title: 'Weather',
            fontweight: FontWeight.w300,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade900,
                Colors.black,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _showIcon(),
              _temperature(),
              _location(),
              _date(),
              _description(),
              _hourlyWeatherInfo(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }

  Widget _hourlyWeatherInfo() {

    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: weatherInfo.times.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 50,
            child: Card(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyTextWidget(
                    title: weatherInfo.times[index],
                  ),
                  Icon(
                    Icons.cloud_queue,
                    color: Colors.white,
                  ),
                  MyTextWidget(
                    title: weatherInfo.temps[index],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 3,
      ),
      child: MyTextWidget(
        title: 'Snow turn to Cloud',
      ),
    );
  }

  Widget _date() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        top: 10,
      ),
      child: Row(
        children: [
          MyTextWidget(
            title: 'Today',
            color: Colors.grey,
            fontweight: FontWeight.w700,
          ),
          SizedBox(
            width: 10,
          ),
          MyTextWidget(
            title: '20.10.2020',
            fontsize: 14,
          ),
        ],
      ),
    );
  }

  Widget _location() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
          Icon(
            Icons.place,
            color: Colors.white,
          ),
          Text(
            'London, UK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }

  Widget _temperature() {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
      ),
      child: Text(
        '-10',
        style: TextStyle(
          color: Colors.white,
          fontSize: 80,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  Widget _showIcon() {
    return Center(
      child: Container(
        height: 200,
        child: Image.asset(
          'assets/images/snow.png',
          height: 80.0,
        ),
      ),
    );
  }
}
