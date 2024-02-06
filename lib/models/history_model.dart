
class TwoDHistoryModel {
  TwoDHistoryModel({
    required this.result,
    required this.message,
    required this.data,
  });
  late final int result;
  late final String message;
  late final List<TwoDHistory> data;
  
  TwoDHistoryModel.fromJson(Map<String, dynamic> json){
    result = json['result'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>TwoDHistory.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TwoDHistory {
  TwoDHistory({
    required this.date,
    //  this.set_1100,
    //  this.val_1100,
    // required this.set_1200,
    // required this.val_1200,
    //  this.set_300,
    //  this.val_300,
    // required this.set_430,
    // required this.val_430,
    // required this.result_1100,
    required this.result_1200,
    // required this.result_300,
    required this.result_430,
    //  this.internet_930,
    //  this.modern_930,
    //  this.internet_200,
    //  this.modern_200,
    // required this.time_1100,
    // required this.time_1200,
    // required this.time_300,
      required this.time_430,
    // required this.live,
  });
  late final dynamic date;
  // late final String? set_1100;
  // late final String? val_1100;
  // late final String set_1200;
  // late final String val_1200;
  // late final String? set_300;
  // late final String? val_300;
  // late final String set_430;
  // late final String val_430;
  // late final String? result_1100;
  late final dynamic? result_1200;
  // late final String? result_300;
  late final dynamic? result_430;
  // late final String? internet_930;
  // late final String? modern_930;
  // late final String? internet_200;
  // late final String? modern_200;
  // late final String time_1100;
  // late final String time_1200;
  // late final String time_300;
  late final dynamic time_430;
  // late final String? live;
  
  TwoDHistory.fromJson(Map<String, dynamic> json){
    date = json['date'];
    // set_1100 = null;
    // val_1100 = null;
    // set_1200 = json['set_1200'];
    // val_1200 = json['val_1200'];
    // set_300 = null;
    // val_300 = null;
    // set_430 = json['set_430'];
    // val_430 = json['val_430'];
    // result_1100 = json['result_1100'];
    result_1200 = json['result_1200']==false?"":json["result_1200"];
    // result_300 = json['result_300'];
    result_430 = json['result_430']==false?"":json["result_430"];
    // internet_930 = null;
    // modern_930 = null;
    // internet_200 = null;
    // modern_200 = null;
    // time_1100 = json['time_1100'];
    // time_1200 = json['time_1200'];
    // time_300 = json['time_300'];
    time_430 = json['time_430']==false?"":json["time_430"];
    // live = json['live'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    // _data['set_1100'] = set_1100;
    // _data['val_1100'] = val_1100;
    // _data['set_1200'] = set_1200;
    // _data['val_1200'] = val_1200;
    // _data['set_300'] = set_300;
    // _data['val_300'] = val_300;
    // _data['set_430'] = set_430;
    // _data['val_430'] = val_430;
    // _data['result_1100'] = result_1100;
    _data['result_1200'] = result_1200;
    // _data['result_300'] = result_300;
    _data['result_430'] = result_430;
    // _data['internet_930'] = internet_930;
    // _data['modern_930'] = modern_930;
    // _data['internet_200'] = internet_200;
    // _data['modern_200'] = modern_200;
    // _data['time_1100'] = time_1100;
    // _data['time_1200'] = time_1200;
    // _data['time_300'] = time_300;
    _data['time_430'] = time_430;
      // _data['live'] = live;
    return _data;
  }
}
