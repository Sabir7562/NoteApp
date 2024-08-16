class Note_model {
String title;
String desc;
Note_model({required this.desc,required this.title});
factory Note_model.fromMap(Map<String,dynamic> map){
  return Note_model(desc: map['title'], title: map['desc']);
}
Map<String,dynamic> toMap(){
  return{
    "title":title,
    "desc":desc
  };
}
}