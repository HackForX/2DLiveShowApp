class ResultModel {
  // Change 'id' type if necessary

  String? result1200;
  String? result430;

  ResultModel({
    this.result1200,
    this.result430,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      // Change default value if necessary
      // Correct the field name
      result1200: json['result_1200'] ?? "",
      result430: json['result_430'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Correct the field name
      'result_1200': result1200 ?? "",
      'result_430': result430 ?? "",
    };
  }
}
