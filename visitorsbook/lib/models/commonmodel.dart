class CommonModel {
  late final bool status;
  late final String msg;
  late final bool canCheckin;
  // late final String id;

  CommonModel({required this.status});
  CommonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['canCheckin'] != null) {
      canCheckin = json['canCheckin'];
    }

    // if (json['id'] != null) {
    //   id = json['id'];
    // }
  }
}
