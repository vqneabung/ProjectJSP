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
import model.SpecMealDTO;
import model.UserDTO;
import model.UserMealDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserMealDAO {

    public static final String GET_DATA = "select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal";

    public static final String GET_DATA_BY_USERID = "select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ?";

    public static final String GET_DATA_BY_ID = "select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal Where UserPlanID = ? ";

    public static final String GET_DATA_BY_NAME = "select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal Where UserPlanName LIKE ? AND UserID = ? ";

    public static final String REMOVE_USERMEAL = "UPDATE [dbo].[UserMeal]\n"
            + "   SET [IsStatus] = 0\n"
            + " WHERE UserPlanID = ?";

    public static final String INSERT_USERMEAL = "INSERT INTO UserMeal ([UserPlanName],[UserID], [IsStatus])\n"
            + "VALUES (?, ? ,1)";

    public static final String UPDATE_USERMEAL = "select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal Where UserPlanID = ? ";

    public static final String GET_NEWEST_DATA = "select TOP 1 [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ? ORDER BY UserPlanID DESC";

    public ArrayList<UserMealDTO> getAllUserMeal() {
        ArrayList<UserMealDTO> userMealList = new ArrayList<>();
        UserDAO u = new UserDAO();
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
                        UserDTO user = u.getUser(rs.getInt("UserID"));
                        int IsStatus = rs.getInt("IsStatus");

                        UserMealDTO userMeal = new UserMealDTO(userMealID, userMealName, user, IsStatus);
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

    public ArrayList<UserMealDTO> getAllUserMealByUserID(int userID) {
        ArrayList<UserMealDTO> userMealList = new ArrayList<>();
        UserDAO u = new UserDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                //select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ?
                String sql = GET_DATA_BY_USERID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int userMealID = rs.getInt("UserPlanID");
                        String userMealName = rs.getString("UserPlanName");
                        UserDTO user = u.getUser(userID);
                        int isStatus = rs.getInt("IsStatus");

                        UserMealDTO userMeal = new UserMealDTO(userMealID, userMealName, user, isStatus);
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

    public ArrayList<UserMealDTO> getAllUserMealByName(String userMealNameSearch, int userID) {
        ArrayList<UserMealDTO> userMealList = new ArrayList<>();
        UserDAO u = new UserDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                //select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ?
                String sql = GET_DATA_BY_NAME;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, '%' + userMealNameSearch + '%');
                pst.setInt(2, userID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int userMealID = rs.getInt("UserPlanID");
                        String userMealName = rs.getString("UserPlanName");
                        UserDTO user = u.getUser(userID);
                        int isStatus = rs.getInt("IsStatus");

                        UserMealDTO userMeal = new UserMealDTO(userMealID, userMealName, user, isStatus);
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

    public UserMealDTO getUserMealByUserID(int userMealID) {
        UserMealDTO userMeal = null;
        UserDAO u = new UserDAO();
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DATA_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userMealName = rs.getString("UserPlanName");
                    UserDTO user = u.getUser(rs.getInt("UserID"));
                    int isStatus = rs.getInt("IsStatus");

                    userMeal = new UserMealDTO(userMealID, userMealName, user, isStatus);

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

    public UserMealDTO getUserMealByUserMealID(int userMealID) {
        UserMealDTO userMeal = null;
        UserDAO u = new UserDAO();
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DATA_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String userMealName = rs.getString("UserPlanName");
                    UserDTO user = u.getUser(rs.getInt("UserID"));
                    int isStatus = rs.getInt("IsStatus");

                    userMeal = new UserMealDTO(userMealID, userMealName, user, isStatus);

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

    public int removeUserMeal(int userMealID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = REMOVE_USERMEAL;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID);
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

    public int insertUserMeal(String userMealName, int userID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_USERMEAL;
                //INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userMealName);
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

    public int updateUserMeal(int userMealID, String userMealName, int userID, int isStatus) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_USERMEAL;
                /*
                Update SpecMealDetail\n"
            + "set ProductID = ?, DishID = ?, DayNum = ?, IsStatus = ?\n"
            + "Where SpecPlanDetailID = ?
                 */
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userMealID);
                pst.setString(2, userMealName);
                pst.setInt(3, userID);
                pst.setInt(4, isStatus);

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

    public int insertUserMealFromSpecMeal(SpecMealDTO specMeal, int userID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_USERMEAL;
                //INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, specMeal.getSpecMealName());
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

    public UserMealDTO getNewestUserMealByUserID(int userID) {
        UserMealDTO userMeal = null;
        UserDAO u = new UserDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                //select [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ?
                String sql = GET_NEWEST_DATA;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //select TOP 1 [UserPlanID],[UserPlanName],[UserID],[IsStatus] from UserMeal where UserID = ? ORDER BY UserPlanID DESC
                    while (rs.next()) {
                        int userMealID = rs.getInt("UserPlanID");
                        String userMealName = rs.getString("UserPlanName");
                        UserDTO user = u.getUser("UserID");
                        int isStatus = rs.getInt("IsStatus");

                        userMeal = new UserMealDTO(userMealID, userMealName, user, isStatus);
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
        return userMeal;
    }
}
