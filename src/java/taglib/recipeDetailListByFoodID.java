/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package taglib;

import dao.RecipeDetailDAO;
import java.util.ArrayList;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import model.RecipeDetailDTO;

/**
 *
 * @author VQN
 */
public class recipeDetailListByFoodID extends SimpleTagSupport {

    private int foodID;
    private String var;

    /**
     * Called by the container to invoke this tag. The implementation of this
     * method is provided by the tag library developer, and handles all tag
     * processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();

        try {

            JspFragment f = getJspBody();
            if (f != null) {
                f.invoke(out);
            }

            RecipeDetailDAO rd = new RecipeDetailDAO();
            ArrayList<RecipeDetailDTO> recipeDetailListByFoodID = rd.getRecipeDetailByFoodID(foodID);
            getJspContext().setAttribute(var, recipeDetailListByFoodID);

        } catch (java.io.IOException ex) {
            throw new JspException("Error in recipeDetailListByFoodID tag", ex);
        }
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public void setVar(String var) {
        this.var = var;
    }

}
