class LiveModel {
  int? result;
  String? message;
  Live? data;

  LiveModel({this.result, this.message, this.data});

  LiveModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = Live.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

class Live {
  dynamic? set1200;
  dynamic? val1200;
  dynamic? set300;
  dynamic? val300;
  dynamic? set430;
  dynamic? val430;
  dynamic? result1100;
  dynamic? result1200;
  dynamic? result300;
  dynamic? result430;
  dynamic? internet930;
  dynamic? modern930;
  dynamic? internet200;
  dynamic? modern200;
  dynamic? date;
  dynamic? time1200;
  dynamic? time430;
  dynamic? live;
  dynamic? liveSet;
  dynamic? liveVal;
  dynamic? status1200;
  dynamic? status430;
  dynamic? lastDate;
  dynamic? isCloseDay;
  dynamic? currentDate;
  dynamic? currentTime;

  Live({

    this.set1200,
    this.val1200,
    this.set300,
    this.val300,
    this.set430,
    this.val430,
    this.result1100,
    this.result1200,
    this.result300,
    this.result430,
    this.internet930,
    this.modern930,
    this.internet200,
    this.modern200,
    this.date,
    this.time1200,
    this.time430,
    this.live,
    this.liveSet,
    this.liveVal,
    this.status1200,
    this.status430,
    this.lastDate,
    this.isCloseDay,
    this.currentDate,
    this.currentTime,
  });

  Live.fromJson(Map<String, dynamic> json) {
  
    set1200 = json['set_1200'];
    val1200 = json['val_1200'];
    set300 = json['set_300'];
    val300 = json['val_300'];
    set430 = json['set_430'];
    val430 = json['val_430'];
    result1100 = json['result_1100'];
    result1200 = json['result_1200'];
    result300 = json['result_300'];
    result430 = json['result_430'];
    internet930 = json['internet_930'];
    modern930 = json['modern_930'];
    internet200 = json['internet_200'];
    modern200 = json['modern_200'];
    date = json['date'];
    time1200 = json['time_1200'];
    time430 = json['time_430'];
    live = json['live'];
    liveSet = json['live_set'];
    liveVal = json['live_val'];
    status1200 = json['status_1200'];
    status430 = json['status_430'];
    lastDate = json['last_date'];
    isCloseDay = json['is_close_day'];
    currentDate = json['current_date'];
    currentTime = json['current_time'];
  }
}
