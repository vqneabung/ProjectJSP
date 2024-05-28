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
public class UpdateProductServlet extends HttpServlet {

    public static final String UPDATE_PRODUCT = "jsp/admin/admin_product_update.jsp";
    public static final String MANAGE_PRODUCT = "/ManageProductServlet";

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
            int result = 0;
            ProductDAO pd = new ProductDAO();
            CategoryDAO c = new CategoryDAO();
            TypeDAO t = new TypeDAO();
            int productID = Integer.parseInt(request.getParameter("productID"));
            System.out.println(productID);
            String button = request.getParameter("update_click");
            String url = null;

            if (button == null) {
                url = UPDATE_PRODUCT;
                ProductDTO product = pd.getProduct(productID);
                out.print(product);
                request.setAttribute("productID", product.getProductID());
                request.setAttribute("productName", product.getProductName());
                request.setAttribute("categoryList", c.getAllCategory());
                System.out.print(c.getAllCategory());
//                  request.setAttribute("typeList", product.getType());
                request.setAttribute("isVegetarian", product.getIsVegetarian());
                request.setAttribute("isVegan", product.getIsVegan());
                request.setAttribute("hasSpecialDietaryRequirements", product.getHasSpecialDietaryRequirements());
                request.setAttribute("size", Utils.arrayToString(product.getProductSize()));
                request.setAttribute("price", product.getProductPrice());
                request.setAttribute("stock", product.getProductStock());
                request.setAttribute("unitSold", product.getProductUnitSold());
                request.setAttribute("describe", product.getProductDescribe());
                request.setAttribute("status", product.getIsStatus());
//                  request.setAttribute("image", product.getProductImage());
                request.setAttribute("image", "null");
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                url = MANAGE_PRODUCT;
                String productName = request.getParameter("update_productName");
                int categoryID = Integer.parseInt(request.getParameter("update_categoryID"));
                int typeID = Integer.parseInt(request.getParameter("update_typeID"));
                int isVegetarian = Integer.parseInt(request.getParameter("update_isVegetarian"));
                int isVegan = Integer.parseInt(request.getParameter("update_isVegan"));
                int hasSpecialDietaryRequirements = Integer.parseInt(request.getParameter("update_hasSpecialDietaryRequirements"));
                String[] size = Utils.stringToArray(request.getParameter("update_size"));
                int price = Integer.parseInt(request.getParameter("update_price"));
                int stock = Integer.parseInt(request.getParameter("update_stock"));
                int unitSold = Integer.parseInt(request.getParameter("update_unitSold"));
                String describe = request.getParameter("update_describe");
                int status = Integer.parseInt(request.getParameter("update_status"));
//                    String[] image = Utils.stringToArray(request.getParameter("update_image"));
                String[] image = {"test"};

//                    out.println(productID);
//                    out.println(productName);
//                    out.println(category.getCategoryID());
//                    out.println(type.getTypeID());
//                    out.println(isVegetarian);
//                    out.println(isVegan);
//                    out.println(hasSpecialDietaryRequirements);
//                    out.println(size.toString());
//                    out.println(price);
//                    out.println(stock);
//                    out.println(unitSold);
//                    out.println(describe);
//                    out.println(status);
//                    out.println(image);
                result = pd.updateProduct(productName, categoryID, typeID, isVegetarian, isVegan, hasSpecialDietaryRequirements, size, price, stock, unitSold, describe, status, image, productID);
                if (result > 0) {
                    request.setAttribute("update_status", "Update successfully!");
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    out.print("<h1>Something wrong</h1>");
                }
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
