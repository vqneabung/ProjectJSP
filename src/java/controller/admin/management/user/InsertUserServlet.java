/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.user;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDTO;

/**
 *
 * @author VQN
 */
public class InsertUserServlet extends HttpServlet {

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
            String fullName = request.getParameter("insert_fullname");
            String userName = request.getParameter("insert_username");
            String email = request.getParameter("insert_email");
            String phone = request.getParameter("insert_phone");
            String address = request.getParameter("insert_address");
            String password = request.getParameter("insert_password");
            String stringRoleID = request.getParameter("insert_role");
            int roleID = Integer.parseInt(stringRoleID);
            String avatar = request.getParameter("insert_avatar");
            
            UserDAO ud = new UserDAO();
            UserDTO user = ud.getUser(email);
            if (user == null) { //email khong trung
                int rs = ud.insertUser(userName, fullName, email, phone, roleID, password, address, avatar);
                if (rs >= 1) {
                    out.print("<p>Da insert thanh cong </p>");
                    out.print("<p><a href='jsp/admin/admin_home.jsp'>back</a></p>");
                } else {
                    out.print("<p>something wrong</p>");
                    out.print("<p><a href='jsp/admin/admin_home.jsp'>back</a></p>");
                }
            } else {
                out.print("email trung");
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
