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
import model.UserDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserDAO {

    public static final String GET_DATA = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar from [dbo].[Users]";

    public static final String GET_USER_BY_EMAIL = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar from [dbo].[Users] Where UserEmail=?";

    public static final String GET_USER_BY_ID = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar from [dbo].[Users] Where UserID=?";

    public static final String REMOVE_USER = "UPDATE Users SET UserStatus = 0 WHERE UserID = ?";

    public static final String INSERT_USER = "INSERT INTO Users (UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?)";

    public static final String UPDATE_USER = "UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserRoleID = ?, UserPassword = ?, UserAddress = ?, UserStatus = ?, , UserAvatar = ? WHERE UserID = ?";

    public ArrayList<UserDTO> getAllAcounts() {
        ArrayList<UserDTO> userList = new ArrayList<>();

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
                        int userID = rs.getInt("UserID");
                        String userName = rs.getString("UserName");
                        String fullName = rs.getString("UserFullName");
                        String email = rs.getString("UserEmail");
                        String phone = rs.getString("UserPhone");
                        int roleID = rs.getInt("UserRoleID");
                        String password = rs.getString("UserPassword");
                        String address = rs.getString("UserAddress");
                        int status = rs.getInt("UserStatus");
                        String avatar = rs.getString("UserAvatar");

                        UserDTO user = new UserDTO(userID, userName, fullName, email, phone, password, roleID, address, status, avatar);
                        userList.add(user);
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

        return userList;
    }

    //Get user by email
    public UserDTO getUser(String email) {
        UserDTO user = null;
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_USER_BY_EMAIL;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int userID = rs.getInt("UserID");
                    String username = rs.getString("UserName");
                    String fullName = rs.getString("UserFullName");
                    String phone = rs.getString("UserPhone");
                    int roleID = rs.getInt("UserRoleID");
                    String password = rs.getString("UserPassword");
                    String address = rs.getString("UserAddress");
                    int status = rs.getInt("UserStatus");
                    String avatar = rs.getString("UserAvatar");

                    user = new UserDTO(userID, username, fullName, email, phone, password, roleID, address, status, avatar);
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
        return user;

    }

    //Get user by id
    public UserDTO getUser(int userID) {
        UserDTO user = null;
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_USER_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String username = rs.getString("UserName");
                    String fullName = rs.getString("UserFullName");
                    String email = rs.getString("UserEmail");
                    String phone = rs.getString("UserPhone");
                    int roleID = rs.getInt("UserRoleID");
                    String password = rs.getString("UserPassword");
                    String address = rs.getString("UserAddress");
                    int status = rs.getInt("UserStatus");
                    String avatar = rs.getString("UserAvatar");

                    user = new UserDTO(userID, username, fullName, email, phone, password, roleID, address, status, avatar);
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
        return user;

    }

    public int removeUser(int userID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = REMOVE_USER;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
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

    public int insertUser(String userName, String fullName, String email, String phone, int roleID, String password, String address, String avatar) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_USER;
                //INSERT INTO Users (UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                pst.setString(2, fullName);
                pst.setString(3, email);
                pst.setString(4, phone);
                pst.setInt(5, roleID);
                pst.setString(6, password);
                pst.setString(7, address);
                pst.setString(8, avatar);

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

    public int updateUser(String userName, String fullName, String email, String phone, String password, int roleID, String address, int status, int userID, String avatar) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_USER;
                //UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserRoleID = ?, UserPassword = ?, UserAddress = ?,  UserStatus = ? WHERE UserID = ?
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                pst.setString(2, fullName);
                pst.setString(3, email);
                pst.setString(4, phone);
                pst.setInt(5, roleID);
                pst.setString(6, password);
                pst.setString(7, address);
                pst.setInt(8, status);
                pst.setInt(9, userID);
                pst.setString(10, avatar);


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
