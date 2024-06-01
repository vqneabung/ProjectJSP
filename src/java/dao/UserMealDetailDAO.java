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
import model.DayDTO;
import model.DishDTO;
import model.ProductDTO;
import model.SpecMealDTO;
import model.UserMealDTO;
import model.UserMealDetailDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserMealDetailDAO {

    public static final String GET_DATA = "select  [UserPlanDetailID], [ProductID], [DishID], [IsStatus], DayNum, [UserPlanID] from UserMealDetail";

    public static final String GET_USERMEALDETAIL_BY_USERMEALID = "select  [UserPlanDetailID], [ProductID], [DishID], [IsStatus], DayNum, [UserPlanID] from UserMealDetail WHERE UserPlanID = ?";

    public static final String GET_USERMEALDETAIL_BY_ID = "select  [UserPlanDetailID], [ProductID], [DishID], [IsStatus], DayNum, [UserPlanID] from UserMealDetail WHERE UserPlanDetailID = ?";

    public ArrayList<UserMealDetailDTO> getAllUserMealDetail() {

        ArrayList<UserMealDetailDTO> userMealDetailList = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        UserMealDAO um = new UserMealDAO();

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
                        int UserPlanDetailID = rs.getInt("UserPlanDetailID");
                        ProductDTO product = p.getProduct(rs.getInt("ProductID"));
                        DishDTO dish = dh.getDish(rs.getInt("DishID"));
                        int isStatus = rs.getInt("IsStatus");
                        DayDTO day = d.getDay(rs.getInt("DayNum"));
                        UserMealDTO specMealPlan = um.getUserMeal(rs.getInt("UserPlanID"));

                        UserMealDetailDTO specMealDetail = new UserMealDetailDTO(UserPlanDetailID, day, product, dish, specMealPlan, isStatus);
                        userMealDetailList.add(specMealDetail);
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

        return userMealDetailList;

    }

    public ArrayList<UserMealDetailDTO> getAllUserMealDetailByUserMealID(UserMealDTO userMealID) {

        ArrayList<UserMealDetailDTO> userMealDetailListByUserMealID = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        UserMealDAO um = new UserMealDAO();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                String sql = GET_USERMEALDETAIL_BY_USERMEALID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID.getUserMealID());
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int userMealDetailID = rs.getInt("UserPlanDetailID");
                        ProductDTO product = p.getProduct(rs.getInt("ProductID"));
                        DishDTO dish = dh.getDish(rs.getInt("DishID"));
                        DayDTO day = d.getDay(rs.getInt("DayNum"));
                        int isStatus = rs.getInt("IsStatus");

                        UserMealDetailDTO userMealDetail = new UserMealDetailDTO(userMealDetailID, day, product, dish, userMealID, isStatus);
                        userMealDetailListByUserMealID.add(userMealDetail);
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

        return userMealDetailListByUserMealID;

    }

    public UserMealDetailDTO getUserMealDetail(int userMealDetailID) {
        UserMealDetailDTO userMealDetail = null;
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        UserMealDAO sm = new UserMealDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_USERMEALDETAIL_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealDetailID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    ProductDTO product = p.getProduct(rs.getInt("ProductID"));
                    DayDTO day = d.getDay(rs.getInt("DayNum"));
                    DishDTO dish = dh.getDish(rs.getInt("DishID"));
                    UserMealDTO userMeal = sm.getUserMeal(rs.getInt("UserPlanID"));
                    int isStatus = rs.getInt("IsStatus");

                    userMealDetail = new UserMealDetailDTO(userMealDetailID, day, product, dish, userMeal, isStatus);

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
        return userMealDetail;

    }

}
