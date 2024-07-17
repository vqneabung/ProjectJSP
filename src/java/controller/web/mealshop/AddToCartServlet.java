/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.mealshop;

import com.google.gson.Gson;
import dao.OrderDAO;
import dao.ProductDAO;
import model.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.OrderDTO;

/**
 *
 * @author VQN
 */
public class AddToCartServlet extends HttpServlet {

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
            String productID = request.getParameter("productID");
            ProductDAO p = new ProductDAO();
            ProductDTO productName = p.getProduct(Integer.parseInt(productID));

            //lay cart trong session
            HttpSession session = request.getSession();
            HashMap<ProductDTO, Integer> cart = (HashMap<ProductDTO, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
                cart.put(productName, 1);
            } else {
                ProductDTO findProduct = null;
                for (ProductDTO tmp : cart.keySet()) {
                    if (tmp.getProductID() == Integer.parseInt(productID.trim())) {
                        findProduct = tmp;
                        break;
                    }
                }
                if (findProduct == null) {
                    cart.put(productName, 1);
                } else {
                    int quantity = cart.get(findProduct);
                    quantity++;
                    cart.put(findProduct, quantity);
                }
            }
            session.setAttribute("cart", cart);
            String btn_cart = request.getParameter("btn_cart");
            if (btn_cart == null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                int cartCount = cart.size();
                Gson gson = new Gson();
                String cartJSon = gson.toJson(cartCount);
                response.getWriter().write(cartJSon);
            } else {
                request.getRequestDispatcher("/ProjectJSP/StartServlet?action=mealUser").forward(request, response);
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
