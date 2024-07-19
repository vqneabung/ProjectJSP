/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import model.UserDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class UserDAO {

    public static final String GET_DATA = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate from [dbo].[Users]";

    public static final String GET_DATA_BY_SEARCH = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate from [dbo].[Users] WHERE UserName LIKE ? AND UserFullName LIKE ? AND UserEmail LIKE ? AND UserPhone LIKE ? AND UserRoleID LIKE ? AND UserAddress LIKE ? AND convert(varchar(25), UserDateCreate, 120) LIKE ?";

    public static final String GET_USER_BY_EMAIL = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate from [dbo].[Users] Where UserEmail=? COLLATE Latin1_General_CS_AS";

    public static final String GET_USER_BY_ID = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate from [dbo].[Users] Where UserID=?";

    public static final String REMOVE_USER = "UPDATE Users SET UserStatus = 0 WHERE UserID = ?";

    public static final String INSERT_USER = "INSERT INTO Users (UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate)\n"
            + "VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?,GETDATE())";

    public static final String UPDATE_USER = "UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserRoleID = ?, UserPassword = ?, UserAddress = ?, UserStatus = ?, UserAvatar = ? WHERE UserID = ?";

    public static final String UPDATE_USER_FOR_USER = "UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserPassword = ?, UserAddress = ?, UserAvatar = ? WHERE UserID = ?";

    public static final String UPDATE_USER_PASSWORD = "UPDATE Users SET UserPassword = ? WHERE UserID = ?";

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
                        Date dateCreate = rs.getDate("UserDateCreate");

                        UserDTO user = new UserDTO(userID, userName, fullName, email, phone, password, roleID, address, status, avatar, dateCreate);
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

    public ArrayList<UserDTO> getAllAcountsBySearch(String searchUserName, String searchFullName, String searchEmail, String searchPhone, String searchRoleID, String searchAddress, String searchDateCreate) {
        ArrayList<UserDTO> userList = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query

                String sql = GET_DATA_BY_SEARCH;
                /*
                    public static final String GET_DATA_BY_SEARCH = "Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar from [dbo].[Users] 
                WHERE UserName LIKE ? AND UserFullName LIKE ? AND UserEmail LIKE ? AND UserPhone LIKE ? AND UserRoleID LIKE ? AND UserAddress LIKE ?";
                
                //Select UserID, UserName, UserFullName, UserEmail, UserPhone, UserRoleID, UserPassword, UserAddress, UserStatus, UserAvatar, UserDateCreate from [dbo].[Users] 
                WHERE UserName LIKE ? 
                AND UserFullName LIKE ? 
                AND UserEmail LIKE ? 
                AND UserPhone LIKE ? 
                AND UserRoleID LIKE ? 
                AND UserAddress LIKE ? 
                AND UserDateCreate = ?
                 */
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + searchUserName + "%");
                pst.setString(2, "%" + searchFullName + "%");
                pst.setString(3, "%" + searchEmail + "%");
                pst.setString(4, "%" + searchPhone + "%");
                pst.setString(5, "%" + searchRoleID + "%");
                pst.setString(6, "%" + searchAddress + "%");
                pst.setString(7, "%" + searchDateCreate + "%");
                ResultSet rs = pst.executeQuery();
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
                        Date dateCreate = rs.getDate("UserDateCreate");

                        UserDTO user = new UserDTO(userID, userName, fullName, email, phone, password, roleID, address, status, avatar, dateCreate);
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
                    Date dateCreate = rs.getDate("UserDateCreate");

                    user = new UserDTO(userID, username, fullName, email, phone, password, roleID, address, status, avatar, dateCreate);
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
                    Date dateCreate = rs.getDate("UserDateCreate");

                    user = new UserDTO(userID, username, fullName, email, phone, password, roleID, address, status, avatar, dateCreate);
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
                pst.setString(9, avatar);
                pst.setInt(10, userID);

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

    public int updateUserForUser(String userName, String fullName, String email, String phone, String password, String address, int userID, String avatar) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_USER_FOR_USER;
                //UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserRoleID = ?, UserPassword = ?, UserAddress = ?,  UserStatus = ? WHERE UserID = ?
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                pst.setString(2, fullName);
                pst.setString(3, email);
                pst.setString(4, phone);
                pst.setString(5, password);
                pst.setString(6, address);
                pst.setString(7, avatar);
                pst.setInt(8, userID);

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

    public boolean updateUserPassword(String password, int userID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_USER_PASSWORD;
                //UPDATE Users SET UserName = ?,  UserFullName = ? , UserEmail = ?,  UserPhone = ?, UserRoleID = ?, UserPassword = ?, UserAddress = ?,  UserStatus = ? WHERE UserID = ?
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, password);
                pst.setInt(2, userID);

                rs = pst.executeUpdate();
                return true;
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

        return false;
    }
}
