/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class RecipeDetailDTO {

    private int recipeDetailID;
    private ProductDTO food;
    private ProductDTO ingredient;
    private int status;

    public RecipeDetailDTO(int recipeDetailID, ProductDTO food, ProductDTO ingredient, int status) {
        this.recipeDetailID = recipeDetailID;
        this.food = food;
        this.ingredient = ingredient;
        this.status = status;
    }

    public int getRecipeDetailID() {
        return recipeDetailID;
    }

    public void setRecipeDetailID(int recipeDetailID) {
        this.recipeDetailID = recipeDetailID;
    }

    public ProductDTO getFood() {
        return food;
    }

    public void setFood(ProductDTO food) {
        this.food = food;
    }

    public ProductDTO getIngredient() {
        return ingredient;
    }

    public void setIngredient(ProductDTO ingredient) {
        this.ingredient = ingredient;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
