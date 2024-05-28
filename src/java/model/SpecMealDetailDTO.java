/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class SpecMealDetailDTO {

    private int specMealDetailID;
    private DayDTO day;
    private ProductDTO product;
    private DishDTO dish;
    private SpecMealDTO specMeal;
    private int isStatus;

    public SpecMealDetailDTO(int specMealDetailID, DayDTO day, ProductDTO productID, DishDTO dish, SpecMealDTO specMeal, int isStatus) {
        this.specMealDetailID = specMealDetailID;
        this.day = day;
        this.product = productID;
        this.dish = dish;
        this.specMeal = specMeal;
        this.isStatus = isStatus;
    }

    public int getSpecMealDetailID() {
        return specMealDetailID;
    }

    public void setSpecMealDetailID(int specMealDetailID) {
        this.specMealDetailID = specMealDetailID;
    }

    public DayDTO getDay() {
        return day;
    }

    public void setDay(DayDTO day) {
        this.day = day;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public DishDTO getDish() {
        return dish;
    }

    public void setDish(DishDTO dish) {
        this.dish = dish;
    }

    public SpecMealDTO getSpecMeal() {
        return specMeal;
    }

    public void setSpecMeal(SpecMealDTO specMeal) {
        this.specMeal = specMeal;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
