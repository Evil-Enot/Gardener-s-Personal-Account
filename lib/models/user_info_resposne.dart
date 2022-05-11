class UserInfo {
  bool error;
  Info info;
  String message;

  UserInfo({required this.error, required this.info, required this.message});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      error: json['error'],
      info: Info.fromJson(json['info']),
      message: json['message'],
    );
  }
}

class Info {
  String name;
  String number;
  String email;
  String address;
  int area;
  String cadastral;
  double billduty;
  double billoverpayment;
  String lastbillelectro;
  String lastbillelwater;

  Info({
    required this.name,
    required this.number,
    required this.email,
    required this.address,
    required this.area,
    required this.cadastral,
    required this.billduty,
    required this.billoverpayment,
    required this.lastbillelectro,
    required this.lastbillelwater,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        name: json['name'],
        number: json['number'],
        email: json['email'],
        address: json['address'],
        area: json['area'],
        cadastral: json['cadastral'],
        billduty: json['billduty'].toDouble(),
        billoverpayment: json['billoverpayment'].toDouble(),
        lastbillelectro: json['lastbillelectro'],
        lastbillelwater: json['lastbillelwater']);
  }
}
