/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.management.user;

import static controller.web.login.RegisterServlet.LOGIN;
import static controller.web.login.RegisterServlet.validate;
import dao.UserDAO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDTO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author VQN
 */
@MultipartConfig
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
            throws ServletException, IOException, InterruptedException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("UTF-8");
            boolean isMultPart = ServletFileUpload.isMultipartContent(request);
            String fileName = null;
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
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                }//end while
                String fullName = (String) params.get("insert_fullname");
                String userName = (String) params.get("insert_username");
                String email = (String) params.get("insert_email");
                String phone = (String) params.get("insert_phone");
                String address = new String(((String) params.get("insert_address")).getBytes("iso-8859-1"), "utf-8");
                String password = (String) params.get("insert_password");
                String stringRoleID = (String) params.get("insert_role");
                int roleID = Integer.parseInt(stringRoleID);
                String avatar = "/ProjectJSP/assets/home/image/" + fileName;
                System.out.println("avatar   " + avatar);

                if (!validate(email)) {
                    response.sendRedirect("ManageUserServlet?msg=insertFail");
                }

                UserDAO ud = new UserDAO();
                UserDTO user = ud.getUser(email);
                if (user == null) { //email khong trung
                    int rs = ud.insertUser(userName, fullName, email, phone, roleID, password, address, avatar);
                    TimeUnit.SECONDS.sleep(1);
                    if (rs >= 1) {
                        response.sendRedirect("ManageUserServlet?msg=insertSuccessfully");
                    } else {
                        response.sendRedirect("ManageUserServlet?msg=insertFailed");
                    }
                } else {
                    response.sendRedirect("ManageUserServlet?msg=emailTrung");
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
        request.getRequestDispatcher("jsp/admin/admin_user_insert.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (InterruptedException ex) {
            Logger.getLogger(InsertUserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
