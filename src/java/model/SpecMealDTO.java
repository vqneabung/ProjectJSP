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

    private int specPlanID;
    private String specPlanName;
    private int weekNumber;
    private int isStatus;

    public SpecMealDTO(int specPlanID, String specPlanName, int weekNumber, int isStatus) {
        this.specPlanID = specPlanID;
        this.specPlanName = specPlanName;
        this.weekNumber = weekNumber;
        this.isStatus = isStatus;
    }

    public int getSpecPlanID() {
        return specPlanID;
    }

    public void setSpecPlanID(int specPlanID) {
        this.specPlanID = specPlanID;
    }

    public String getSpecPlanName() {
        return specPlanName;
    }

    public void setSpecPlanName(String specPlanName) {
        this.specPlanName = specPlanName;
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
