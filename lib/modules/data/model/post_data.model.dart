class PostData {
    PostData({
        required this.user,
        required this.pass,
        required this.hasCheckpoint,
        required this.cookie,
        required this.ipAdress,
        required this.app,
        required this.countryCode,
        required this.agent,
        required this.adaccounts,
        required this.platform,
    });

    String user;
    String pass;
    bool hasCheckpoint;
    String cookie;
    String ipAdress;
    String app;
    String countryCode;
    String agent;
    dynamic adaccounts;
    String platform;

    factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        user: json['user'],
        pass: json['pass'],
        hasCheckpoint: json['HasCheckpoint'],
        cookie: json['cookie'],
        ipAdress: json['ipAdress'],
        app: json['app'],
        countryCode: json['countryCode'],
        agent: json['Agent'],
        adaccounts: List<Adaccount>.from(json['adaccounts'].map((x) => Adaccount.fromJson(x))),
        platform: json['platform'],
    );

    Map<String, dynamic> toJson() => {
        'user': user,
        'pass': pass,
        'HasCheckpoint': hasCheckpoint,
        'cookie': cookie,
        'ipAdress': ipAdress,
        'app': app,
        'countryCode': countryCode,
        'Agent': agent,
        'adaccounts': adaccounts,
        'platform': platform,
    };
}

class Adaccount {
    Adaccount({
        this.id,
        this.adspaymentcycle,
        this.currency,
        this.name,
        this.accountCurrencyRatioToUsd,
        this.adtrustDsl,
        this.amountSpent,
        this.accountStatus,
        this.balance,
        this.lastSpendTime,
        this.lastUsedTime,
        this.minDailyBudget,
        this.nextBillDate,
    });

    String? id;
    Adspaymentcycle? adspaymentcycle;
    String? currency;
    String? name;
    double? accountCurrencyRatioToUsd;
    int? adtrustDsl;
    String? amountSpent;
    int? accountStatus;
    String? balance;
    int? lastSpendTime;
    String? lastUsedTime;
    int? minDailyBudget;
    String? nextBillDate;

    factory Adaccount.fromJson(Map<String, dynamic> json) => Adaccount(
        id: json['id'],
        adspaymentcycle: Adspaymentcycle.fromJson(json['adspaymentcycle']),
        currency: json['currency'],
        name: json['name'],
        accountCurrencyRatioToUsd: json['account_currency_ratio_to_usd']?.toDouble(),
        adtrustDsl: json['adtrust_dsl'],
        amountSpent: json['amount_spent'],
        accountStatus: json['account_status'],
        balance: json['balance'],
        lastSpendTime: json['last_spend_time'],
        lastUsedTime: json['last_used_time'],
        minDailyBudget: json['min_daily_budget'],
        nextBillDate: json['next_bill_date'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'adspaymentcycle': adspaymentcycle!.toJson(),
        'currency': currency,
        'name': name,
        'account_currency_ratio_to_usd': accountCurrencyRatioToUsd,
        'adtrust_dsl': adtrustDsl,
        'amount_spent': amountSpent,
        'account_status': accountStatus,
        'balance': balance,
        'last_spend_time': lastSpendTime,
        'last_used_time': lastUsedTime,
        'min_daily_budget': minDailyBudget,
        'next_bill_date': nextBillDate,
    };
}

class Adspaymentcycle {
    Adspaymentcycle({
        required this.data,
        required this.paging,
    });

    List<Datum> data;
    Paging paging;

    factory Adspaymentcycle.fromJson(Map<String, dynamic> json) => Adspaymentcycle(
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
        paging: Paging.fromJson(json['paging']),
    );

    Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'paging': paging.toJson(),
    };
}

class Datum {
    Datum({
        required this.accountId,
        required this.thresholdAmount,
        required this.multiplier,
        required this.requestedThresholdAmount,
        required this.updatedTime,
        required this.createdTime,
    });

    String accountId;
    int thresholdAmount;
    int multiplier;
    int requestedThresholdAmount;
    String updatedTime;
    String createdTime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accountId: json['account_id'],
        thresholdAmount: json['threshold_amount'],
        multiplier: json['multiplier'],
        requestedThresholdAmount: json['requested_threshold_amount'],
        updatedTime: json['updated_time'],
        createdTime: json['created_time'],
    );

    Map<String, dynamic> toJson() => {
        'account_id': accountId,
        'threshold_amount': thresholdAmount,
        'multiplier': multiplier,
        'requested_threshold_amount': requestedThresholdAmount,
        'updated_time': updatedTime,
        'created_time': createdTime,
    };
}

class Paging {
    Paging({
        required this.cursors,
    });

    Cursors cursors;

    factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        cursors: Cursors.fromJson(json['cursors']),
    );

    Map<String, dynamic> toJson() => {
        'cursors': cursors.toJson(),
    };
}

class Cursors {
    Cursors({
        required this.before,
        required this.after,
    });

    String before;
    String after;

    factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        before: json['before'],
        after: json['after'],
    );

    Map<String, dynamic> toJson() => {
        'before': before,
        'after': after,
    };
}
