class DataModel {
  int id;
  String name;
  List<String> defects;
  int defectIndex;

  DataModel(
      {required this.id,
      required this.name,
      required this.defects,
      required this.defectIndex});
}
