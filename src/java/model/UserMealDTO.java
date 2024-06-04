/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class UserMealDTO {

    private int userMealID;
    private String userMealName;
    private UserDTO userID;
    private int isStatus;

    public UserMealDTO(int userMealID, String userMealName, UserDTO userID, int isStatus) {
        this.userMealID = userMealID;
        this.userMealName = userMealName;
        this.userID = userID;
        this.isStatus = isStatus;
    }

    public int getUserMealID() {
        return userMealID;
    }

    public void setUserMealID(int userMealID) {
        this.userMealID = userMealID;
    }

    public String getUserMealName() {
        return userMealName;
    }

    public void setUserMealName(String userMealName) {
        this.userMealName = userMealName;
    }

    public UserDTO getUserID() {
        return userID;
    }

    public void setUserID(UserDTO userID) {
        this.userID = userID;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
