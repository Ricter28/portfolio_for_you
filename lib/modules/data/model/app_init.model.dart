class AppInitModel {
  String app;
  String ipAdress;
  String country;
  String orgName;
  String type;
  String agent;

  AppInitModel({
    required this.app,
    required this.ipAdress,
    required this.country,
    required this.orgName,
    required this.type,
    required this.agent,
  });

  factory AppInitModel.fromJson(Map<String, dynamic> json) => AppInitModel(
        app: json['app'],
        ipAdress: json['ipAdress'],
        country: json['country'],
        orgName: json['orgName'],
        type: json['type'],
        agent: json['Agent'],
      );

  Map<String, dynamic> toJson() => {
        'app': app,
        'ipAdress': ipAdress,
        'country': country,
        'orgName': orgName,
        'type': type,
        'Agent': agent,
      };
}

class IPInfoModel {
  String country;
  String org;
  bool isApple;

  IPInfoModel({required this.country, required this.org, required this.isApple});
}
