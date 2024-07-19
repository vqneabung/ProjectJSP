/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.usermeal;

import dao.UserMealDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserMealDTO;

/**
 *
 * @author VQN
 */
@WebServlet(name = "UpdateUserMealServlet", urlPatterns = {"/UpdateUserMealServlet"})
public class UpdateUserMealServlet extends HttpServlet {

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
            String userMealID = request.getParameter("userMealID");
            String userMealName = request.getParameter("userMealName");

            UserMealDAO um = new UserMealDAO();
            int rs = um.updateUserMeal(userMealName, Integer.parseInt(userMealID));

            ArrayList<UserMealDTO> userMealList = (ArrayList<UserMealDTO>) request.getSession().getAttribute("userMealList");

            response.setContentType("application/json");
            if (rs >= 1) {
                for (UserMealDTO userMeal : userMealList) {
                    if (userMeal.getUserMealID() == Integer.parseInt(userMealID)) {
                        userMeal.setUserMealName(userMealName);
                        break;
                    }
                }
                request.getSession().setAttribute("userMealList", userMealList);
                
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"error\"}");
            }
            out.flush();
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
