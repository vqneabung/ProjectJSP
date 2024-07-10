/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CategoryDTO;
import model.ProductDTO;
import model.TypeDTO;
import utils.SavePath;

/**
 *
 * @author VQN
 */
public class StartServlet extends HttpServlet {

    private final String HOME = "home";
    private final String LOGIN = "login";
    private final String SEARCH = "Search";
    private final String LOGOUT = "logout";
    private final String CART = "cart";
    private final String SHOP = "shopList";
    private final String MEALUSER = "mealUser";
    private final String MEALUSER_SERVLET = "/ManageUserMealServlet";
    private final String WELCOME = "/jsp/home/home.jsp";
    private final String LOGIN_SERVLET = "/jsp/home/login.jsp";
    private final String SEARCH_SERVLET = "SearchServlet";
    private final String CART_SERVLET = "jsp/home/cart.jsp";
    private final String SHOP_SERVLET = "/MealShopServlet";
    private final String ABOUT = "about";
    private final String ABOUT_PAGE = "/jsp/home/about.jsp";
    private final String SPECMEAL = "specmeal";
    private final String SPECMEAL_PAGE = "/SpecMealForUserServlet";
    private final String FORGOTPASSWORD = "forgotPassword";
    private final String FORGOTPASSWORD_PAGE = "/ForgorPasswordServlet";

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
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String url = WELCOME;
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            if (action == null || action.equals(HOME)) {
                getDataForHome(request, response);
            } else if (action.equals(LOGOUT)) {
                url = WELCOME;
                getDataForHome(request, response);
                if (session.getAttribute("User") != null) {
                    session.removeAttribute("User");
                }
            } else if (action.equals(LOGIN)) {
                url = LOGIN_SERVLET;
            } else if (action.equals(SEARCH)) {
                url = SEARCH_SERVLET;
            } else if (action.equals(CART)) {
                url = CART_SERVLET;
            } else if (action.equals(SHOP)) {
                url = SHOP_SERVLET;
            } else if (action.equals(MEALUSER)) {
                url = MEALUSER_SERVLET;
            } else if (action.equals(ABOUT)) {
                url = ABOUT_PAGE;
            } else if (action.equals(SPECMEAL)) {
                url = SPECMEAL_PAGE;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (!url.equals("/jsp/home/login.jsp")) {
                utils.SavePath.SavePath(response, request.getRequestURI(), request.getQueryString());
            }
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    protected void getDataForHome(HttpServletRequest request, HttpServletResponse response) {
        try {
            ProductDAO pd = new ProductDAO();
            CategoryDAO c = new CategoryDAO();
            TypeDAO t = new TypeDAO();

            List<ProductDTO> bestSellerProductList = pd.getAllProducts();

            Collections.sort(bestSellerProductList, new Comparator<ProductDTO>() {
                @Override
                public int compare(ProductDTO t, ProductDTO t1) {
                    return t1.getProductUnitSold() - t.getProductUnitSold();
                }
            }
            );

            request.setAttribute("bestSellerProductList", bestSellerProductList);
        } catch (Exception ex) {
            log("DispatchServlet error:" + ex.getMessage());
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
