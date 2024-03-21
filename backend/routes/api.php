<?php

use App\Http\Controllers\Auth_controller;
use App\Http\Controllers\Categorie_controller;
use App\Http\Controllers\Expense_controller;
use App\Http\Controllers\Budget_controller;
use App\Http\Controllers\Profil_controller;
use App\Http\Controllers\User_recuperation;
use App\Http\Controllers\statistique;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//AUTHENTIFICATIONS
Route::middleware("auth:sanctum")->post("/logout",[Auth_controller::class,"logout"]);
Route::post("/registre",[Auth_controller::class,"registre"]);
Route::post("/login",[Auth_controller::class,"login"]);
Route::post("/update_password/{userId}",[Auth_controller::class,"updatePassword"]);
Route::post("/delete",[Auth_controller::class,"delete"]);

//RECUPERATION COMPTE
Route::post("/reset_password",[User_recuperation::class,"reset"]);
Route::post("/validate_password",[User_recuperation::class,"validation"]);

//PROFIL
Route::post("/update/{userId}",[Profil_controller::class,"updateProfil"]);

// REQUETTES EXPENSES
Route::post("/expenses",[Expense_controller::class,"createExpenses"]);
Route::get("/expenses/month/{userId}",[Expense_controller::class,"getExpensesByUserMonth"]);
Route::get("/expenses/day/{userId}",[Expense_controller::class,"getExpensesByUserDay"]);

//STATISTIQUES
Route::get("/week_stats/{userId}",[Statistique::class,"getExpensesByWeek"]);
Route::get("/daybymonth_stats/{userId}",[Statistique::class,"getExpensesAllDayByMonth"]);
Route::get("/month_stats/{userId}",[Statistique::class,"getExpensesByMonth"]);
Route::get("/year_stats/{userId}",[Statistique::class,"getExpensesByYear"]);
Route::get('/most_expenses/{userId}',[Statistique::class,"mostCategoriExpenses"]);
Route::get('/all_year_stats/{userId}',[Statistique::class,"getAllExpensesForYear"]);
//SEARCHE
Route::get("/expenses/{searchTerm}",[Expense_controller::class,"searchValue"]);
Route::delete("/expenses/{id}",[Expense_controller::class,"deleteExpenses"]);

//REQUETTES CATEGORIES
Route::post("/categories",[Categorie_controller::class,"createCategorys"]);
Route::get("/categories",[Categorie_controller::class,"getCategorys"]);

//REQUETTES BUDGETS
Route::post("/budgets",[Budget_controller::class,"createBudgets"]);
Route::get("/current_budget/{userId}",[Budget_controller::class,"getCurrentBudget"]);
Route::get("/rapports_currentBudget/{userId}",[Budget_controller::class,"getRapportsCurrentBudget"]);
Route::get("/all/budgets/{userId}",[Budget_controller::class,"getAllBudget"]);
