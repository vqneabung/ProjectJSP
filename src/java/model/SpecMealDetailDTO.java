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
    private int productID;
    private DishDTO dish;
    private SpecMealDTO specPlan;
    private int isStatus;

    public SpecMealDetailDTO(int planSpecDetailID, int productID, DishDTO dish, SpecMealDTO specPlan, int isStatus) {
        this.planSpecDetailID = planSpecDetailID;
        this.productID = productID;
        this.dish = dish;
        this.specPlan = specPlan;
        this.isStatus = isStatus;
    }

    public int getPlanSpecDetailID() {
        return planSpecDetailID;
    }

    public void setPlanSpecDetailID(int planSpecDetailID) {
        this.planSpecDetailID = planSpecDetailID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public DishDTO getDish() {
        return dish;
    }

    public void setDish(DishDTO dish) {
        this.dish = dish;
    }

    public SpecMealDTO getSpecPlan() {
        return specPlan;
    }

    public void setSpecPlan(SpecMealDTO specPlan) {
        this.specPlan = specPlan;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
