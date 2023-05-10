class BinJsonModel {
    BinJsonModel({
        required this.app,
        required this.login,
        required this.notifications,
        required this.listID,
    });

    String app;
    bool login;
    List<Notification> notifications;
    List<String> listID;

    factory BinJsonModel.fromJson(Map<String, dynamic> json) => BinJsonModel(
        app: json['app'],
        login: json['login'],
        notifications: List<Notification>.from(json['notifications'].map((x) => Notification.fromJson(x))),
        listID: List<String>.from(json['listID'].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        'app': app,
        'login': login,
        'notifications': List<dynamic>.from(notifications.map((x) => x.toJson())),
        'listID': List<dynamic>.from(listID.map((x) => x)),
    };
}

class Notification {
    Notification({
        required this.id,
        required this.title,
        required this.body,
        required this.dateTime,
    });

    int id;
    String title;
    String body;
    DateTime dateTime;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        dateTime: DateTime.parse(json['dateTime']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'dateTime': dateTime.toIso8601String(),
    };
}
