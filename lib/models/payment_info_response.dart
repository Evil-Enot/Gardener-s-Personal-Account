class PaymentInfo {
  bool error;
  Info info;

  PaymentInfo({required this.error, required this.info});

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      error: json['error'],
      info: Info.fromJson(json['info']),
    );
  }
}

class Info {
  String recipient;
  String inn;
  String kpp;
  String bank;
  String bill;
  String numberLK;
  String purpose;
  String duty;

  Info(
      {required this.recipient,
      required this.inn,
      required this.kpp,
      required this.bank,
      required this.bill,
      required this.numberLK,
      required this.purpose,
      required this.duty});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      recipient: json['recipient'],
      inn: json['inn'],
      kpp: json['kpp'],
      bank: json['bank'],
      bill: json['bill'],
      numberLK: json['numberLK'],
      purpose: json['purpose'],
      duty: json['duty'],
    );
  }
}
