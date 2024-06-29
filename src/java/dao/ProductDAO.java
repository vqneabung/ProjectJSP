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
import model.ProductDTO;
import model.TypeDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class ProductDAO {

    public static final String GET_DATA = "select ProductID, ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage from Product";

    public static final String GET_DATA_BY_FOOD = "select ProductID, ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage from Product where TypeID = 1";

    public static final String GET_DATA_BY_INGREDIENT = "select ProductID, ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage from Product where TypeID = 2";

    public static final String GET_PRODUCT_BY_NAME = "SELECT * FROM Product WHERE ProductName = ?";

    public static final String GET_PRODUCT_BY_SEARCH = "SELECT * FROM Product WHERE ProductName LIKE ?";

    public static final String GET_PRODUCT_BY_SEARCH_MULTIDATA = "SELECT  * FROM [WEEKLYMEAL].[dbo].[Product] Where TypeID Like ? AND IsVegan Like ? AND IsVegetarian like ? AND ProductName Like ?";

    public static final String GET_PRODUCT_BY_SEARCH_ALLDATA = "SELECT [ProductID],[ProductName],[CategoryID],[TypeID],[IsVegetarian],[IsVegan],[HasSpecialDietaryRequirements],[ProductSize],[ProductPrice],[ProductStock],[ProductUnitSold],[ProductDescribe],[ProductImage],[IsStatus] FROM [dbo].[Product] WHERE [ProductName] LIKE ? AND [CategoryID] LIKE ? AND [TypeID] LIKE ? AND [IsVegetarian] LIKE ? AND [IsVegan] LIKE ? AND [ProductSize] LIKE ? AND [ProductPrice] LIKE ? AND [ProductStock] LIKE ? AND [ProductUnitSold] LIKE ?";

    public static final String GET_PRODUCT_BY_ID = "SELECT * FROM Product WHERE ProductID = ?";

    public static final String INSERT_PRODUCT = "INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage)\n"
            + "VALUES (?,  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, ?)";

    public static final String REMOVE_PRODUCT = "UPDATE Product SET IsStatus = 0 WHERE ProductID = ?";

    public static final String UPDATE_PRODUCT = "UPDATE Product SET ProductName = ?, CategoryID = ?, TypeID = ?, IsVegetarian = ?, IsVegan = ?, HasSpecialDietaryRequirements = ?, ProductSize = ?, ProductPrice = ?, ProductStock = ?, ProductUnitSold = ?, ProductDescribe = ?, ProductImage = ?, IsStatus = ? WHERE ProductID = ?";

    public static final String UPDATE_PRODUCT_QUANTITY = "UPDATE Product SET ProductStock = ?, ProductUnitSold = ? WHERE ProductID = ?";

    public ArrayList<ProductDTO> getAllProducts() {
        ArrayList<ProductDTO> productList = new ArrayList<>();

        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();
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
                        int productID = rs.getInt("ProductID");
                        String productName = rs.getString("ProductName");
                        CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                        TypeDTO type = t.getType(rs.getInt("TypeID"));
                        int isVegetarian = rs.getInt("IsVegetarian");
                        int isVegan = rs.getInt("IsVegan");
                        int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                        String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                        int productPrice = rs.getInt("ProductPrice");
                        int productStock = rs.getInt("ProductStock");
                        int productUnitSold = rs.getInt("ProductUnitSold");
                        String productDescribe = rs.getString("ProductDescribe");
                        int isStatus = rs.getInt("IsStatus");
                        String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                        ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                        productList.add(product);
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

        return productList;

    }

    public ArrayList<ProductDTO> getAllProductsByFood() {
        ArrayList<ProductDTO> productList = new ArrayList<>();

        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query

                String sql = GET_DATA_BY_FOOD;
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int productID = rs.getInt("ProductID");
                        String productName = rs.getString("ProductName");
                        CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                        TypeDTO type = t.getType(rs.getInt("TypeID"));
                        int isVegetarian = rs.getInt("IsVegetarian");
                        int isVegan = rs.getInt("IsVegan");
                        int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                        String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                        int productPrice = rs.getInt("ProductPrice");
                        int productStock = rs.getInt("ProductStock");
                        int productUnitSold = rs.getInt("ProductUnitSold");
                        String productDescribe = rs.getString("ProductDescribe");
                        int isStatus = rs.getInt("IsStatus");
                        String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                        ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                        productList.add(product);
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

        return productList;

    }

    public ArrayList<ProductDTO> getAllProductsByIngredient() {
        ArrayList<ProductDTO> productList = new ArrayList<>();

        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //B2: Viet query va exec query

                String sql = GET_DATA_BY_INGREDIENT;
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    //b3: Doc cac dong trong rs va cat vao ArrayList
                    while (rs.next()) {
                        int productID = rs.getInt("ProductID");
                        String productName = rs.getString("ProductName");
                        CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                        TypeDTO type = t.getType(rs.getInt("TypeID"));
                        int isVegetarian = rs.getInt("IsVegetarian");
                        int isVegan = rs.getInt("IsVegan");
                        int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                        String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                        int productPrice = rs.getInt("ProductPrice");
                        int productStock = rs.getInt("ProductStock");
                        int productUnitSold = rs.getInt("ProductUnitSold");
                        String productDescribe = rs.getString("ProductDescribe");
                        int isStatus = rs.getInt("IsStatus");
                        String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                        ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                        productList.add(product);
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

        return productList;

    }

    //Get product by name
    public ArrayList<ProductDTO> getProductBySearch(String searchProductName) {
        ArrayList<ProductDTO> productList = new ArrayList<>();
        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_PRODUCT_BY_SEARCH;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + searchProductName + "%");
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    int isVegetarian = rs.getInt("IsVegetarian");
                    int isVegan = rs.getInt("IsVegan");
                    int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                    String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                    int productPrice = rs.getInt("ProductPrice");
                    int productStock = rs.getInt("ProductStock");
                    int productUnitSold = rs.getInt("ProductUnitSold");
                    String productDescribe = rs.getString("ProductDescribe");
                    int isStatus = rs.getInt("IsStatus");
                    String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                    ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                    productList.add(product);
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
        return productList;

    }

    public ArrayList<ProductDTO> getProductBySearchAllData(String searchProductName, String searchCategoryID, String searchTypeID, String searchIsVegetarian, String searchIsVegan, String searchSize, String searchPrice, String searchStock, String searchUnitSold, String order_product, String order_type) {
        ArrayList<ProductDTO> productList = new ArrayList<>();
        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_PRODUCT_BY_SEARCH_ALLDATA;
                if (!order_product.equals("")) {
                    sql += " ORDER BY " + order_product + " " + order_type;
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + searchProductName + "%");
                pst.setString(2, "%" + searchCategoryID + "%");
                pst.setString(3, "%" + searchTypeID + "%");
                pst.setString(4, "%" + searchIsVegetarian + "%");
                pst.setString(5, "%" + searchIsVegan + "%");
                pst.setString(6, "%" + searchSize + "%");
                pst.setString(7, "%" + searchPrice + "%");
                pst.setString(8, "%" + searchStock + "%");
                pst.setString(9, "%" + searchUnitSold + "%");

//    public static final String GET_PRODUCT_BY_SEARCH_ALLDATA = "SELECT [ProductID],[ProductName],[CategoryID],[TypeID],[IsVegetarian],[IsVegan],[ProductSize],[ProductPrice],[ProductStock],[ProductUnitSold],[ProductImage],[IsStatus] FROM [dbo].[Product] WHERE [ProductName] LIKE ? AND [CategoryID] LIKE ? AND [TypeID] LIKE ? AND [IsVegetarian] LIKE ? AND [IsVegan] LIKE ? AND [HasSpecialDietaryRequirements] LIKE ? AND [ProductSize] LIKE ? AND [ProductPrice] LIKE ? AND [ProductStock] LIKE ? AND [ProductUnitSold] LIKE ? AND [ProductImage] LIKE ? AND [IsStatus] LIKE ? ?";
                    ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    int isVegetarian = rs.getInt("IsVegetarian");
                    int isVegan = rs.getInt("IsVegan");
                    int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                    String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                    int productPrice = rs.getInt("ProductPrice");
                    int productStock = rs.getInt("ProductStock");
                    int productUnitSold = rs.getInt("ProductUnitSold");
                    String productDescribe = rs.getString("ProductDescribe");
                    int isStatus = rs.getInt("IsStatus");
                    String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                    ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                    productList.add(product);
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
        return productList;

    }

    public ArrayList<ProductDTO> getProductBySearchMultiData(String searchTypeID, String searchIsVegan, String searchIsVegetarian, String searchProductName) {
        ArrayList<ProductDTO> productList = new ArrayList<>();
        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_PRODUCT_BY_SEARCH_MULTIDATA;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + searchTypeID + "%");
                pst.setString(2, "%" + searchIsVegan + "%");
                pst.setString(3, "%" + searchIsVegetarian + "%");
                pst.setString(4, "%" + searchProductName + "%");
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("ProductID");
                    String productName = rs.getString("ProductName");
                    CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    int isVegetarian = rs.getInt("IsVegetarian");
                    int isVegan = rs.getInt("IsVegan");
                    int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                    String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                    int productPrice = rs.getInt("ProductPrice");
                    int productStock = rs.getInt("ProductStock");
                    int productUnitSold = rs.getInt("ProductUnitSold");
                    String productDescribe = rs.getString("ProductDescribe");
                    int isStatus = rs.getInt("IsStatus");
                    String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                    ProductDTO product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);
                    productList.add(product);
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
        return productList;

    }

    public ProductDTO getProduct(String productName) {
        ProductDTO product = null;
        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_PRODUCT_BY_NAME;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, productName);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int productID = rs.getInt("ProductID");
                    CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    int isVegetarian = rs.getInt("IsVegetarian");
                    int isVegan = rs.getInt("IsVegan");
                    int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                    String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                    int productPrice = rs.getInt("ProductPrice");
                    int productStock = rs.getInt("ProductStock");
                    int productUnitSold = rs.getInt("ProductUnitSold");
                    String productDescribe = rs.getString("ProductDescribe");
                    int isStatus = rs.getInt("IsStatus");
                    String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                    product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);

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
        return product;

    }

    public ProductDTO getProduct(int productID) {
        ProductDTO product = null;
        TypeDAO t = new TypeDAO();
        CategoryDAO c = new CategoryDAO();

        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_PRODUCT_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, productID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String productName = rs.getString("ProductName");
                    CategoryDTO category = c.getCategory(rs.getInt("CategoryID"));
                    TypeDTO type = t.getType(rs.getInt("TypeID"));
                    int isVegetarian = rs.getInt("IsVegetarian");
                    int isVegan = rs.getInt("IsVegan");
                    int hasSpecialDietaryRequirements = rs.getInt("HasSpecialDietaryRequirements");
                    String[] productSize = utils.Utils.stringToArray(rs.getString("ProductSize"));
                    int productPrice = rs.getInt("ProductPrice");
                    int productStock = rs.getInt("ProductStock");
                    int productUnitSold = rs.getInt("ProductUnitSold");
                    String productDescribe = rs.getString("ProductDescribe");
                    int isStatus = rs.getInt("IsStatus");
                    String[] productImage = utils.Utils.stringToArray(rs.getString("ProductImage"));

                    product = new ProductDTO(productID, productName, category, type, isVegetarian, isVegan, hasSpecialDietaryRequirements, productSize, productPrice, productStock, productUnitSold, productDescribe, isStatus, productImage);

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
        return product;

    }

    public int insertProduct(String productName, int categoryID, int typeID, int isVegetarian, int isVegan, int hasSpecialDietaryRequirements, String[] productSize, int productPrice, int productStock, int productUnitSold, String productDescribe, String[] productImage) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = INSERT_PRODUCT;
                //INSERT INTO Product(ProductName, CategoryID, TypeID, IsVegetarian, IsVegan, HasSpecialDietaryRequirements, ProductSize, ProductPrice, ProductStock, ProductUnitSold, ProductDescribe, IsStatus, ProductImage
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, productName);
                pst.setInt(2, categoryID);
                pst.setInt(3, typeID);
                pst.setInt(4, isVegetarian);
                pst.setInt(5, isVegan);
                pst.setInt(6, hasSpecialDietaryRequirements);
                pst.setString(7, utils.Utils.arrayToString(productSize));
                pst.setInt(8, productPrice);
                pst.setInt(9, productStock);
                pst.setInt(10, productUnitSold);
                pst.setString(11, productDescribe);
                pst.setString(12, utils.Utils.arrayToString(productImage));

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

    public int removeProduct(int productID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = REMOVE_PRODUCT;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, productID);
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

    public int updateProduct(String productName, int categoryID, int typeID, int isVegetarian, int isVegan, int hasSpecialDietaryRequirements, String[] productSize, int productPrice, int productStock, int productUnitSold, String productDescribe, int isStatus, String[] productImage, int productID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_PRODUCT;
                //UPDATE Product SET ProductName = ?1, CategoryID = ?2, TypeID = ?3, IsVegetarian = ?4, IsVegan = ?5, HasSpecialDietaryRequirements = ?6, ProductSize = ?7, ProductPrice = ?8, ProductStock = ?9, ProductUnitSold = ?10, ProductDescribe = ?11, ProductImage = ?12, IsStatus = ?13 WHERE ProductID = ?14
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, productName);
                pst.setInt(2, categoryID);
                pst.setInt(3, typeID);
                pst.setInt(4, isVegetarian);
                pst.setInt(5, isVegan);
                pst.setInt(6, hasSpecialDietaryRequirements);
                pst.setString(7, utils.Utils.arrayToString(productSize));
                pst.setInt(8, productPrice);
                pst.setInt(9, productStock);
                pst.setInt(10, productUnitSold);
                pst.setString(11, productDescribe);
                pst.setString(12, utils.Utils.arrayToString(productImage));
                pst.setInt(13, isStatus);
                pst.setInt(14, productID);

                rs = pst.executeUpdate();
                System.out.println(rs);
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

    public int updateProductQuantity(int productStock, int productUnitSold, int productID) {
        int rs = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = UPDATE_PRODUCT_QUANTITY;
                //UPDATE Product SET ProductName = ?1, CategoryID = ?2, TypeID = ?3, IsVegetarian = ?4, IsVegan = ?5, HasSpecialDietaryRequirements = ?6, ProductSize = ?7, ProductPrice = ?8, ProductStock = ?9, ProductUnitSold = ?10, ProductDescribe = ?11, ProductImage = ?12, IsStatus = ?13 WHERE ProductID = ?14
                PreparedStatement pst = cn.prepareStatement(sql);;
                pst.setInt(1, productStock);
                pst.setInt(2, productUnitSold);
                pst.setInt(3, productID);

                rs = pst.executeUpdate();
                System.out.println(rs);
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
