/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.UserActivityDTO;
import model.UserDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserActivityDAO {

    public static final String INSERT_USER_ACTIVITY = "INSERT INTO [dbo].[UserActivity] ([ActivityDate] ,[UserID]) VALUES (?, ?)";

    public static final String GET_DATA = "Select UserActivityID, ActivityDate, UserID from [dbo].[UserActivity] where UserID = ?";

    public int insertUserActivity(Timestamp activityDate, int userID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_USER_ACTIVITY;
                //INSERT INTO Users (UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setTimestamp(1, activityDate);
                pst.setInt(2, userID);

                rs = pst.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return rs;
    }

    public ArrayList<UserActivityDTO> getUserActivity(int userID) {
        ArrayList<UserActivityDTO> getUserActivityList = new ArrayList<>();
        UserDAO u = new UserDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DATA;
                //Select UserActivityID, ActivityDate, UserID from UserActivity where UserID = ?";  
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int userActivityID = rs.getInt("UserActivityID");
                        Timestamp activityDate = rs.getTimestamp("ActivityDate");
                        UserDTO user = u.getUser(userID);

                        UserActivityDTO getUserActivity = new UserActivityDTO(userActivityID, activityDate, user);
                        getUserActivityList.add(getUserActivity);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return getUserActivityList;

    }

}
