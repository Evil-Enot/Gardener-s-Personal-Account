class BillsInfo {
  bool error;
  Info info;
  String message;

  BillsInfo({required this.error, required this.info, required this.message});

  factory BillsInfo.fromJson(Map<String, dynamic> json) {
    return BillsInfo(
        error: json['error'],
        info: Info.fromJson(json['info']),
        message: json['message']);
  }
}

class Info {
  double billduty;
  double billoverpayment;
  String lastbillelectro;
  String lastbillelwater;

  Info({
    required this.billduty,
    required this.billoverpayment,
    required this.lastbillelectro,
    required this.lastbillelwater,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      billduty: json['billduty'].toDouble(),
      billoverpayment: json['billoverpayment'].toDouble(),
      lastbillelectro: json['lastbillelectro'],
      lastbillelwater: json['lastbillelwater'],
    );
  }
}
