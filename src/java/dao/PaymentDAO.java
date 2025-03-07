/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.UserDAO.GET_USER_BY_ID;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.PaymentDTO;
import model.UserDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class PaymentDAO {

    public static final String GET_DATA_BY_ID = "select PaymentID, PaymentName from Payment where PaymentID = ?";
    public static final String GET_DATA = "select PaymentID, PaymentName from Payment";

    public PaymentDTO getPayment(int paymentID) {
        PaymentDTO payment = null;
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DATA_BY_ID;
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, paymentID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String paymentName = rs.getString("PaymentName");

                    payment = new PaymentDTO(paymentID, paymentName);
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
        return payment;

    }

    public ArrayList<PaymentDTO> getAllPayment() {
        ArrayList<PaymentDTO> paymentList = new ArrayList<>();
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = GET_DATA;
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    while (rs.next()) {
                        int paymentID = rs.getInt("PaymentID");
                        String paymentName = rs.getString("PaymentName");
                        PaymentDTO payment = new PaymentDTO(paymentID, paymentName);
                        paymentList.add(payment);
                    }
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
        return paymentList;

    }

}
