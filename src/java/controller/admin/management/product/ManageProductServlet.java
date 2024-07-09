/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryDTO;
import model.ProductDTO;
import model.TypeDTO;
import model.UserDTO;

/**
 *
 * @author VQN
 */
public class ManageProductServlet extends HttpServlet {

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
            ProductDAO pd = new ProductDAO();
            ArrayList<ProductDTO> products = pd.getAllProducts();
            CategoryDAO c = new CategoryDAO();
            ArrayList<CategoryDTO> categoryList = c.getAllCategory();
            System.out.println(products);
            request.setAttribute("categoryList", categoryList);

            int maxProductPrice = Collections.max(products, new Comparator<ProductDTO>() {
                @Override
                public int compare(ProductDTO t, ProductDTO t1) {
                    return t.getProductPrice() - t1.getProductPrice();
                }
            }).getProductPrice();

            int minProductPrice = Collections.min(products, new Comparator<ProductDTO>() {
                @Override
                public int compare(ProductDTO t, ProductDTO t1) {
                    return t.getProductPrice() - t1.getProductPrice();
                }
            }).getProductPrice();

            request.setAttribute("maxProductPrice", maxProductPrice);
            request.setAttribute("minProductPrice", minProductPrice);
            //--------Tao thanh phan trang--------------------
            request.setAttribute("products", products); 
            //---------------------------------------------------------
            request.getRequestDispatcher("jsp/admin/admin_products.jsp").forward(request, response);
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
