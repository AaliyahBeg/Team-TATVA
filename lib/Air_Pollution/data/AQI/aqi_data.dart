class AQIData {
  String? status;
  Data? data;

  AQIData({this.status, this.data});

  AQIData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  num? aqi;
  num? idx;
  List<Attributions>? attributions;
  City? city;
  String? dominentpol;
  Iaqi? iaqi;
  Time? time;
  Forecast? forecast;
  Debug? debug;

  Data(
      {this.aqi,
      this.idx,
      this.attributions,
      this.city,
      this.dominentpol,
      this.iaqi,
      this.time,
      this.forecast,
      this.debug});

  Data.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
    idx = json['idx'];
    if (json['attributions'] != null) {
      attributions = <Attributions>[];
      json['attributions'].forEach((v) {
        attributions!.add(new Attributions.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    dominentpol = json['dominentpol'];
    iaqi = json['iaqi'] != null ? new Iaqi.fromJson(json['iaqi']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aqi'] = this.aqi;
    data['idx'] = this.idx;
    if (this.attributions != null) {
      data['attributions'] = this.attributions!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['dominentpol'] = this.dominentpol;
    if (this.iaqi != null) {
      data['iaqi'] = this.iaqi!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Attributions {
  String? url;
  String? name;
  String? logo;

  Attributions({this.url, this.name, this.logo});

  Attributions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

class City {
  List<double>? geo;
  String? name;
  String? url;
  String? location;

  City({this.geo, this.name, this.url, this.location});

  City.fromJson(Map<String, dynamic> json) {
    geo = json['geo'].cast<double>();
    name = json['name'];
    url = json['url'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geo'] = this.geo;
    data['name'] = this.name;
    data['url'] = this.url;
    data['location'] = this.location;
    return data;
  }
}

class Iaqi {
  Co? co;
  Dew? dew;
  Co? h;
  Co? no2;
  Dew? o3;
  Co? p;
  Pm10? pm10;
  Pm25? pm25;
  Co? so2;
  Co? t;
  Co? w;
  Dew? wd;
  Co? wg;

  Iaqi(
      {this.co,
      this.dew,
      this.h,
      this.no2,
      this.o3,
      this.p,
      this.pm10,
      this.pm25,
      this.so2,
      this.t,
      this.w,
      this.wd,
      this.wg});

  Iaqi.fromJson(Map<String, dynamic> json) {
    co = json['co'] != null ? new Co.fromJson(json['co']) : null;
    dew = json['dew'] != null ? new Dew.fromJson(json['dew']) : null;
    h = json['h'] != null ? new Co.fromJson(json['h']) : null;
    no2 = json['no2'] != null ? new Co.fromJson(json['no2']) : null;
    o3 = json['o3'] != null ? new Dew.fromJson(json['o3']) : null;
    p = json['p'] != null ? new Co.fromJson(json['p']) : null;
    pm10 = json['pm10'] != null ? new Pm10.fromJson(json['pm10']) : null;
    pm25 = json['pm25'] != null ? new Pm25.fromJson(json['pm25']) : null;
    so2 = json['so2'] != null ? new Co.fromJson(json['so2']) : null;
    t = json['t'] != null ? new Co.fromJson(json['t']) : null;
    w = json['w'] != null ? new Co.fromJson(json['w']) : null;
    wd = json['wd'] != null ? new Dew.fromJson(json['wd']) : null;
    wg = json['wg'] != null ? new Co.fromJson(json['wg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.co != null) {
      data['co'] = this.co!.toJson();
    }
    if (this.dew != null) {
      data['dew'] = this.dew!.toJson();
    }
    if (this.h != null) {
      data['h'] = this.h!.toJson();
    }
    if (this.no2 != null) {
      data['no2'] = this.no2!.toJson();
    }
    if (this.o3 != null) {
      data['o3'] = this.o3!.toJson();
    }
    if (this.p != null) {
      data['p'] = this.p!.toJson();
    }
    if (this.pm10 != null) {
      data['pm10'] = this.pm10!.toJson();
    }
    if (this.pm25 != null) {
      data['pm25'] = this.pm25!.toJson();
    }
    if (this.so2 != null) {
      data['so2'] = this.so2!.toJson();
    }
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    if (this.w != null) {
      data['w'] = this.w!.toJson();
    }
    if (this.wd != null) {
      data['wd'] = this.wd!.toJson();
    }
    if (this.wg != null) {
      data['wg'] = this.wg!.toJson();
    }
    return data;
  }
}

class Co {
  num? v;

  Co({this.v});

  Co.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}

class Dew {
  num? v;

  Dew({this.v});

  Dew.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}

class Time {
  String? s;
  String? tz;
  num? v;
  String? iso;

  Time({this.s, this.tz, this.v, this.iso});

  Time.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    tz = json['tz'];
    v = json['v'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['tz'] = this.tz;
    data['v'] = this.v;
    data['iso'] = this.iso;
    return data;
  }
}

class Forecast {
  Daily? daily;

  Forecast({this.daily});

  Forecast.fromJson(Map<String, dynamic> json) {
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class Daily {
  List<predict>? o3;
  List<predict>? pm10;
  List<predict>? pm25;

  Daily({this.o3, this.pm10, this.pm25});

  Daily.fromJson(Map<String, dynamic> json) {
    if (json['o3'] != null) {
      o3 = <predict>[];
      json['o3'].forEach((v) {
        o3!.add(new predict.fromJson(v));
      });
    }
    if (json['pm10'] != null) {
      pm10 = <predict>[];
      json['pm10'].forEach((v) {
        pm10!.add(predict.fromJson(v));
      });
    }
    if (json['pm25'] != null) {
      pm25 = <predict>[];
      json['pm25'].forEach((v) {
        pm25!.add(predict.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.o3 != null) {
      data['o3'] = this.o3!.map((v) => v.toJson()).toList();
    }
    if (this.pm10 != null) {
      data['pm10'] = this.pm10!.map((v) => v.toJson()).toList();
    }
    if (this.pm25 != null) {
      data['pm25'] = this.pm25!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class predict {
  num? avg;
  String? day;
  num? max;
  num? min;

  predict({this.avg, this.day, this.max, this.min});

  predict.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['day'] = this.day;
    data['max'] = this.max;
    data['min'] = this.min;
    return data;
  }
}

class Debug {
  String? sync;

  Debug({this.sync});

  Debug.fromJson(Map<String, dynamic> json) {
    sync = json['sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sync'] = this.sync;
    return data;
  }
}

class Pm10 {
  num? v;

  Pm10({this.v});

  Pm10.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}

class Pm25 {
  num? v;

  Pm25({this.v});

  Pm25.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}
