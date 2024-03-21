<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
class Profil_controller extends Controller
{
    // UPDATE PROFIL
    public function updateProfil(Request $req, $userId)
    {
        try {
            $user = User::find($userId);

            if (!$user) {
                return response()->json([
                    "status" => false,
                    "message" => "Utilisateur non trouvé"
                ], 404);
            }

            $user->update([
                "name" => $req->name ?? $user->name,
                "phone_number" => $req->phone_number ?? $user->phone_number,
                "email" => $req->email ?? $user->email
            ]);

            return response()->json([
                "status" => true,
                "message" => "Modification apportée avec succès !!",
                "profil" => [
                    "name" => $user->name,
                    "number" => $user->phone_number,
                    "email" => $user->email
                ]
            ], 200);

        } catch (\Exception $error) {
            return response()->json([
                "status" => false,
                "message" => $error->getMessage()
            ], 500);
        }
    }

}
