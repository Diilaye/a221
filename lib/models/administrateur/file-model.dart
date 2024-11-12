class FileModel {
  String? date;
  String? url;
  String? type;
  String? id;

  FileModel({this.date, this.url, this.type, this.id});

  FileModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    url = json['url'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['url'] = this.url;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }

  static List<FileModel> fromList({required data}) {
    List<FileModel> liste = [];

    for (var element in data) {
      liste.add(FileModel.fromJson(element));
    }
    return liste;
  }
}
