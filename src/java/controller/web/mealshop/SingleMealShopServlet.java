/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.mealshop;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.RecipeDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryDTO;
import model.ProductDTO;
import model.RecipeDetailDTO;

/**
 *
 * @author VQN
 */
public class SingleMealShopServlet extends HttpServlet {

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
            int productID = Integer.parseInt(request.getParameter("productID"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            ProductDAO pd = new ProductDAO();
            ProductDTO product = pd.getProduct(productID);
            CategoryDAO c = new CategoryDAO();
            ArrayList<ProductDTO> productRamdom = pd.getAllProductsRamdom();
            ArrayList<ProductDTO> productByCategoryID = pd.getProductByCategoryID(categoryID);

            RecipeDetailDAO rd = new RecipeDetailDAO();
            ArrayList<RecipeDetailDTO> recipeDetailListByFoodID = rd.getRecipeDetailByFoodID(productID);

            request.setAttribute("productRamdom", productRamdom);
            request.setAttribute("recipeDetailListByFoodID", recipeDetailListByFoodID);
            request.setAttribute("productByCategoryID", productByCategoryID);
            request.setAttribute("product", product);
            utils.SavePath.SavePath(response, request.getRequestURI(), request.getQueryString());
            request.getRequestDispatcher("jsp/home/single-mealshop.jsp").forward(request, response);
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
