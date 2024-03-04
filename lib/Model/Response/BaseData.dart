class DummyData {
  List<ListData>? listData;

  DummyData({this.listData});

  DummyData.fromJson(List<dynamic> json) {
    listData = <ListData>[];
    json.forEach((v) {
      listData!.add(new ListData.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listData != null) {
      data['listData'] = listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  int? id;
  String? title;

  ListData({this.id, this.title});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}