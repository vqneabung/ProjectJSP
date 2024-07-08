/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.usermeal;

import dao.SpecMealDAO;
import dao.SpecMealDetailDAO;
import dao.UserMealDAO;
import dao.UserMealDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.SpecMealDTO;
import model.SpecMealDetailDTO;
import model.UserMealDTO;

/**
 *
 * @author VQN
 */
public class AddToUserMeal extends HttpServlet {

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
            int specMealID = Integer.parseInt(request.getParameter("specMealID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int resultFromAddUserMealDetail = 0;
            int totalResultFromAddUserMealDetail = 0;

            UserMealDAO um = new UserMealDAO();
            UserMealDetailDAO umd = new UserMealDetailDAO();

            SpecMealDetailDAO smd = new SpecMealDetailDAO();
            SpecMealDAO sm = new SpecMealDAO();

            SpecMealDTO specMeal = sm.getSpecMeal(specMealID);
            ArrayList<SpecMealDetailDTO> specMealDetailList = smd.getAllSpecMealDetailBySpecMealID(specMeal);

            int resultFromAddUserMeal = um.insertUserMealFromSpecMeal(specMeal, userID);
            int userMealID = um.getNewestUserMealByUserID(userID).getUserMealID();

            System.out.println(userMealID);

            for (SpecMealDetailDTO specMealDetail : specMealDetailList) {
                resultFromAddUserMealDetail = umd.insertUserMealDetailFromSpecMealDetail(specMealDetail, userMealID);
                totalResultFromAddUserMealDetail += resultFromAddUserMealDetail;
            }
            if (totalResultFromAddUserMealDetail >= 1) {
                response.sendRedirect("StartServlet?action=mealUser");
            } else {
                response.sendRedirect("StartServlet?action=mealUser");
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
