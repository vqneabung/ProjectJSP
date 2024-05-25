/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.TypeDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class TypeDAO {

    public static final String GET_TYPE_BY_ID = "Select TypeID, TypeName from Types Where TypeID = ?";

    public TypeDTO getType(int typeID) {

        TypeDTO type = null;
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_TYPE_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, typeID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String typeName = rs.getString("TypeName");
                    type = new TypeDTO(typeID, typeName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return type;

    }

}
