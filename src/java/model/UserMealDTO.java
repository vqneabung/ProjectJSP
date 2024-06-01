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
    private int weekNumber;
    private int isStatus;

    public UserMealDTO(int userMealID, String userMealName, int weekNumber, int isStatus) {
        this.userMealID = userMealID;
        this.userMealName = userMealName;
        this.weekNumber = weekNumber;
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

    public int getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(int weekNumber) {
        this.weekNumber = weekNumber;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
