class Note {
  int? id;
  String? title;
  String? content;

  Note({
    this.id,
    this.title,
    this.content,
  });

  Note.fromMap(Map<String, dynamic> map){
    id = map['id'];
    title = map['title'];
    content = map['content'];
  }

  toMap(){
    return {
      "id" : id,
      "title" : title ,
      "content" : content ,
    };

  }

}
