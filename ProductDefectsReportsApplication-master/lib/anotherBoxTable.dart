import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/defect_model.dart';

import 'model/data_model.dart';

class AnotherBoxTable extends StatefulWidget {
  final List<DefectModel> model;

  const AnotherBoxTable({required this.model, super.key});
  @override
  State<AnotherBoxTable> createState() => _AnotherBoxTableState();
}

class _AnotherBoxTableState extends State<AnotherBoxTable> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Defects')),
          ],
          rows: widget.model.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product.name)),
                DataCell(Text(product.defects)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
