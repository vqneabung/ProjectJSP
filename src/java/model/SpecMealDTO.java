/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class SpecMealDTO {

    private int specMealID;
    private String specMealName;
    private int weekNumber;
    private int isStatus;

    public SpecMealDTO(int specMealID, String specMealName, int weekNumber, int isStatus) {
        this.specMealID = specMealID;
        this.specMealName = specMealName;
        this.weekNumber = weekNumber;
        this.isStatus = isStatus;
    }

    public int getSpecMealID() {
        return specMealID;
    }

    public void setSpecMealID(int specMealID) {
        this.specMealID = specMealID;
    }

    public String getSpecMealName() {
        return specMealName;
    }

    public void setSpecMealName(String specMealName) {
        this.specMealName = specMealName;
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
