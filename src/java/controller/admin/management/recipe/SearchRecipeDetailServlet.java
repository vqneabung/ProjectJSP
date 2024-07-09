/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.recipe;

import com.google.gson.Gson;
import dao.ProductDAO;
import dao.RecipeDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProductDTO;
import model.RecipeDetailDTO;

/**
 *
 * @author VQN
 */
public class SearchRecipeDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    class Data {

        ArrayList<ProductDTO> foodList;
        ArrayList<RecipeDetailDTO> recipeDetailList;

        public Data(ArrayList<ProductDTO> foodList, ArrayList<RecipeDetailDTO> recipeDetailList) {
            this.foodList = foodList;
            this.recipeDetailList = recipeDetailList;
        }

        public ArrayList<ProductDTO> getFoodList() {
            return foodList;
        }

        public void setFoodList(ArrayList<ProductDTO> foodList) {
            this.foodList = foodList;
        }

        public ArrayList<RecipeDetailDTO> getRecipeDetailList() {
            return recipeDetailList;
        }

        public void setRecipeDetailList(ArrayList<RecipeDetailDTO> recipeDetailList) {
            this.recipeDetailList = recipeDetailList;
        }

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String searchFood = request.getParameter("searchFood");
            ProductDAO p = new ProductDAO();
            RecipeDetailDAO rd = new RecipeDetailDAO();

            ArrayList<ProductDTO> foodList = p.getProductBySearch(searchFood);
            ArrayList<RecipeDetailDTO> recipeDetailList = rd.getRecipeDetail();

            Data data = new Data(foodList, recipeDetailList);

            Gson gson = new Gson();
            String dataJSon = gson.toJson(data);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(dataJSon);

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
