/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.TypeDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryDTO;
import model.ProductDTO;
import model.TypeDTO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import utils.Utils;

/**
 *
 * @author VQN
 */
@MultipartConfig
public class InsertProductServlet extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
        try (PrintWriter out = response.getWriter()) {
            boolean isMultPart = ServletFileUpload.isMultipartContent(request);
            String fileName = null;
            String multiFileName = "";
            System.out.println(isMultPart);
            if (!isMultPart) {

            } else {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);
                    System.out.println("Item " + items);
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }
                Iterator iter = items.iterator();
                Hashtable params = new Hashtable();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            String itemName = item.getName();
                            fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                            System.out.println("path" + fileName);
                            //-------------------------------------
                            String path = getServletContext().getRealPath("/");
                            int lastIndexOfString = path.lastIndexOf("build");
                            String RealPath = path.substring(0, lastIndexOfString) + "web\\assets\\home\\image\\" + fileName;
                            InputStream input = getServletContext().getResourceAsStream("/");
                            System.out.println(input);
                            //-------------------------------------
                            System.out.println("Rpath" + RealPath);
                            File saveFile = new File(RealPath);
                            item.write(saveFile);
                            multiFileName += "/ProjectJSP/assets/home/image/" + fileName + ",";
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                }//end while
                CategoryDAO c = new CategoryDAO();
                TypeDAO t = new TypeDAO();

                String productName = new String(((String) params.get("insert_productName")).getBytes("iso-8859-1"), "utf-8");
                int categoryID = Integer.parseInt((String) params.get("insert_categoryID"));
                int typeID = Integer.parseInt((String) params.get("insert_typeID"));
                int isVegetarian = Integer.parseInt((String) params.get("insert_isVegetarian"));
                int isVegan = Integer.parseInt((String) params.get("insert_isVegan"));
                int hasSpecialDietaryRequirements = Integer.parseInt((String) params.get("insert_hasSpecialDietaryRequirements"));
                String[] size = Utils.stringToArray((String) params.get("insert_size"));
                int price = Integer.parseInt((String) params.get("insert_price"));
                int stock = Integer.parseInt((String) params.get("insert_stock"));
                int unitSold = Integer.parseInt((String) params.get("insert_unitSold"));
                String describe = new String(((String) params.get("insert_describe")).getBytes("iso-8859-1"), "utf-8");
                int discount = Integer.parseInt((String) params.get("insert_discount"));

//          String[] image = Utils.stringToArray(request.getParameter("insert_image"));
                String[] image = utils.Utils.stringToArray(multiFileName);

                ProductDAO pd = new ProductDAO();
                ProductDTO product = pd.getProduct(productName);
                out.print(product);
                if (product == null) { //email khong trung
                    if (typeID == 2) {
                        isVegetarian = 0;
                        isVegan = 0;
                        hasSpecialDietaryRequirements = 0;
                    }
                    int rs = pd.insertProduct(productName, categoryID, typeID, isVegetarian, isVegan, hasSpecialDietaryRequirements, size, price, stock, unitSold, describe, image, discount);

                    if (rs >= 1) {
                        response.sendRedirect("/ProjectJSP/ManageProductServlet");
                    } else {
                        response.sendRedirect("/ProjectJSP/ManageProductServlet");
                    }
                } else {
                    response.sendRedirect("/ProjectJSP/ManageProductServlet");
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
        CategoryDAO c = new CategoryDAO();
        String btn_insert = request.getParameter("btn_insert");
        if (btn_insert == null) {
            ArrayList<CategoryDTO> categories = c.getAllCategory();
            request.setAttribute("categoryList", categories);
            request.getRequestDispatcher("/jsp/admin/admin_product_insert.jsp").forward(request, response);
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
