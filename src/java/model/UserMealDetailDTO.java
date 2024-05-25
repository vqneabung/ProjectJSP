/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class UserMealDetailDTO {

    private int PlanUserDetailID;
    private ProductDTO product;
    private UserMealDTO userMeal;

    public UserMealDetailDTO(int PlanUserDetailID, ProductDTO product, UserMealDTO userMeal) {
        this.PlanUserDetailID = PlanUserDetailID;
        this.product = product;
        this.userMeal = userMeal;
    }

    public int getPlanUserDetailID() {
        return PlanUserDetailID;
    }

    public void setPlanUserDetailID(int PlanUserDetailID) {
        this.PlanUserDetailID = PlanUserDetailID;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public UserMealDTO getUserMeal() {
        return userMeal;
    }

    public void setUserMeal(UserMealDTO userMeal) {
        this.userMeal = userMeal;
    }
    
    
}
