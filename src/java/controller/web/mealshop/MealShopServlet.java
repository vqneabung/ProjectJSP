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
import controller.web.mealshop.Data;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProductDTO;

/**
 *
 * @author VQN
 */
public class MealShopServlet extends HttpServlet {

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
            ArrayList<ProductDTO> productList = p.getNineRowProducts(0);
            ArrayList<ProductDTO> allProductList = p.getAllProducts();

            request.setAttribute("productList", productList);
            request.setAttribute("allProductList", allProductList);
            request.setAttribute("categorySearch", request.getParameter("categoryID"));

            request.setAttribute("priceMin", p.getPriceMaxMin()[0]);
            request.setAttribute("priceMax", p.getPriceMaxMin()[1]);

            request.getRequestDispatcher("jsp/home/mealshop_list.jsp").forward(request, response);
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
        Object btn_loadmore = request.getParameter("btn_loadmore");
        String productLength = "0";

        if (btn_loadmore != null) {
            productLength = request.getParameter("productLength");
        }
        ProductDAO p = new ProductDAO();
        ArrayList<ProductDTO> productList = p.getNineRowProducts(Integer.parseInt(productLength));

        request.setAttribute("productList", productList);
        request.setAttribute("categorySearch", request.getParameter("categoryID"));

        Gson gson = new Gson();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(new Data(productList, productList.size())));

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
