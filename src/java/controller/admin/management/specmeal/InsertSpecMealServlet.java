/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.specmeal;

import dao.DayDAO;
import dao.DishDAO;
import dao.ProductDAO;
import dao.SpecMealDAO;
import dao.SpecMealDetailDAO;
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

/**
 *
 * @author VQN
 */
public class InsertSpecMealServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ProductDAO p = new ProductDAO();
            DishDAO dh = new DishDAO();
            SpecMealDetailDAO smd = new SpecMealDetailDAO();
            DayDAO d = new DayDAO();
            SpecMealDAO sm = new SpecMealDAO();

            int dayNum = Integer.parseInt(request.getParameter("insert_dayNum"));
            int productID = Integer.parseInt(request.getParameter("insert_productID"));
            int dishID = Integer.parseInt(request.getParameter("insert_dishID").trim());
            int specMealID = Integer.parseInt(request.getParameter("insert_specMealID").trim());

            //email khong trung
            int rs = smd.insertSpecMealDetail(dayNum, productID, dishID, specMealID);

            if (rs >= 1) {
                response.sendRedirect("ManageSpecMealServlet");
            } else {
                response.sendRedirect("ManageSpecMealServlet");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        ProductDAO p = new ProductDAO();
        DishDAO dh = new DishDAO();
        SpecMealDetailDAO smd = new SpecMealDetailDAO();
        SpecMealDAO sm = new SpecMealDAO();
        DayDAO d = new DayDAO();
        PrintWriter out = response.getWriter();

        String btn_insert = request.getParameter("btn_insert");
        if (btn_insert == null) {

            ArrayList<ProductDTO> product = p.getAllProducts();
            ArrayList<DishDTO> dish = dh.getAllDish();
            ArrayList<DayDTO> day = d.getAllDay();
            SpecMealDTO specMeal = sm.getSpecMeal(Integer.parseInt(request.getParameter("specMealID").trim()));
            request.setAttribute("productList", product);
            request.setAttribute("dishList", dish);
            request.setAttribute("dayList", day);
            request.setAttribute("specMeal", specMeal);

//            out.print("<h1>" + product.get(0).getProductName());
//            out.print("<h1>" + dish.get(0).getDishName());
//            out.print("<h1>" + day.get(0).getDayText());
//            out.print("<h1>" + specMeal.toString());
            request.getRequestDispatcher("/jsp/admin/admin_specmeal_insert.jsp").forward(request, response);
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
