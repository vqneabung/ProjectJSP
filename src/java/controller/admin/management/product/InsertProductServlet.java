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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryDTO;
import model.ProductDTO;
import model.TypeDTO;
import utils.Utils;

/**
 *
 * @author VQN
 */
public class InsertProductServlet extends HttpServlet {

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

            CategoryDAO c = new CategoryDAO();
            TypeDAO t = new TypeDAO();

            /* TODO output your page here. You may use following sample code. */
            String productName = request.getParameter("insert_productName");
            CategoryDTO category = c.getCategory(Integer.parseInt(request.getParameter("insert_categoryID")));
            TypeDTO type = t.getType(Integer.parseInt(request.getParameter("insert_typeID")));
            int isVegetarian = Integer.parseInt(request.getParameter("insert_isVegetarian"));
            int isVegan = Integer.parseInt(request.getParameter("insert_isVegan"));
            int hasSpecialDietaryRequirements = Integer.parseInt(request.getParameter("insert_hasSpecialDietaryRequirements"));
            String[] size = Utils.stringToArray(request.getParameter("insert_size"));
            int price = Integer.parseInt(request.getParameter("insert_price"));
            int stock = Integer.parseInt(request.getParameter("insert_stock"));
            int unitSold = Integer.parseInt(request.getParameter("insert_unitSold"));
            String describe = request.getParameter("insert_describe");
//          String[] image = Utils.stringToArray(request.getParameter("insert_image"));
            String[] image = {"test"};

            out.println("<h1>" + productName);
            out.println("<h1>" + category.getCategoryID());
            out.println("<h1>" + type.getTypeID());
            out.println("<h1>" + isVegetarian);
            out.println("<h1>" + isVegan);
            out.println("<h1>" + hasSpecialDietaryRequirements);
            out.println("<h1>" + size.toString());
            out.println("<h1>" + price);
            out.println("<h1>" + stock);
            out.println("<h1>" + unitSold);
            out.println("<h1>" + describe);
            out.println("<h1>" + image.toString());
            ProductDAO pd = new ProductDAO();
            ProductDTO product = pd.getProduct(productName);
            out.print(product);
            if (product == null) { //email khong trung
                int rs = pd.insertProduct(productName, category.getCategoryID(), type.getTypeID(), isVegetarian, isVegan, hasSpecialDietaryRequirements, size, price, stock, unitSold, describe, image);

                if (rs >= 1) {
                    out.print("<p>Da insert thanh cong </p>");
                    out.print("<p><a href='jsp/admin/admin_home.jsp'>back</a></p>");
                } else {
                    out.print("<p>something wrong</p>");
                    out.print("<p><a href='jsp/admin/admin_home.jsp'>back</a></p>");
                }
            } else {
                out.print("Khong thanh cong");
                out.print("<a href='jsp/admin/admin_home.jsp'>back</a>");
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
        CategoryDAO c = new CategoryDAO();
        String btn_insert = request.getParameter("btn_insert");
        if (btn_insert == null) {
            ArrayList<CategoryDTO> categories = c.getAllCategory();
            request.setAttribute("categoryList", categories);
            request.getRequestDispatcher("/jsp/admin/admin_product_insert.jsp").forward(request, response);
        } else {
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
