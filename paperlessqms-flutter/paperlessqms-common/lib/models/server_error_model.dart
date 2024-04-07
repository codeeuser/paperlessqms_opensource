class ServerErrorModel {
  int? status;
  bool? limit;
  String? error;
  Data? data;

  ServerErrorModel({this.status, this.limit, this.error, this.data});

  factory ServerErrorModel.fromMap(dynamic map) {
    if (map is! Map) return ServerErrorModel();  
    return ServerErrorModel(
      status: map['status'],
      limit: map['limit'],
      error: map['error'],
      data: (map['data'] != null && map['data'] is Map<String, dynamic>) ? Data.fromMap(map['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'limit': limit,
      'error': error,
      'data': data?.toJson(),
    };
  }
}

class Data {
  String? type;
  String? title;
  int? status;

  Data({this.type, this.title, this.status});

  Data.fromMap(Map<String, dynamic> map)
    : type = map['type'],
    title = map['title'],
    status = map['status'];

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'status': status,
    };
  }
}