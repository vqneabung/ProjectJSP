/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package taglib;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author VQN
 */
public class Taglib extends SimpleTagSupport {

    private String encode;

    /**
     * Called by the container to invoke this tag. The implementation of this
     * method is provided by the tag library developer, and handles all tag
     * processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();

        try {
            // TODO: insert code to write html before writing the body content.
            // e.g.:
            //
            // out.println("<strong>" + attribute_1 + "</strong>");
            // out.println("    <blockquote>");

            JspFragment f = getJspBody();
            if (f != null) {
                f.invoke(out);
            }

            try {
                // Khởi tạo đối tượng MessageDigest với thuật toán SHA-256
                MessageDigest digest = MessageDigest.getInstance("SHA-256");

                // Băm mật khẩu
                byte[] hash = digest.digest(encode.getBytes());

                // Chuyển đổi byte array sang chuỗi hex
                StringBuilder hexString = new StringBuilder();
                for (int i = 0; i < hash.length; i++) {
                    String hex = Integer.toHexString(0xff & hash[i]);
                    if (hex.length() == 1) {
                        hexString.append('0');
                    }
                    hexString.append(hex);
                }

                out.print(hexString.toString().substring(0, 10) + "...");
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
                return;
            }
        } catch (java.io.IOException ex) {
            throw new JspException("Error in Taglib tag", ex);
        }
    }

    public void setEncode(String encode) {
        this.encode = encode;
    }

}
