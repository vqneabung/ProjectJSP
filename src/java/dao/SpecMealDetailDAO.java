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
import model.SpecMealDetailDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class SpecMealDetailDAO {

    private static final String GET_DATA = "select  [SpecPlanDetailID], [ProductID], [DishID], [IsStatus], DayNum, [SpecPlanID] from SpecMealDetail";

    private static final String GET_SPECMEALDETAIL_BY_SPECMEALID = "select  [SpecPlanDetailID], [ProductID], [DishID], [IsStatus], DayNum, [SpecPlanID] from SpecMealDetail WHERE SpecPlanID = ?";

    public static final String REMOVE_SPECMEAL = "delete from SpecMealDetail where SpecPlanDetailID = ?";

    public static final String INSERT_SPECMEAL = "INSERT INTO SpecMealDetail([ProductID],[DishID],[DayNum],[SpecPlanID],[IsStatus])\n"
            + "VALUES (?,?,?,?,1)";

    public ArrayList<SpecMealDetailDTO> getAllSpecMealDetail() {

        ArrayList<SpecMealDetailDTO> specMealDetailList = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        SpecMealDAO sm = new SpecMealDAO();

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
                        int planSpecMealID = rs.getInt("SpecPlanDetailID");
                        ProductDTO product = p.getProduct(rs.getInt("ProductID"));
                        DishDTO dish = dh.getDish(rs.getInt("DishID"));
                        int isStatus = rs.getInt("IsStatus");
                        DayDTO day = d.getDay(rs.getInt("DayNum"));
                        SpecMealDTO specMealPlan = sm.getSpecMeal(rs.getInt("SpecPlanID"));

                        SpecMealDetailDTO specMealDetail = new SpecMealDetailDTO(planSpecMealID, day, product, dish, specMealPlan, isStatus);
                        specMealDetailList.add(specMealDetail);
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

        return specMealDetailList;

    }

    public ArrayList<SpecMealDetailDTO> getAllSpecMealDetailBySpecMealID(SpecMealDTO specMealPlan) {

        ArrayList<SpecMealDetailDTO> specMealDetailListBySpecMealID = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        SpecMealDAO sm = new SpecMealDAO();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                String sql = GET_SPECMEALDETAIL_BY_SPECMEALID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, specMealPlan.getSpecPlanID());
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int planSpecMealID = rs.getInt("SpecPlanDetailID");
                        ProductDTO product = p.getProduct(rs.getInt("ProductID"));
                        DishDTO dish = dh.getDish(rs.getInt("DishID"));
                        DayDTO day = d.getDay(rs.getInt("DayNum"));
                        int isStatus = rs.getInt("IsStatus");

                        SpecMealDetailDTO specMealDetail = new SpecMealDetailDTO(planSpecMealID, day, product, dish, specMealPlan, isStatus);
                        specMealDetailListBySpecMealID.add(specMealDetail);
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

        return specMealDetailListBySpecMealID;

    }

//    public SpecMealDetailDTO getSpecMealDetail(SpecMealDTO specMealPlan) {
//        SpecMealDetailDTO specMealDetail = null;
//        ProductDAO p = new ProductDAO();
//        DayDAO d = new DayDAO();
//        DishDAO dh = new DishDAO();
//        SpecMealDAO sm = new SpecMealDAO();
//
//        int result = 0;
//        Connection cn = null;
//        try {
//            cn = DBUtils.makeConnection();
//            if (cn != null) {
//                String sql = GET_SPECMEALDETAIL_BY_SPECMEALID;
//                PreparedStatement pst = cn.prepareStatement(sql);
//                pst.setInt(1, specMealPlan.getSpecPlanID());
//                ResultSet rs = pst.executeQuery();
//                if (rs != null && rs.next()) {
//                    int planSpecMealID = rs.getInt("SpecPlanDetailID");
//                    ProductDTO product = p.getProduct(rs.getInt("ProductID"));
//                    DishDTO dish = dh.getDish(rs.getInt("DishID"));
//                    int isStatus = rs.getInt("IsStatus");
//
//                    specMealDetail = new SpecMealDetailDTO(planSpecMealID, product, dish, specMealPlan, isStatus);
//
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (cn != null) {
//                    cn.close();
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//        return specMealDetail;
//
//    }
    public int removeSpecMealDetail(int SpecPlanDetailID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = REMOVE_SPECMEAL;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, SpecPlanDetailID);
                result = pst.executeUpdate();
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
        return result;
    }

    public int insertSpecMealDetail(int dayID, int productID, int dishID, int specMealPlan) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_SPECMEAL;
                //INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, dayID);
                pst.setInt(2, productID);
                pst.setInt(3, dishID);
                pst.setInt(4, specMealPlan);

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

}
