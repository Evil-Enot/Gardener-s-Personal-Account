class MetersInfo {
  final bool error;
  final Info info;
  final String message;

  MetersInfo({required this.error, required this.info, required this.message});

  factory MetersInfo.fromJson(Map<String, dynamic> json) {
    return MetersInfo(
      error: json['error'],
      info: Info.fromJson(json['info']),
      message: json['message'],
    );
  }
}

class Info {
  List<Meter> meters;
  String lastbillelectrodata;
  String lastbillelwaterdata;

  Info({
    required this.meters,
    required this.lastbillelectrodata,
    required this.lastbillelwaterdata,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    var list = json['meters'] as List;
    List<Meter> metersList = list.map((i) => Meter.fromJson(i)).toList();

    return Info(
      meters: metersList,
      lastbillelectrodata: json['lastbillelectrodata'],
      lastbillelwaterdata: json['lastbillelwaterdata'],
    );
  }

  List<Meter> getMeters() {
    return meters;
  }
}

class Meter {
  String servicebymeter;
  String address;
  String mark;
  String code;
  String date;
  double datat1;
  double datat2;
  double datat3;
  double consumptiont1;
  double consumptiont2;
  double consumptiont3;
  double ratet1;
  double ratet2;
  double ratet3;
  double accrued;

  Meter({
    required this.servicebymeter,
    required this.address,
    required this.mark,
    required this.code,
    required this.date,
    required this.datat1,
    required this.datat2,
    required this.datat3,
    required this.consumptiont1,
    required this.consumptiont2,
    required this.consumptiont3,
    required this.ratet1,
    required this.ratet2,
    required this.ratet3,
    required this.accrued,
  });

  factory Meter.fromJson(Map<String, dynamic> json) {
    return Meter(
      servicebymeter: json['servicebymeter'],
      address: json['address'],
      mark: json['mark'],
      code: json['code'],
      date: json['date'],
      datat1: json['datat1'].toDouble(),
      datat2: json['datat2'].toDouble(),
      datat3: json['datat3'].toDouble(),
      consumptiont1: json['consumptiont1'].toDouble(),
      consumptiont2: json['consumptiont2'].toDouble(),
      consumptiont3: json['consumptiont3'].toDouble(),
      ratet1: json['ratet1'].toDouble(),
      ratet2: json['ratet2'].toDouble(),
      ratet3: json['ratet3'].toDouble(),
      accrued: json['accrued'].toDouble(),
    );
  }
}
