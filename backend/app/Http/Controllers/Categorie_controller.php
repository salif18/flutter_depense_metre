<?php

namespace App\Http\Controllers;

use App\Models\Categorie;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class Categorie_controller extends Controller
{
    //AJOUT DE NOUVEAUX CATEGORIES
    public function createCategorys(Request $req){
     try{
      $data = $req->all();

      $verifyField = Validator::make($data,[
         "userId"=>"required",
         "name_categories"=>"required|string"
      ]);

      if($verifyField->fails()){
        return response()->json([
            "status"=>false,
            "message"=>"Veuillez ajouter la categorie .",
         ]);
      }

      $categorie = Categorie::create($data);

      return response()->json([
        "status"=>true,
        "message"=>"Categorie ajouté .",
        "categorie"=>$categorie
     ],201);

     }catch(\Exception $error){
        return response()->json([
           "status"=>false,
           "message"=>"Erreur survenue l'ors de la requette .",
           "error"=> $error->getMessage()
        ],500);
    }
   }

   //RECUPERER CATEGORIES
   public function getCategorys($userId){
       try{
          $categories = Categorie::whereNull("userId")
          ->orWhere("userId",$userId)
          ->orderBy("name_categories")
          ->get();

          return response()->json([
            "status"=>true,
            "categories"=>$categories
          ],200);

       }catch(\Exception $error){
        return response()->json([
            "status"=>false,
            "message"=>"Erreur survenue l'ors de la requette .",
            "error"=> $error->getMessage()
        ],500);
       }
   }
}
