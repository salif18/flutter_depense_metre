<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;



class AuthController extends Controller
{
    public function loginUser(Request $request)
    {
        //recuperation des donnee de la requette
        $body = $request->only('email', 'password');

        print_r($body);
        // Validation les champs des données du formulaire si c'est requis
        $validedbody = Validator::make($body, [
            'email' => ['required'],
            'password' => ['required'],
        ]);

        // Si la validation échoue, renvoie un message d'erreur
        if ($validedbody->fails()) {
            return response()->json([
                "status"=>false,
                "message"=>$validedbody->errors()
            ],401);
        }

        // Vérification de l'utilisateur dans la base de données
        $user = User::where('email', $body['email'])
                    ->orWhere('numero', $body['email'])
                    ->first();


        // Si l'utilisateur n'existe pas, renvoie un message d'erreur
        if (!$user) {
            return response()->json([
                "status"=>false,
                "message"=>'Votre numéro est incorrect'
            ],401);

        }

        // Vérification du mot de passe
        if (!Hash::check($body['password'], $user->password)) {
            return response()->json([
                "status"=>false,
                "message"=>'Votre mot de passe est incorrect'
            ],401);
        }

        // Authentification réussie, génère un token JWT
        $token = $user->createToken("use_token")->plainTextToken;;

        // Retourne les données de l'utilisateur et le token JWT
        return response()->json([
            'userId' => $user->id,
            'token' => $token
        ]);
    }
}


// class AuthController extends Controller
// {
//     public function login(Request $request)
//     {
//         $credentials = $request->only('contacts', 'password');

//         // Validation des données du formulaire
//         $validator = Validator::make($credentials, [
//             'contacts' => ['required'],
//             'password' => ['required'],
//         ]);

//         // Si la validation échoue, renvoie un message d'erreur
//         if ($validator->fails()) {
//             throw ValidationException::withMessages($validator->errors()->all());
//         }

//         // Vérification de l'utilisateur dans la base de données
//         $user = User::where('email', $credentials['contacts'])
//                     ->orWhere('numero', $credentials['contacts'])
//                     ->first();

//         // Si l'utilisateur n'existe pas, renvoie un message d'erreur
//         if (!$user) {
//             throw ValidationException::withMessages(['contacts' => 'Votre numéro est incorrect']);
//         }

//         // Vérification du mot de passe
//         if (!Hash::check($credentials['password'], $user->password)) {
//             throw ValidationException::withMessages(['password' => 'Votre mot de passe est incorrect']);
//         }

//         // Authentification réussie, génère un token JWT
//         $token = JWTAuth::fromUser($user);

//         // Retourne les données de l'utilisateur et le token JWT
//         return response()->json([
//             'userId' => $user->id,
//             'token' => $token
//         ]);
//     }
// }
