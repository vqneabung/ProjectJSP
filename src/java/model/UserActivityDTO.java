/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author VQN
 */
public class UserActivityDTO {

    private int userActivityID;
    private Timestamp activityDate;
    private UserDTO user;

    public UserActivityDTO(int userActivityID, Timestamp activityDate, UserDTO user) {
        this.userActivityID = userActivityID;
        this.activityDate = activityDate;
        this.user = user;
    }

    public int getUserActivityID() {
        return userActivityID;
    }

    public void setUserActivityID(int userActivityID) {
        this.userActivityID = userActivityID;
    }

    public Timestamp getActivityDate() {
        return activityDate;
    }

    public void setActivityDate(Timestamp activityDate) {
        this.activityDate = activityDate;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

}
