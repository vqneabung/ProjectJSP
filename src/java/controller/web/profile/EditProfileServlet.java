/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.web.profile;

import dao.UserDAO;
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
public class EditProfileServlet extends HttpServlet {
    
    private static String UPDATE_USER = "jsp/home/my_account_edit.jsp";
    private static String MANAGE_USER = "ProfileServlet";
    
    public static UserDAO ud = new UserDAO();

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
        int result = 0;
        try (PrintWriter out = response.getWriter()) {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String url = UPDATE_USER;
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
            
        } catch (Exception e) {
            e.printStackTrace();
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
            boolean isMultPart = ServletFileUpload.isMultipartContent(request);
            String fileName = null;
            String pathName = "";
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
                            pathName = "/ProjectJSP/assets/home/image/" + fileName;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        
                    }
                }
                int result = 0;
                String url = MANAGE_USER;
                int userID = Integer.parseInt((String) params.get("userID"));
                UserDTO user = ud.getUser(userID);
                String username = (String) params.get("update_username");
                String fullName = (String) params.get("update_fullname");
                String password = (String) params.get("update_password");
                String phone = (String) params.get("update_phone");
                String address = (String) params.get("update_address");
                String email = (String) params.get("update_email");
                String avatar = user.getAvatar();
                if (!pathName.isEmpty()) {
                    avatar = pathName;
                }
                
                result = ud.updateUserForUser(username, fullName, email, phone, password, address, userID, avatar);
                request.getSession().removeAttribute("User");
                request.getSession().setAttribute("User", ud.getUser(userID));
                
                if (result > 0) {
                    request.setAttribute("update_status", "Update successfully!");
                    Thread.sleep(2000);
                    request.getRequestDispatcher(url).forward(request, response);
                } else {
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
