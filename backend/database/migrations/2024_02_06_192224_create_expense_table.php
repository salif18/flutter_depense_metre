<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('expenses', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('userId')->nullable();
            $table->unsignedBigInteger('categorie_id')->nullable();
            $table->unsignedBigInteger('budgetId')->nullable();
            $table->integer('amount')->nullable();
            $table->string('description')->nullable();
            // $table->string('epargnes')->nullable();
            $table->foreign('userId')->references("id")->on("users");
            $table->foreign("categorie_id")->references("id")->on("categories");
            $table->foreign('budgetId')->references("id")->on("budgets");
            $table->date('date_expenses')->default(now());
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expenses');
    }
};
