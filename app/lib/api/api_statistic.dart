import 'package:http/http.dart' as http;

const String url = "http://10.0.2.2:8000/api";

class StatisticsApi {
 
  getStatsByWeek(userId) async {
    var uri = "$url/week_stats/$userId";
    return await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
      },
    );
  }

  getStatsByMonth(userId) async {
    var uri = "$url/month_stats/$userId";
    return await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
      },
    );
  }

  getStatsByYear(userId) async {
    var uri = "$url/year_stats/$userId";
    return await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
      },
    );
  }

  getStatsByMostExpenses(userId)async{
     var uri = "$url/most_expenses/$userId";
    return await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
      },
    );
  }

   getAllYearStats(userId)async{
     var uri = "$url/all_year_stats/$userId";
    return await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
      },
    );
  }
}
