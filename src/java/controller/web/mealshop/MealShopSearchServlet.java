/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.mealshop;

import com.google.gson.Gson;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProductDTO;
import controller.web.mealshop.Data;

/**
 *
 * @author VQN
 */
public class MealShopSearchServlet extends HttpServlet {

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
            String find = "";
            find = request.getParameter("find");
            if (find == null || find.isEmpty()) {
                find = "";
            }
//            String typeCheck = request.getParameter("typeCheck");
//            String foodCheck = request.getParameter("foodCheck");
//            String ingredientCheck = request.getParameter("ingredientCheck");

            String typeCheck = request.getParameter("typeCheck");
            String peopleCheck = request.getParameter("peopleCheck");
            String[] categoryCheckArr = request.getParameterValues("categoryCheck[]");
            int price1 = Integer.parseInt(request.getParameter("price1"));
            int price2 = Integer.parseInt(request.getParameter("price2"));
            int productLength = Integer.parseInt(request.getParameter("productLength"));

            String veganCheck = "";
            String vegetarianCheck = "";

            if (peopleCheck.contains("1")) {
                veganCheck = "1";
            } else if (peopleCheck.contains("2")) {
                vegetarianCheck = "1";
            }

            ProductDAO pd = new ProductDAO();
            ArrayList<ProductDTO> productList = pd.getProductBySearchMultiData(typeCheck, veganCheck, vegetarianCheck, find, categoryCheckArr, price1, price2, productLength);

            Gson gson = new Gson();
            String jsonProductList = gson.toJson(productList);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(new Data(productList, productList.size())));

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
