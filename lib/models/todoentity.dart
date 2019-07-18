class TodoEntity {
  String filepath;
  int linenum;
  String info;

  TodoEntity(this.filepath, this.linenum, this.info);

  TodoEntity.fromJson(Map<String, dynamic> json)
    : filepath = json['filepath'],
      linenum = json['linenum'],
      info = json['info'];

  Map<String, dynamic> toJson() =>
    {
      'filepath': filepath,
      'linenum': linenum,
      'info': info
    };
}