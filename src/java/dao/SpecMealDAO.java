/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.ProductDAO.GET_DATA;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.CategoryDTO;
import model.DayDTO;
import model.ProductDTO;
import model.SpecMealDTO;
import model.TypeDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class SpecMealDAO {

    public static final String GET_DATA = "select [SpecPlanID],[SpecPlanName],[WeekNumber],[IsStatus] from SpecMeal";

    public static final String GET_SPECMEAL = "select [SpecPlanID],[SpecPlanName],[WeekNumber],[IsStatus] from SpecMeal Where SpecPlanID = ? ";



    public ArrayList<SpecMealDTO> getAllSpecMeal() {
        ArrayList<SpecMealDTO> specMealList = new ArrayList<>();

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

                        SpecMealDTO specMeal = new SpecMealDTO(planSpecMealID, planSpecName, weekNumber, IsStatus);
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

        return specMealList;

    }

    public SpecMealDTO getSpecMeal(int specPlanMealID) {
        SpecMealDTO specMeal = null;

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_SPECMEAL;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, specPlanMealID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String planSpecName = rs.getString("SpecPlanName");
                    int weekNumber = rs.getInt("WeekNumber");
                    int IsStatus = rs.getInt("IsStatus");

                    specMeal = new SpecMealDTO(specPlanMealID, planSpecName, weekNumber, IsStatus);

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
        return specMeal;

    }

    

}
