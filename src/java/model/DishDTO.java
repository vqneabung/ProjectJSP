/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class DishDTO {

    private int dishID;
    private int dishName;

    public DishDTO(int dishID, int dishName) {
        this.dishID = dishID;
        this.dishName = dishName;
    }

    public int getDishID() {
        return dishID;
    }

    public void setDishID(int dishID) {
        this.dishID = dishID;
    }

    public int getDishName() {
        return dishName;
    }

    public void setDishName(int dishName) {
        this.dishName = dishName;
    }

}
