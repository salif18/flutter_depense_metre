<?php

namespace App\Http\Controllers;

use App\Models\Budget;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class Budget_controller extends Controller
{
    public function createBudgets(Request $req)
    {
        try {

            $validator = Validator::make($req->all(), [
                "userId" => "required",
                "budget_amount" => "required",
            ]);

            // Si la validation échoue, renvoyer un message d'erreur
            if ($validator->fails()) {
                return response()->json([
                    "status" => false,
                    "message" => "Veuillez remplir tous les champs correctement",
                    "errors" => $validator->errors()
                ], 400);
            }

            $currentYear = Carbon::now()->year;
            $currentMonth = Carbon::now()->month;

            //verifier si un budget existe dejas pour ce mois
            $existingBudget = Budget::where("userId", $req->userId)
                ->whereYear("budget_date", $currentYear)
                ->whereMonth("budget_date", $currentMonth)
                ->first();

            if ($existingBudget) {
                return response()->json([
                    "status" => false,
                    "message" => "Un budget pour ce mois existe déjà !"
                ], 400);
            }

            $budgets = Budget::create([
                "userId" => $req->userId,
                "budget_amount" => $req->budget_amount,
                "budget_date" => $req->budget_date ?? now()
            ]);

            return response()->json([
                "status" => true,
                "budgets" => $budgets,
                "message" => "Budget ajoutee"
            ], 200);

        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "error" => $err->getMessage()
            ], 500);
        }
    }
    public function getCurrentBudget($userId)
    {
        try {

            // Obtenir la date actuelle
            $currentDate = Carbon::now();

            // Récupérer le mois et l'année actuels
            $currentMonth = $currentDate->month;
            $currentYear = $currentDate->year;

            $budgets = Budget::where("userId", $userId)
                ->whereMonth('created_at', $currentMonth)
                ->whereYear('created_at', $currentYear)
                ->first();

            if ($budgets) {
                return response()->json([
                    "status" => true,
                    "budget" => $budgets
                ], 200);

            } else {
                return response()->json([
                    "status" => false,
                    "message" => "Aucun budget trouvé pour le mois en cours"
                ], 404);
            }


        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "error" => $err->getMessage()
            ], 500);
        }
    }
    public function getRapportsCurrentBudget($userId)
    {
        try {

            // Obtenir la date actuelle
            $currentDate = Carbon::now();

            // Récupérer le mois et l'année actuels
            $currentMonth = $currentDate->month;
            $currentYear = $currentDate->year;

            $budgets = Budget::where("userId", $userId)
                ->with('depense')
                ->whereMonth('created_at', $currentMonth)
                ->whereYear('created_at', $currentYear)
                ->first();

            if ($budgets) {
                // Calculer la somme des dépenses liées à ce budget
                $totalExpenses = $budgets->depense->sum('amount');
                //calcule le poucentage
                $percentage = ($totalExpenses * 100) / $budgets->budget_amount;
                //restant
                $epargne = $budgets->budget_amount - $totalExpenses;
                // Ajouter la somme des dépenses et poucentage au budget
                $budgets->totalExpenses = $totalExpenses;
                $budgets->epargnes = $epargne;
                $budgets->percent = number_format($percentage,1);

                //definir le resultat a retourner
                $result = [
                    "id" => $budgets["id"],
                    "userId" => $budgets["userId"],
                    "budget_amount" => $budgets["budget_amount"],
                    "budget_date" => $budgets["budget_date"],
                    "totalExpenses" => $budgets["totalExpenses"],
                    "epargnes" => $epargne,
                    "percent" => $budgets["percent"],
                ];
                return response()->json([
                    "status" => true,
                    "resultat" => $result,
                    "expensesLieTobudget" => $budgets->depense

                ], 200);

            } else {
                return response()->json([
                    "status" => false,
                    "message" => "Aucun budget trouvé pour le mois en cours"
                ], 404);
            }


        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "error" => $err->getMessage()
            ], 500);
        }
    }


    public function getAllBudget($userId)
    {
        try {

            $budgets = Budget::where("userId", $userId)
                ->with('depense')->orderByDesc("budget_date")
                ->get();

            if (!$budgets) {
                return response()->json([
                    "status" => false,
                    "message" => "aucuns donnees existants"
                ]);
            }

            return response()->json([
                "status" => true,
                "ExpensesOfBudget" => $budgets
            ], 200);

        } catch (\Exception $err) {
            return response()->json([
                "status" => false,
                "message" => "erreur de requette",
                "error" => $err->getMessage()
            ]);
        }
    }
}
