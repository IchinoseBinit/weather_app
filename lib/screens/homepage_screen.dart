import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/secure_storage_constants.dart';
import 'package:weather_app/constants/user_constants.dart';
import 'package:weather_app/screens/help_screen.dart';
import 'package:weather_app/utils/navigate.dart';
import 'package:weather_app/utils/secure_storage_helper.dart';

import '../components/my_text.dart';
import '/data/weather_data_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.location});

  final String location;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // dynamic weatherInfo;

  late Future future;
  late String location;
  late bool isUpdateBtn;

  @override
  void initState() {
    super.initState();
    location = widget.location;
    isUpdateBtn = location.isNotEmpty;
    if (location.trim().isEmpty) {
      const param = "${UserConstants.latitude},${UserConstants.longitude}";
      future = fetchWeatherInfo(param);
    } else {
      future = fetchWeatherInfo(location);
    }

    // fetchWeatherInfo(param).then((value) {
    //   setState(() {
    //     weatherInfo = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MyTextWidget(
          title: 'Weather',
          fontweight: FontWeight.w300,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              navigate(
                  context,
                  HelpScreen(
                    location: location,
                  ));
            },
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
        child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.data.runtimeType == WeatherInfo) {
                final weatherInfo = snapshot.data as WeatherInfo;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      _showIcon(
                        context,
                        info: weatherInfo,
                      ),
                      _location("${weatherInfo.city}, ${weatherInfo.country}"),
                      const SizedBox(
                        height: 10,
                      ),
                      _date(),
                      const SizedBox(
                        height: 32,
                      ),
                      ...getInputField(),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Error cannot get data from API",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ...getInputField(),
                  ],
                );
              }
            }),
      ),
    );
  }

  getInputField() {
    return [
      TextFormField(
        onChanged: (v) {
          location = v;
        },
        onFieldSubmitted: (v) {
          setState(() {
            isUpdateBtn = true;
            future = fetchWeatherInfo(location);
          });
          SecureStorageHelper().write(
            key: SecureStorageConstants.locationName,
            value: location,
          );
        },
        initialValue: location,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          hintText: "Enter your location",
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isUpdateBtn = location.isNotEmpty;
              future = fetchWeatherInfo(location);
            });
            SecureStorageHelper().write(
              key: SecureStorageConstants.locationName,
              value: location,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            shape: const StadiumBorder(),
          ),
          child: Text(
            isUpdateBtn ? "Update" : "Save",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      )
    ];
  }
}

Widget _date() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      MyTextWidget(
        title: 'Today',
        color: Colors.grey,
        fontweight: FontWeight.w700,
        fontsize: 16,
      ),
      SizedBox(
        width: 10,
      ),
      MyTextWidget(
        title: DateFormat("dd-MM-yyyy").format(DateTime.now()),
        fontsize: 18,
      ),
    ],
  );
}

Widget _location(String location) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.place,
        color: Colors.white,
      ),
      Text(
        location,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      )
    ],
  );
}

Widget _temperature(String temp) {
  return Container(
    padding: const EdgeInsets.only(
      left: 20,
    ),
    child: Text(
      temp,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 80,
        fontWeight: FontWeight.w200,
      ),
    ),
  );
}

Widget _showIcon(BuildContext context, {required WeatherInfo info}) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 10,
    ),
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
    child: SizedBox(
      // width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: SizedBox(
                child: Image.network(
                  "https:${info.icon}",
                  height: 80.0,
                ),
              ),
            ),
            Text(
              info.text,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            _temperature("${info.temperature.toStringAsFixed(0)}\u2103"),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ),
  );
}
