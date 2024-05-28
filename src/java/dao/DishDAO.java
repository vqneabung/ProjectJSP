/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.ProductDAO.GET_PRODUCT_BY_NAME;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.CategoryDTO;
import model.DishDTO;
import model.ProductDTO;
import model.TypeDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class DishDAO {

    public static final String GET_DISH = "select * from Dish where DishID = ?";

    public static final String GET_DATA = "select * from Dish";

    public ArrayList<DishDTO> getAllDish() {
        ArrayList<DishDTO> dishList = new ArrayList<>();

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
                        int dishNum = rs.getInt("dishID");
                        String dishName = rs.getString("dishName");

                        DishDTO dish = new DishDTO(dishNum, dishName);
                        dishList.add(dish);
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

        return dishList;

    }

    public DishDTO getDish(int dishID) {
        DishDTO dish = null;

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DISH;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, dishID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String dishName = rs.getString("dishName");
                    dish = new DishDTO(dishID, dishName);
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
        return dish;

    }
}
