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
import model.CategoryDTO;
import model.TypeDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class CategoryDAO {

    public static final String GET_CATEGORY_BY_ID = "Select CategoryID, CategoryName, TypeID from Categories where CategoryID = ?";

    public static final String GET_CATEGORY_LIST = "Select CategoryID, CategoryName, TypeID from Categories";

    public static final String REMOVE_CATEGORY = "DELETE FROM [dbo].[Categories] WHERE CategoryID = ?";

    public static final String INSERT_CATEGORY = "INSERT INTO [dbo].[Categories] ([CategoryName] ,[TypeID]) VALUES (?, ?)";

    public ArrayList<CategoryDTO> getAllCategory() {
        ArrayList<CategoryDTO> categoryList = new ArrayList<>();
        TypeDAO t = new TypeDAO();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query

                String sql = GET_CATEGORY_LIST;
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int categoryID = rs.getInt("CategoryID");
                        String categoryName = rs.getString("CategoryName");
                        TypeDTO type = t.getType(rs.getInt("TypeID"));

                        CategoryDTO category = new CategoryDTO(categoryID, categoryName, type);
                        categoryList.add(category);
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

        return categoryList;
    }

    //Get user by id
    public CategoryDTO getCategory(int categoryID) {
        CategoryDTO category = null;
        TypeDAO t = new TypeDAO();
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_CATEGORY_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, categoryID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {

                    String categoryName = rs.getString("CategoryName");
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    category = new CategoryDTO(categoryID, categoryName, type);

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
        return category;

    }

    public int removeCategory(int categoryID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = REMOVE_CATEGORY;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, categoryID);
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

    public int insertCategory(String categoryName, int typeID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_CATEGORY;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, categoryName);
                pst.setInt(2, typeID);
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

}
