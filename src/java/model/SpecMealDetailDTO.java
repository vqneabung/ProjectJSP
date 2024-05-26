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

    private int planSpecDetailID;
    private DayDTO day;
    private ProductDTO product;
    private DishDTO dish;
    private SpecMealDTO specMealPlan;
    private int isStatus;

    public SpecMealDetailDTO(int planSpecDetailID, DayDTO day, ProductDTO productID, DishDTO dish, SpecMealDTO specMealPlan, int isStatus) {
        this.planSpecDetailID = planSpecDetailID;
        this.day = day;
        this.product = productID;
        this.dish = dish;
        this.specMealPlan = specMealPlan;
        this.isStatus = isStatus;
    }

    public int getPlanSpecDetailID() {
        return planSpecDetailID;
    }

    public void setPlanSpecDetailID(int planSpecDetailID) {
        this.planSpecDetailID = planSpecDetailID;
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

    public SpecMealDTO getSpecMealPlan() {
        return specMealPlan;
    }

    public void setSpecMealPlan(SpecMealDTO specMealPlan) {
        this.specMealPlan = specMealPlan;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
