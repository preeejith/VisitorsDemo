class VisitorListModel {
  bool? status;
  String? msg;
  List<Data>? data;
  int? limit;
  int? page;
  int? totallength;

  VisitorListModel({this.status, this.msg, this.data,this.limit,
      this.page,
      this.totallength});

  VisitorListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
     limit = json['limit'];
    page = json['page'];
    totallength = json['totallength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
     data['limit'] = limit;
    data['page'] = page;
    data['totallength'] = totallength;
    return data;
  }
}

class Data {
  String? sId;
  String? role;
  String? status;
  String? visitorname;
  String? persontomeet;
  String? vechilenumber;
  String? createDate;
  String? updateDate;
  int? iV;
  String? qrId;
  String? purpose;
  int? phonenumber;
  String? checkinDateTime;
  String? checkouDateTime;
  bool? qrcheck;

  Data(
      {this.sId,
      this.role,
      this.status,
      this.visitorname,
      this.persontomeet,
      this.vechilenumber,
      this.createDate,
      this.updateDate,
      this.iV,
      this.qrId,
      this.purpose,
      this.phonenumber,
      this.checkinDateTime,
      this.checkouDateTime,
      this.qrcheck});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    status = json['status'];
    visitorname = json['visitorname'];
    persontomeet = json['persontomeet'];
    vechilenumber = json['vechilenumber'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    qrId = json['qrId'];
    purpose = json['purpose'];
    phonenumber = json['phonenumber'];
    checkinDateTime = json['checkinDateTime'];
    checkouDateTime = json['checkouDateTime'];
    qrcheck = json['qrcheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['role'] = role;
    data['status'] = status;
    data['visitorname'] = visitorname;
    data['persontomeet'] = persontomeet;
    data['vechilenumber'] = vechilenumber;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['__v'] = iV;
    data['qrId'] = qrId;
    data['purpose'] = purpose;
    data['phonenumber'] = phonenumber;
    data['checkinDateTime'] = checkinDateTime;
    data['checkouDateTime'] = checkouDateTime;
    data['qrcheck'] = qrcheck;
    return data;
  }
}