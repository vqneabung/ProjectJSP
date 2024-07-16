/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.web.mealshop;

import java.util.ArrayList;
import model.ProductDTO;

/**
 *
 * @author VQN
 */
public class Data {

    ArrayList<ProductDTO> productList;
    int productSize;

    public Data(ArrayList<ProductDTO> productList, int productSize) {
        this.productList = productList;
        this.productSize = productSize;
    }

    public ArrayList<ProductDTO> getProductList() {
        return productList;
    }

    public void setProductList(ArrayList<ProductDTO> productList) {
        this.productList = productList;
    }

    public int getProductSize() {
        return productSize;
    }

    public void setProductSize(int productSize) {
        this.productSize = productSize;
    }

}
