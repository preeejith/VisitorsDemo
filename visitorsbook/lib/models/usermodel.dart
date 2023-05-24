class UserModel {
  bool? status;
  String? msg;
  Data? data;
  String? token;

  UserModel({this.status, this.msg, this.data, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  String? sId;
  String? role;
  String? status;
  String? guardname;
  String? gateno;
  int? accessno;
  String? createDate;
  String? updateDate;
  int? iV;

  Data(
      {this.sId,
      this.role,
      this.status,
      this.guardname,
      this.gateno,
      this.accessno,
      this.createDate,
      this.updateDate,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    status = json['status'];
    guardname = json['guardname'];
    gateno = json['gateno'];
    accessno = json['accessno'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['status'] = status;
    data['guardname'] = guardname;
    data['gateno'] = gateno;
    data['accessno'] = accessno;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    return data;
  }
}
