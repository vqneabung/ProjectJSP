/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin.management.specmeal;

import dao.CategoryDAO;
import dao.DayDAO;
import dao.DishDAO;
import dao.ProductDAO;
import dao.SpecMealDAO;
import dao.SpecMealDetailDAO;
import dao.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DayDTO;
import model.DishDTO;
import model.ProductDTO;
import model.SpecMealDTO;
import model.SpecMealDetailDTO;
import utils.Utils;

/**
 *
 * @author VQN
 */
public class UpdateSpecMealServlet extends HttpServlet {

    public static final String UPDATE_SPECMEAL = "jsp/admin/admin_specmeal_update.jsp";
    public static final String MANAGE_SPECMEAL = "/ManageSpecMealServlet";

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
            ProductDAO p = new ProductDAO();
            DishDAO dh = new DishDAO();
            SpecMealDetailDAO smd = new SpecMealDetailDAO();
            DayDAO d = new DayDAO();
            SpecMealDAO sm = new SpecMealDAO();
            String button = request.getParameter("btn_update");
            String url = null;

            if (button == null) {
                url = UPDATE_SPECMEAL;
                int specMealDetailID = Integer.parseInt(request.getParameter("specMealDetailID"));
                SpecMealDetailDTO specMealDetail = smd.getSpecMealDetail(specMealDetailID);

                ArrayList<ProductDTO> product = p.getAllProducts();
                ArrayList<DishDTO> dish = dh.getAllDish();
                ArrayList<DayDTO> day = d.getAllDay();
                request.setAttribute("productList", product);
                request.setAttribute("dishList", dish);
                request.setAttribute("dayList", day);

                request.setAttribute("productID", specMealDetail.getProduct().getProductID());
                request.setAttribute("dishID", specMealDetail.getDish().getDishID());
                request.setAttribute("dayNum", specMealDetail.getDay().getDayNum());
                request.setAttribute("specMealDetailID", specMealDetailID);

                request.getRequestDispatcher(url).forward(request, response);
            } else {
                url = MANAGE_SPECMEAL;
                int productID = Integer.parseInt(request.getParameter("update_productID"));
                int dishID = Integer.parseInt(request.getParameter("update_dishID").trim());
                int dayNum = Integer.parseInt(request.getParameter("update_dayNum"));
                int specMealDetailID = Integer.parseInt(request.getParameter("update_specMealDetailID"));

                result = smd.updateSpecMealDetail(dayNum, productID, dishID, specMealDetailID);
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
