/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.product;

import static controller.admin.management.product.UpdateProductServlet.MANAGE_PRODUCT;
import static controller.admin.management.product.UpdateProductServlet.pd;
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.TypeDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
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
public class UpdateProductServlet extends HttpServlet {

    public static final String UPDATE_PRODUCT = "jsp/admin/admin_product_update.jsp";
    public static final String MANAGE_PRODUCT = "/ManageProductServlet";

    public static ProductDAO pd = new ProductDAO();
    public static CategoryDAO c = new CategoryDAO();
    public static TypeDAO t = new TypeDAO();

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int result = 0;
            String url = UPDATE_PRODUCT;
            int productID = Integer.parseInt(request.getParameter("productID"));
            ProductDTO product = pd.getProduct(productID);
            request.setAttribute("productID", product.getProductID());
            request.setAttribute("productName", product.getProductName());
            request.setAttribute("categoryList", c.getAllCategory());
            System.out.print(c.getAllCategory());
//                  request.setAttribute("typeList", product.getType());
            request.setAttribute("isVegetarian", product.getIsVegetarian());
            request.setAttribute("isVegan", product.getIsVegan());
            request.setAttribute("hasSpecialDietaryRequirements", product.getHasSpecialDietaryRequirements());
            request.setAttribute("size", Utils.arrayToString(product.getProductSize()));
            request.setAttribute("price", product.getProductPrice());
            request.setAttribute("discount", product.getDiscount());
            request.setAttribute("stock", product.getProductStock());
            request.setAttribute("unitSold", product.getProductUnitSold());
            request.setAttribute("describe", product.getProductDescribe());
            request.setAttribute("status", product.getIsStatus());
            request.setAttribute("image", product.getProductImage());

            request.getRequestDispatcher(url).forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        try (PrintWriter out = response.getWriter()) {
            int result = 0;
            String url = MANAGE_PRODUCT;
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

                }
                int productID = Integer.parseInt((String) params.get("productID"));
                ProductDTO product = pd.getProduct(productID);

                String productName = new String(((String) params.get("update_productName")).getBytes("iso-8859-1"), "utf-8");
                int categoryID = Integer.parseInt((String) params.get("update_categoryID"));
                int typeID = Integer.parseInt((String) params.get("update_typeID"));
                int isVegetarian = Integer.parseInt((String) params.get("update_isVegetarian"));
                int isVegan = Integer.parseInt((String) params.get("update_isVegan"));
                int hasSpecialDietaryRequirements = Integer.parseInt((String) params.get("update_hasSpecialDietaryRequirements"));
                String[] size = Utils.stringToArray((String) params.get("update_size"));
                int price = Integer.parseInt((String) params.get("update_price"));
                int stock = Integer.parseInt((String) params.get("update_stock"));
                int unitSold = Integer.parseInt((String) params.get("update_unitSold"));
                String describe = new String(((String) params.get("update_describe")).getBytes("iso-8859-1"), "utf-8");
                int status = Integer.parseInt((String) params.get("update_status"));
                int discount = Integer.parseInt((String) params.get("update_discount"));
                String[] image = product.getProductImage();
                if (!multiFileName.equals("")) {
                    image = utils.Utils.stringToArray(multiFileName);
                }

                result = pd.updateProduct(productName, categoryID, typeID, isVegetarian, isVegan, hasSpecialDietaryRequirements, size, price, stock, unitSold, describe, status, image, discount, productID);
                if (result > 0) {
                    request.setAttribute("update_status", "Update successfully!");
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    out.print("<h1>Something wrong</h1>");
                }
            }
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
