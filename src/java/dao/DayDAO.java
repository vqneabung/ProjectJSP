/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.ProductDAO.GET_PRODUCT_BY_NAME;
import static dao.SpecMealDAO.GET_DATA;
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
public class DayDAO {

    public static final String GET_DATA = "select [DayNum], [DayText] from Day";

    public static final String GET_DAY = "select [DayNum], [DayText] from Day WHERE DayNum = ?";

    public ArrayList<DayDTO> getAllDay() {
        ArrayList<DayDTO> dayList = new ArrayList<>();

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
                        int dayNum = rs.getInt("DayNum");
                        String dayText = rs.getString("DayText");

                        DayDTO day = new DayDTO(dayNum, dayText);
                        dayList.add(day);
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

        return dayList;

    }

    public DayDTO getDay(int dayNum) {
        DayDTO day = null;

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DAY;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, dayNum);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String dayText = rs.getString("DayText");
                    day = new DayDTO(dayNum, dayText);

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
        return day;

    }
}
