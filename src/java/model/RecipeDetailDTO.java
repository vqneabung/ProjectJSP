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

    private ProductDTO food;
    private ProductDTO ingredient;

    public RecipeDetailDTO(ProductDTO food, ProductDTO ingredient) {
        this.food = food;
        this.ingredient = ingredient;
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

}
