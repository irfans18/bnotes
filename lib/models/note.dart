class Note {
  int? id;
  String? title;
  String? description;
  String? category;
  String? dateTime;
  int? isFinished;
  int? isPrivate;

  noteMap(){
    // ignore: prefer_collection_literals
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["title"] = title;
    mapping["description"] = description;
    mapping["category"] = description;
    mapping["date_time"] = dateTime;
    mapping["is_finished"] = isFinished;
    mapping["is_private"] = isPrivate;

    return mapping;
  }
}