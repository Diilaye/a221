class VideoYoutubeModel {
  String? titre;
  String? emission;
  String? url;
  String? isLive;
  String? statusOnline;
  ImageFile? imageFile;
  String? date;
  String? id;

  VideoYoutubeModel(
      {this.titre,
        this.emission,
        this.url,
        this.isLive,
        this.statusOnline,
        this.imageFile,
        this.date,
        this.id});

  VideoYoutubeModel.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    emission = json['emission'];
    url = json['url'];
    isLive = json['isLive'];
    statusOnline = json['statusOnline'];
    imageFile = json['image'] != null
        ? new ImageFile.fromJson(json['image'])
        : null;
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titre'] = this.titre;
    data['emission'] = this.emission;
    data['url'] = this.url;
    data['isLive'] = this.isLive;
    data['statusOnline'] = this.statusOnline;
    if (this.imageFile != null) {
      data['imageFile'] = this.imageFile!.toJson();
    }
    data['date'] = this.date;
    data['id'] = this.id;
    return data;
  }

  static List<VideoYoutubeModel> fromList({required data}) {
    List<VideoYoutubeModel> liste = [];

    for (var element in data) {
      liste.add(VideoYoutubeModel.fromJson(element));
    }
    return liste;
  }
}

class ImageFile {
  String? date;
  String? url;
  String? type;
  String? id;

  ImageFile({this.date, this.url, this.type, this.id});

  ImageFile.fromJson(Map<String, dynamic> json) {
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
}
