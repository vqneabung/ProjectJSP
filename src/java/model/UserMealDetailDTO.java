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

    private int userMealDetailID;
    private DayDTO day;
    private ProductDTO product;
    private DishDTO dish;
    private UserMealDTO userMeal;
    private int isStatus;

    public UserMealDetailDTO(int userMealDetailID, DayDTO day, ProductDTO product, DishDTO dish, UserMealDTO userMeal, int isStatus) {
        this.userMealDetailID = userMealDetailID;
        this.day = day;
        this.product = product;
        this.dish = dish;
        this.userMeal = userMeal;
        this.isStatus = isStatus;
    }

    public int getUserMealDetailID() {
        return userMealDetailID;
    }

    public void setUserMealDetailID(int userMealDetailID) {
        this.userMealDetailID = userMealDetailID;
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

    public UserMealDTO getUserMeal() {
        return userMeal;
    }

    public void setUserMeal(UserMealDTO userMeal) {
        this.userMeal = userMeal;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
