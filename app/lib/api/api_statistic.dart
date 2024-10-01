import 'package:gestionary/utils/server_uri.dart';
import 'package:http/http.dart' as http;

const String url = AppURI.URLSERVER;

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
