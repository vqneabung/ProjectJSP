/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.UserMealDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserMealDAO {

    public static final String GET_DATA = "select [UserPlanID],[UserPlanName],[WeekNumber],[IsStatus] from UserMeal";

    public static final String GET_USERMEAL = "select [UserPlanID],[UserPlanName],[WeekNumber],[IsStatus] from UserMeal Where UserPlanID = ? ";

    public ArrayList<UserMealDTO> getAllUserMeal() {
        ArrayList<UserMealDTO> userMealList = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query

                String sql = GET_DATA;
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int userMealID = rs.getInt("UserPlanID");
                        String userMealName = rs.getString("UserPlanName");
                        int weekNumber = rs.getInt("WeekNumber");
                        int IsStatus = rs.getInt("IsStatus");

                        UserMealDTO userMeal = new UserMealDTO(userMealID, userMealName, weekNumber, IsStatus);
                        userMealList.add(userMeal);
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
        return userMealList;
    }

    public UserMealDTO getUserMeal(int userMealID) {
        UserMealDTO userMeal = null;

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_USERMEAL;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userMealName = rs.getString("UserPlanName");
                    int weekNumber = rs.getInt("WeekNumber");
                    int IsStatus = rs.getInt("IsStatus");

                    userMeal = new UserMealDTO(userMealID, userMealName, weekNumber, IsStatus);

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
        return userMeal;

    }
}
