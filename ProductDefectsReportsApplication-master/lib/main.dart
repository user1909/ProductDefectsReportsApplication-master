//CODE  displays pie chart with %
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as Math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/anotherBoxTable.dart';
import 'package:flutter_application_1/model/data_model.dart';
import 'package:flutter_application_1/model/defect_model.dart';
import 'package:flutter_application_1/pieChartPage.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

bool isPhone(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide < 600;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DefectModel> filtedData = [];

  bool toggle = false;

  List<DefectModel> jsonData = [
    DefectModel(name: "Defect 1", defects: "Loose screws"),
    DefectModel(name: "Defect 2", defects: "Loose screws"),
    DefectModel(name: "Defect 3", defects: "Malfunctioning sensor"),
    DefectModel(name: "Defect 4", defects: "Overheating issue"),
    DefectModel(name: "Defect 5", defects: "Overheating issue"),
  ];

  @override
  void initState() {
    super.initState();
    filtedData = jsonData;
  }

  filterData(String name) {
    if (name == "") {
      setState(() {
        filtedData = jsonData;
      });
      return;
    }
    setState(() {
      filtedData =
          jsonData.where((element) => element.defects == name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color pastelOrangeColor = Color.fromRGBO(253, 223, 196, 1.0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Data About Defects'),
        backgroundColor: Colors.orange,
        actions: [
          isPhone(context)
              // for phone
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterSwitch(
                    width: 50,
                    height: 30,
                    value: toggle,
                    onToggle: (bool value) {
                      setState(() {
                        toggle = value;
                      });
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    toggleColor: Colors.orange,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            top: 20.0, left: 16.0, right: 16.0, bottom: 16.0),
        color: pastelOrangeColor,
        child: Row(
          children: [
            !toggle
                ? Expanded(
                    child: PieChartPage(
                    data: jsonData,
                    onTap: (defect) {
                      filterData(defect);
                                            if (isPhone(context)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(defect),
                                  backgroundColor: Colors.orange,
                                ),
                                body: AnotherBoxTable(model: filtedData),
                              ),
                            ));
                      }
                    },
                    onDoubleTap: (defect) {
                      filterData("");
                      if (isPhone(context)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(defect),
                                  backgroundColor: Colors.orange,
                                ),
                                body: AnotherBoxTable(model: filtedData),
                              ),
                            ));
                      }
                    },
                  ))
                : Expanded(
                    child: AnotherBoxTable(
                    model: jsonData,
                  )),
            const SizedBox(width: 16.0),
            !isPhone(context) // for desktop
                ? Expanded(
                    flex: 1,
                    child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: AnotherBoxTable(
                        model: filtedData,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
