/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.login;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDTO;

/**
 *
 * @author VQN
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static String HOME = "jsp/home/home.jsp";
    private static String ADMIN_DASHBOARD = "/ProjectJSP/StaticAdminServlet";
    private static String LOGIN = "jsp/home/login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String url = HOME;
        HttpSession session = request.getSession();
        try {
            String email = request.getParameter("login_email");
            String password = request.getParameter("login_password");
            System.out.println(email + " & " + password);
            UserDAO ud = new UserDAO();
            UserDTO user = ud.getUser(email.trim());
            String userSession = (String) session.getAttribute("User");
            if (user != null && password.equals(user.getPassword()) && user.getStatus() != 0) {
                if (userSession != null) {
                    response.sendRedirect(HOME);
                } else {
                    session.setAttribute("User", user);
                    session.setAttribute("UserRoleID", user.getRoleID());
                    if (user.getRoleID() == 0) {
                        response.sendRedirect(ADMIN_DASHBOARD);
                    } else {
                        response.sendRedirect("MealShopServlet");
                    }
                }
            } else {
                request.setAttribute("msg", "Bạn nhập sai tài khoản hoặc mật khẩu!");
                RequestDispatcher rd = request.getRequestDispatcher(LOGIN);
                rd.forward(request, response);
            }
        } catch (Exception ex) {
            log("LoginServlet error:" + ex.getMessage());
        } finally {
            out.close();
        }
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
