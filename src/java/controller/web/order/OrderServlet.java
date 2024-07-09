/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.order;

import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductDTO;
import model.UserDTO;

/**
 *
 * @author VQN
 */
public class OrderServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("User");
            if (user == null) {
                request.getRequestDispatcher("/StartServlet?action=login").forward(request, response);
            } else {
                int userID = user.getUserID();
                HashMap<ProductDTO, Integer> cart = (HashMap<ProductDTO, Integer>) session.getAttribute("cart");
                OrderDAO d = new OrderDAO();

                int result = d.saveOrder(userID, cart);

                //
                for (Map.Entry<ProductDTO, Integer> eachCart : cart.entrySet()) {
                    int productID = eachCart.getKey().getProductID();
                    int quantity = eachCart.getValue();

                    ProductDAO pd = new ProductDAO();
                    ProductDTO product = pd.getProduct(productID);

                    int newProductStock = product.getProductStock() - quantity;
                    int newProductUnitSold = product.getProductUnitSold() + quantity;

                    int rs = pd.updateProductQuantity(newProductStock, newProductUnitSold, productID);
                    if (rs >= 1) {
                        System.out.println("Da cap nhat san pham");
                        request.setAttribute("msgOrder", "Cảm ơn đã mua hàng");
                    } else {
                        System.out.println("Loi cap nhat");
                    }

                }

                // xoa gio hang
                session.removeAttribute("cart");
                response.sendRedirect("/ProjectJSP/StartServlet?action=cart");

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
