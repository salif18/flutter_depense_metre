<?php

namespace App\Http\Controllers;

use App\Models\Expense;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class Expense_Controller extends Controller
{

    //add new depenses
    public function createExpenses(Request $req)
    {
        try {
            // Valider les données de la requête
            $validator = Validator::make($req->all(), [
                "userId" => "required",
                "categorie_id" => "required",
                "budgetId"=>"required",
                "amount" => "required",
                "description" => "required",
            ]);

            // Si la validation échoue, renvoyer un message d'erreur
            if ($validator->fails()) {
                return response()->json([
                    "status" => false,
                    "message" => "Veuillez remplir tous les champs correctement",
                    "errors" => $validator->errors()
                ], 400);
            }

            // Créer la dépense
            $expense = Expense::create([
                "userId" => $req->userId,
                "categorie_id" => $req->categorie_id,
                "budgetId"=>$req->budgetId,
                "amount" => $req->amount,
                "description" => $req->description,
                "date_expenses" => $req->date_expenses ?? now()
            ]);

            // Retourner une réponse avec la dépense créée
            return response()->json([
                "status" => true,
                "message" => "Dépense ajoutée avec succès !",
                "expense" => $expense
            ], 201);

        } catch (\Exception $error) {
            // En cas d'erreur, renvoyer un message d'erreur avec le code 500
            return response()->json([
                "status" => false,
                "message" => "Une erreur est survenue lors de l'ajout de la dépense.",
                "error" => $error->getMessage()
            ], 500);
        }
    }

    //OBTENIR LES DONNE FILTRER SELON USER MOIS ET ANNEE
    public function getExpensesByUserMonth($userId)
    {
        try {
            $currentMonth = Carbon::now()->month;
            // Effectuer la requête pour récupérer les dépenses correspondantes
            $expenses = Expense::where('userId', $userId)
                ->whereMonth('date_expenses', $currentMonth)
                ->orderByDesc("date_expenses")
                ->with("category")
                ->get();

            $totalMonth = $expenses->sum("amount");
            // Retourner les dépenses au format JSON ou à la vue, selon vos besoins
            return response()->json([
                "status" => true,
                "month"=>Carbon::now()->locale("fr")->monthName,
                "expenses" => $expenses,
                "totalMonth"=>$totalMonth
            ], 200);

        } catch (\Exception $error) {
            return response()->json([
                "status" => false,
                "message" => "Une erreur est survenue ",
                "error" => $error->getMessage()
            ], 500);
        }
    }

    //OBTENIR LES DONNEES FILTRER PAR USER SELON LE JOUR LE MOIS ET L'ANNEE
    public function getExpensesByUserDay($userId)
    {
        try {

            $currentDate = Carbon::now()->toDateString();
            // Effectuer la requête pour récupérer les dépenses correspondantes
            $expenses = Expense::where('userId', $userId)
                ->whereDate('date_expenses', $currentDate)
                ->orderByDesc("date_expenses")
                ->with("category")
                ->get()
                ;

            $totalDay = $expenses->sum("amount");
            // Retourner les dépenses au format JSON ou à la vue, selon vos besoins
            return response()->json([
                "status" => true,
                "day"=>Carbon::parse($currentDate)->locale("fr")->dayName,
                "expenses" => $expenses,
                "totalDay"=>$totalDay
            ], 200);

        } catch (\Exception $error) {
            return response()->json([
                "status" => false,
                "message" => "Une erreur est survenue ",
                "error" => $error->getMessage()
            ], 500);
        }
    }
    //RECHERCHER UN DONNEE SELON LE MONTANT OU CATEGORIE
    public function searchValue($searchTerm)
    {
        try {
            // Exécuter la requête de recherche
            $results = Expense::where('amount', 'like', '%' . $searchTerm . '%')
                ->with("category")
                ->with("user")
                ->get();

            if ($results->count() == 0) {
                return response()->json([
                    'status' => true,
                    'results' => "Ce donne n'existe pas"
                ], 200);
            }
            // Retourner les résultats de la recherche
            return response()->json([
                'status' => true,
                'results' => $results
            ], 200);

        } catch (\Exception $error) {
            return response()->json([
                'status' => false,
                'message' => 'Une erreur est survenue lors de la recherche.',
                'error' => $error->getMessage()
            ], 500);
        }
    }

    //SUPPRIMER UN DONNEE
    public function deleteExpenses($id)
    {
        try {
            // Supprimer la dépense par son ID directement
            Expense::destroy($id);

            return response()->json([
                "status" => true,
                "message" => "Depense supprimer avec success",
            ], 200);

        } catch (\Exception $error) {
            return response()->json([
                "status" => false,
                "message" => "Une Error s'est produite dans la suppression .",
                "error" => $error->getMessage()
            ], 500);
        }
    }
}
