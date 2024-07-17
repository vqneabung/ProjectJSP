/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.recipe;

import dao.ProductDAO;
import dao.RecipeDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductDTO;
import model.RecipeDetailDTO;

/**
 *
 * @author VQN
 */
public class InsertRecipeDetailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            ProductDAO p = new ProductDAO();
            RecipeDetailDAO rd = new RecipeDetailDAO();

            int foodID = Integer.parseInt(request.getParameter("insert_foodID"));
            int ingredientID = Integer.parseInt(request.getParameter("insert_ingredientID"));
            int weight = Integer.parseInt(request.getParameter("insert_weight"));
            System.out.println("aaaaa" + ingredientID);

            System.out.println(ingredientID);

            ProductDTO food = p.getProduct(foodID);
            ArrayList<RecipeDetailDTO> recipeDetailList = rd.getRecipeDetailByFoodID(foodID);
            System.out.println(recipeDetailList);
            ArrayList<ProductDTO> ingredientList = p.getAllProductsByIngredient();

            int rs = rd.insertRecipeDetail(foodID, ingredientID, weight);

            if (rs >= 1) {
                request.setAttribute("ingredientList", ingredientList);
                request.setAttribute("food", food);
                request.setAttribute("recipeDetailList", recipeDetailList);
                response.sendRedirect("/ProjectJSP/InsertRecipeDetailServlet?foodID=" + String.valueOf(foodID) + "&msg=insertSuccessfully");

            } else {
                response.sendRedirect("/ProjectJSP/InsertRecipeDetailServlet?foodID=" + String.valueOf(foodID) + "&msg=insertFailed");
            }

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
        String btn_insert = request.getParameter("btn_insert");
        ProductDAO p = new ProductDAO();
        RecipeDetailDAO rd = new RecipeDetailDAO();
        if (btn_insert == null) {

            ProductDTO food = p.getProduct(Integer.parseInt(request.getParameter("foodID")));
            ArrayList<RecipeDetailDTO> recipeDetailList = rd.getRecipeDetailByFoodID(Integer.parseInt(request.getParameter("foodID")));
            System.out.println(recipeDetailList);
            ArrayList<ProductDTO> ingredientList = p.getAllProductsByIngredient();

            request.setAttribute("ingredientList", ingredientList);
            request.setAttribute("food", food);
            request.setAttribute("recipeDetailList", recipeDetailList);

            System.out.println("a " + food);
            System.out.println(btn_insert);

            request.getRequestDispatcher("/jsp/admin/admin_recipe_insert.jsp").forward(request, response);

        } else {
            System.out.println(btn_insert);
            btn_insert = null;
            processRequest(request, response);
        }
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
