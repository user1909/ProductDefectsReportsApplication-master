import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/defect_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartPage extends StatefulWidget {
  final List<DefectModel> data;
  //callback onTap function with defect name
  final Function(String)? onTap;
  final Function(String)? onDoubleTap;
  const PieChartPage(
      {super.key,
      required this.data,
      required this.onTap,
      required this.onDoubleTap});

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  List<DefectCountModel> defectCountList = [];

  converIntoCountModel() {
    defectCountList.clear();
    for (DefectModel defectModel in widget.data) {
      DefectCountModel? existingDefect = defectCountList.firstWhere(
        (defectCount) => defectCount.defect == defectModel.defects,
        orElse: () =>
            DefectCountModel(defect: defectModel.defects, productCount: 0),
      );
      log(existingDefect.defect.toString());

      if (existingDefect.productCount > 0) {
        existingDefect.productCount++;
      } else {
        defectCountList.add(
            DefectCountModel(defect: defectModel.defects, productCount: 1));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    converIntoCountModel();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
          isResponsive: true,
          orientation: LegendItemOrientation.vertical,
        ),
        series: <CircularSeries>[
          DoughnutSeries<DefectCountModel, String>(
            enableTooltip: true,
            explode: true,
            explodeIndex: 0,
            dataSource: defectCountList,
            xValueMapper: (DefectCountModel data, _) => data.defect,
            yValueMapper: (DefectCountModel data, _) => data.productCount,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
            onPointTap: (pointInteractionDetails) {
              ChartPoint? data = pointInteractionDetails
                  .dataPoints![pointInteractionDetails.pointIndex!];
              widget.onTap!(data!.x);
            },
            onPointDoubleTap: (pointInteractionDetails) {
              ChartPoint? data = pointInteractionDetails
                  .dataPoints![pointInteractionDetails.pointIndex!];
              widget.onDoubleTap!(data!.x);
            },
          )
        ],
      ),
    );
  }
}

class DefectCountModel {
  final String defect;
  int productCount;

  DefectCountModel({required this.defect, required this.productCount});
}
