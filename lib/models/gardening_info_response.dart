class GardeningInfo {
  bool error;
  Info info;

  GardeningInfo({required this.error, required this.info});

  factory GardeningInfo.fromJson(Map<String, dynamic> json) {
    return GardeningInfo(
      error: json['error'],
      info: Info.fromJson(json['info']),
    );
  }
}

class Info {
  String name;
  String address;
  String inn;
  String kpp;
  String ogrn;
  String bank;
  String bill;

  Info(
      {required this.name,
      required this.address,
      required this.inn,
      required this.kpp,
      required this.ogrn,
      required this.bank,
      required this.bill});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        name: json['name'],
        address: json['address'],
        inn: json['inn'],
        kpp: json['kpp'],
        ogrn: json['ogrn'],
        bank: json['bank'],
        bill: json['bill']);
  }
}
