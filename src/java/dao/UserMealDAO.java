/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
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
    
    public static final String GET_DATA = "";

    public ArrayList<UserMealDTO> getAllUserMeal() {
        ArrayList<UserMealDTO> specMealList = new ArrayList<>();

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
                        int planSpecMealID = rs.getInt("SpecPlanID");
                        String planSpecName = rs.getString("SpecPlanName");
                        int weekNumber = rs.getInt("WeekNumber");
                        int IsStatus = rs.getInt("IsStatus");

                        UserMealDTO userMeal = new UserMealDTO(planSpecMealID, planSpecName, weekNumber, IsStatus);
                        specMealList.add(specMeal);
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

    }
}
