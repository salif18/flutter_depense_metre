<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Expense;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class Statistique extends Controller
{
    //OBTENIR LE STATISTIQUE PAR WEEK
   public function getExpensesByWeek($userId)
   {
       try {

           $startOfWeek = Carbon::now()->startOfWeek(Carbon::MONDAY);
           $endOfWeek = Carbon::now()->endOfWeek(Carbon::SUNDAY);

           $currentDate = $startOfWeek->copy();
           $data = [];

           while($currentDate <= $endOfWeek){
           $expenses = Expense::whereDate("date_expenses", $currentDate)
               ->where("userId",$userId)
               ->get();
           $totalExpenses = $expenses->sum("amount");

               $data[] = [
                   "date" => $currentDate->format("Y-m-d"),
                   "total" => $totalExpenses,
               ];
               $currentDate->addDay();
       }
       $weekTotalSum = Expense::where("userId",$userId)->whereBetween("date_expenses",[$startOfWeek,$endOfWeek])
       ->sum("amount");

           return response()->json([
               "status" => true,
               "stats" => $data,
               "weekTotal"=>$weekTotalSum
           ],200);

       } catch (\Exception $err) {
           return response()->json([
               "status" => false,
               "message" => "erreur",
               "errors" => $err->getMessage(),
           ], 500);
       }
   }

   public function getExpensesAllDayByMonth($userId){
      try{

        $startOfMonth = Carbon::now()->startOfMonth();
        $endOfMonth = Carbon::now()->endOfMonth();

        $currentDate = $startOfMonth->copy();

        $data = [];

        while($currentDate <= $endOfMonth){
            $expenses = Expense::where("userId",$userId)
            ->whereDate("date_expenses", $currentDate)
            ->get();

            $totalByDay = $expenses->sum("amount");

            $data[]=[
                "date"=> $currentDate->format("Y-m-d"),
                "total"=> $totalByDay,
            ];
            $currentDate->addDay();
        }

        return response()->json([
            "status"=>true,
            "data"=>$data
        ],200);


      }catch(\Exception $err){
        return response()->json([
            "status"=>false,
            "message"=>"erreur de requette ",
            "error"=>$err->getMessage()
        ]);
      }
   }

public function getExpensesByMonth($userId)
{
    try {
        // Récupère toutes les dépenses de l'utilisateur pour l'année en cours, ajustez selon le besoin
        $yearStart = Carbon::now()->startOfYear();
        $yearEnd = Carbon::now()->endOfYear();

        $expenses = Expense::where('userId', $userId)
            ->whereBetween('date_expenses', [$yearStart, $yearEnd])
            ->get()
            ->groupBy(function ($expense) {
                // Grouper les dépenses par mois
                return Carbon::parse($expense->date_expenses)->format('Y-m');
            });

        $data = [];

        $monthTotalDepenser = 0;
        // Calculer la somme des dépenses pour chaque mois
        foreach ($expenses as $month=>$depenses ) {
            $totalExpenses = $depenses->sum('amount');
            $monthTotalDepenser += $totalExpenses;
            $data[] = [
                'month' => $month, // 'Y-m' format, ex: 2024-02
                'total' => $totalExpenses,
            ];
        }

        // Retourner les données en réponse JSON
        return response()->json([
            'status' => true,
            'stats' => $data,
            "monthTotal"=>$monthTotalDepenser
        ],200);

    } catch (\Exception $e) {
        // Gestion des erreurs
        return response()->json([
            'status' => false,
            'message' => 'Une erreur s\'est produite lors de la récupération des dépenses.',
            'errors' => $e->getMessage(),
        ], 500);
    }
}

public function getExpensesByYear($userId)
{
    try {
        // Récupère les dépenses de l'utilisateur pour l'année en cours
        $currentYear = Carbon::now()->year;
        $expenses = Expense::where('userId', $userId)
            ->whereYear('date_expenses', $currentYear)
            ->get();

        // Calcule la somme totale des dépenses pour l'année en cours
        $totalExpenses = $expenses->sum('amount');

        // Retourne les données en réponse JSON
        return response()->json([
            'status' => true,
            'year' => $currentYear,
            'totalExpenses' => $totalExpenses,
        ],200);

    } catch (\Exception $e) {
        // Gestion des erreurs
        return response()->json([
            'status' => false,
            'message' => 'Une erreur s\'est produite lors de la récupération des dépenses.',
            'errors' => $e->getMessage(),
        ], 500);
    }
}

public function mostCategoriExpenses($userId){
    try{
        $currentMonth = now()->startOfMonth();
        $currentYear = now()->year;

        $expensesByCategory = Expense::select('categorie_id', DB::raw('SUM(amount) as total_amount'))
            ->where('userId', $userId)
            ->whereYear('date_expenses', $currentYear)
            ->whereMonth('date_expenses', $currentMonth)
            ->groupBy('categorie_id')
            ->with("category")
            ->orderByDesc('total_amount')
            ->first();


    return response()->json([
      "status"=>true,
      "expenses"=>$expensesByCategory,
    ],200);

    }catch(\Exception $err){
       return response()->json([
         "status"=>false,
         "message"=>"Erreur survenue",
         "error"=>$err->getMessage()
       ],500);
    }
}

public function getAllExpensesForYear($userId){

    try {
        // Récupère toutes les dépenses de l'utilisateur pour toutes les années
        $expenses = Expense::where('userId', $userId)
            ->orderBy('date_expenses') // Assurez-vous que les dépenses sont triées par date
            ->get()
            ->groupBy(function ($expense) {
                // Grouper les dépenses par mois et année
                return Carbon::parse($expense->date_expenses)->format('Y-m');
            });

        $data = [];
        $totalDepenses = 0;

        // Calculer la somme des dépenses pour chaque mois
        foreach ($expenses as $month => $depenses) {
            $totalExpenses = $depenses->sum('amount');
            $totalDepenses += $totalExpenses;
            $data[] = [
                'month' => $month, // 'Y-m' format, ex: 2024-02
                'total' => $totalExpenses,
            ];
        }

        // Retourner les données en réponse JSON
        return response()->json([
            'status' => true,
            'stats' => $data,
            'totalExpenses' => $totalDepenses,
        ], 200);

    } catch (\Exception $e) {
        // Gestion des erreurs
        return response()->json([
            'status' => false,
            'message' => 'Une erreur s\'est produite lors de la récupération des dépenses.',
            'errors' => $e->getMessage(),
        ], 500);
    }

}
}
