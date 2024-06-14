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
import model.ProductDTO;
import model.RecipeDetailDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class RecipeDetailDAO {

    public static final String GET_DATA = "select RecipeDetailID, FoodID, IngredientID, IsStatus from RecipeDetail";

    public static final String GET_RECIPE_BY_FOODID = "select RecipeDetailID, FoodID, IngredientID, IsStatus from RecipeDetail where FoodID = ?";

    public static final String INSERT_RECIPE = "insert into RecipeDetail(FoodID, IngredientID, IsStatus) values (?, ?, 1)";

    public ArrayList<RecipeDetailDTO> getRecipeDetail() {

        ArrayList<RecipeDetailDTO> recipeDetailList = new ArrayList<>();
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
                        int recipeDetailID = rs.getInt("RecipeDetailID");
                        ProductDTO food = p.getProduct(rs.getInt("FoodID"));
                        ProductDTO ingredient = p.getProduct(rs.getInt("IngredientID"));
                        int status = rs.getInt("IsStatus");
                        RecipeDetailDTO recipeDetail = new RecipeDetailDTO(recipeDetailID, food, ingredient, status);
                        recipeDetailList.add(recipeDetail);
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
        System.out.println("recipeDetailList: " + recipeDetailList);
        return recipeDetailList;

    }

    public ArrayList<RecipeDetailDTO> getRecipeDetailByFoodID(int foodID) {

        ArrayList<RecipeDetailDTO> recipeDetailList = new ArrayList<>();
        ProductDAO p = new ProductDAO();
        DayDAO d = new DayDAO();
        DishDAO dh = new DishDAO();
        UserMealDAO um = new UserMealDAO();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query
                String sql = GET_RECIPE_BY_FOODID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, foodID);
                System.out.println("a foodID: " + foodID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int recipeDetailID = rs.getInt("RecipeDetailID");
                        ProductDTO food = p.getProduct(rs.getInt("FoodID"));
                        ProductDTO ingredient = p.getProduct(rs.getInt("IngredientID"));
                        int status = rs.getInt("IsStatus");
                        RecipeDetailDTO recipeDetail = new RecipeDetailDTO(recipeDetailID, food, ingredient, status);
                        recipeDetailList.add(recipeDetail);
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

        return recipeDetailList;

    }

    public int insertRecipeDetail(int foodID, int ingredientID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_RECIPE;
                //INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, foodID);
                pst.setInt(2, ingredientID);

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
