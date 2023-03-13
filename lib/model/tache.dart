class Tache{

  String tacheIntutile;
  String description;
  DateTime date;

  Tache(this.tacheIntutile,this.description,this.date);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map={
      "tache": tacheIntutile,
      "description": description,
      "date": date
    };
    return map;
  }

}