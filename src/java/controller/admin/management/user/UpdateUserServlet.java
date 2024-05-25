/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.user;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDTO;

/**
 *
 * @author VQN
 */
public class UpdateUserServlet extends HttpServlet {

    private static String UPDATE_USER = "jsp/admin/admin_user_update.jsp";
    private static String MANAGE_USER = "ManageUserServlet";

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
        int result = 0;
        UserDAO ud = new UserDAO();
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("update_click");
            int userID = Integer.parseInt(request.getParameter("userID"));
            String url = UPDATE_USER;
            if (action == null) {
                UserDTO user = ud.getUser(userID);

                request.setAttribute("userID", user.getUserID());
                request.setAttribute("userName", user.getUserName());
                request.setAttribute("fullName", user.getFullName());
                request.setAttribute("phone", user.getPhone());
                request.setAttribute("address", user.getAddress());
                request.setAttribute("email", user.getEmail());
                request.setAttribute("password", user.getPassword());
                request.setAttribute("avatar", user.getAvatar());
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                url = MANAGE_USER;
                String username = request.getParameter("update_username");
                String fullName = request.getParameter("update_fullname");
                String password = request.getParameter("update_password");
                String phone = request.getParameter("update_phone");
                String address = request.getParameter("update_address");
                String email = request.getParameter("update_email");
                String roleID = request.getParameter("update_role");
                String status = request.getParameter("update_status");
                String avatar = request.getParameter("update_avatar");

                result = ud.updateUser(username, fullName, email, phone, password, Integer.parseInt(roleID.trim()), address, Integer.parseInt(status), userID, avatar);

                if (result > 0) {
                    request.setAttribute("update_status", "Update successfully!");
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    out.print("<h1>Something wrong</h1>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
