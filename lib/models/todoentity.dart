class TodoEntity {
  String filename;
  int linenum;
  String info;

  TodoEntity(this.filename, this.linenum, this.info);

  TodoEntity.fromJson(Map<String, dynamic> json)
    : filename = json['filename'],
      linenum = json['linenum'],
      info = json['info'];

  Map<String, dynamic> toJson() =>
    {
      'filename': filename,
      'linenum': linenum,
      'info': info
    };
}