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

    private int planSpecID;
    private String planSpecName;
    private int weekNumber;
    private DayDTO day;
    private int isStatus;

    public SpecMealDTO(int planSpecID, String planSpecName, int weekNumber, DayDTO day, int isStatus) {
        this.planSpecID = planSpecID;
        this.planSpecName = planSpecName;
        this.weekNumber = weekNumber;
        this.day = day;
        this.isStatus = isStatus;
    }

    public int getPlanSpecID() {
        return planSpecID;
    }

    public void setPlanSpecID(int planSpecID) {
        this.planSpecID = planSpecID;
    }

    public String getPlanSpecName() {
        return planSpecName;
    }

    public void setPlanSpecName(String planSpecName) {
        this.planSpecName = planSpecName;
    }

    public int getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(int weekNumber) {
        this.weekNumber = weekNumber;
    }

    public DayDTO getDay() {
        return day;
    }

    public void setDay(DayDTO day) {
        this.day = day;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

}
