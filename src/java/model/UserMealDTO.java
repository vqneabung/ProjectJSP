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

    private int planUserID;
    private UserDTO user;
    private DayDTO day;
    private int weekNumber;

    public UserMealDTO(int planUserID, UserDTO user, DayDTO day, int weekNumber) {
        this.planUserID = planUserID;
        this.user = user;
        this.day = day;
        this.weekNumber = weekNumber;
    }

    public int getPlanUserID() {
        return planUserID;
    }

    public void setPlanUserID(int planUserID) {
        this.planUserID = planUserID;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public DayDTO getDay() {
        return day;
    }

    public void setDay(DayDTO day) {
        this.day = day;
    }

    public int getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(int weekNumber) {
        this.weekNumber = weekNumber;
    }

}
