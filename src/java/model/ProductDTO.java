/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class ProductDTO {

    private int productID;
    private String productName;
    private CategoryDTO category;
    private TypeDTO type;
    private int isVegetarian;
    private int isVegan;
    private int hasSpecialDietaryRequirements;
    private String[] productSize;
    private int productPrice;
    private int productStock;
    private int productUnitSold;
    private String productDescribe;
    private int isStatus;
    private String[] productImage;

    public ProductDTO(int productID, String productName, CategoryDTO category, TypeDTO type, int isVegetarian, int isVegan, int hasSpecialDietaryRequirements, String[] size, int productPrice, int productStock, int productUnitSold, String productDescribe, int isStatus, String[] productImage) {
        this.productID = productID;
        this.productName = productName;
        this.category = category;
        this.type = type;
        this.isVegetarian = isVegetarian;
        this.isVegan = isVegan;
        this.hasSpecialDietaryRequirements = hasSpecialDietaryRequirements;
        this.productSize = size;
        this.productPrice = productPrice;
        this.productStock = productStock;
        this.productUnitSold = productUnitSold;
        this.productDescribe = productDescribe;
        this.isStatus = isStatus;
        this.productImage = productImage;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    public TypeDTO getType() {
        return type;
    }

    public void setType(TypeDTO type) {
        this.type = type;
    }

    public int getIsVegetarian() {
        return isVegetarian;
    }

    public void setIsVegetarian(int isVegetarian) {
        this.isVegetarian = isVegetarian;
    }

    public int getIsVegan() {
        return isVegan;
    }

    public void setIsVegan(int isVegan) {
        this.isVegan = isVegan;
    }

    public int getHasSpecialDietaryRequirements() {
        return hasSpecialDietaryRequirements;
    }

    public void setHasSpecialDietaryRequirements(int hasSpecialDietaryRequirements) {
        this.hasSpecialDietaryRequirements = hasSpecialDietaryRequirements;
    }

    public String[] getProductSize() {
        return productSize;
    }

    public void setProductSize(String[] productSize) {
        this.productSize = productSize;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public int getProductStock() {
        return productStock;
    }

    public void setProductStock(int productStock) {
        this.productStock = productStock;
    }

    public int getProductUnitSold() {
        return productUnitSold;
    }

    public void setProductUnitSold(int productUnitSold) {
        this.productUnitSold = productUnitSold;
    }

    public String getProductDescribe() {
        return productDescribe;
    }

    public void setProductDescribe(String productDescribe) {
        this.productDescribe = productDescribe;
    }

    public int getIsStatus() {
        return isStatus;
    }

    public void setIsStatus(int isStatus) {
        this.isStatus = isStatus;
    }

    public String[] getProductImage() {
        return productImage;
    }

    public void setProductImage(String[] productImage) {
        this.productImage = productImage;
    }

}
