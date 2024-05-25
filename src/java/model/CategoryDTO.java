/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VQN
 */
public class CategoryDTO {
    
    private int categoryID;
    private String categoryName;
    private TypeDTO type;

    public CategoryDTO(int categoryID, String categoryName, TypeDTO type) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.type = type;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public TypeDTO getType() {
        return type;
    }

    public void setType(TypeDTO type) {
        this.type = type;
    }
    
    
    
}
