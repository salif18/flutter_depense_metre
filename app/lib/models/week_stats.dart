class ModelWeekStats{
  String? date;
  int? total;

 ModelWeekStats({
  required this.date,
  required this.total
 });

 factory ModelWeekStats.fromJson(Map<String,dynamic> json){
  return ModelWeekStats(
    date: json['date'] ?? "", 
    total: json["total"] ?? ""
    );
 }
 Map<String,dynamic> toJson(){
  return {
     "date":date,
     "total":total
  };
}
}
