/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import model.OrderDTO;
import model.OrderDetailDTO;
import model.PaymentDTO;
import model.ProductDTO;
import model.UserDTO;
import utils.DBUtils;

/**
 *
 * @author VQN
 */
public class OrderDAO {

    public ArrayList<OrderDTO> getAllOrders() {
        ArrayList<OrderDTO> orderList = new ArrayList<>();
        Connection cn = null;
        try {
            UserDAO u = new UserDAO();
            PaymentDAO p = new PaymentDAO();
            //b1tao ket noi
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //b2:viet query va exec query
                String sql = "SELECT [OrderID],[UserID],[TotalPrice],[PaymentID],[OrderDate],[OrderStatus] FROM [WEEKLYMEAL].[dbo].[Orders] Order by OrderID desc";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        UserDTO user = u.getUser(rs.getInt("UserID"));
                        int totalPrice = rs.getInt("TotalPrice");
                        PaymentDTO payment = p.getPayment(rs.getInt("PaymentID"));
                        Date date = rs.getDate("OrderDate");
                        int status = rs.getInt("OrderStatus");

                        OrderDTO order = new OrderDTO(orderID, user, totalPrice, payment, date, status);
                        orderList.add(order);
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

        return orderList;
    }

    public ArrayList<OrderDetailDTO> getOrderDetailByID(int orderID) {
        ArrayList<OrderDetailDTO> orderDetailList = new ArrayList<>();
        Connection cn = null;
        try {
            PaymentDAO p = new PaymentDAO();
            ProductDAO pd = new ProductDAO();
            OrderDAO od = new OrderDAO();
            //b1tao ket noi
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //b2:viet query va exec query
                String sql = "SELECT [OrderItemID],[ProductID],[Quantity],[OrderID] FROM [dbo].[OrderDetails] WHERE OrderID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderDetailID = rs.getInt("OrderItemID");
                        ProductDTO product = pd.getProduct(rs.getInt("ProductID"));
                        int quantity = rs.getInt("Quantity");

                        OrderDetailDTO orderDetail = new OrderDetailDTO(orderDetailID, product, quantity, orderID);
                        orderDetailList.add(orderDetail);
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

        return orderDetailList;
    }

    public ArrayList<String> getAllAddress() {
        ArrayList<String> addressList = new ArrayList<>();
        Connection cn = null;
        try {
            UserDAO u = new UserDAO();
            PaymentDAO p = new PaymentDAO();
            //b1tao ket noi
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //b2:viet query va exec query
                String sql = "SELECT DISTINCT u.UserAddress AS Address FROM [WEEKLYMEAL].[dbo].[Orders] o INNER JOIN Users u ON o.UserID = u.UserID";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                if (rs != null) {
                    while (rs.next()) {
                        String address = rs.getString("Address");

                        addressList.add(address);
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

        return addressList;
    }

    public int updateOrderStatus(int orderID, int status) {
        int rs = 0;
        Connection cn = null;
        try {
            //b1tao ket noi
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //b2:viet query va exec query
                String sql = "update Orders set OrderStatus = ? where OrderID=?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                pst.setInt(2, orderID);
                rs = pst.executeUpdate();
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
        return rs;
    }

    public int saveOrder(int userID, HashMap<ProductDTO, Integer> cart) {
        int result = 0;
        Connection cn = null;
        try {
            int totalPrice = 0;
            for (ProductDTO p : cart.keySet()) {
                totalPrice = totalPrice + cart.get(p) * p.getProductPrice();
            }
            System.out.println("a " + userID);
            //b1tao ket noi
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //b2:viet query va exec query
                cn.setAutoCommit(false);
                //Insert 1 dong vao bang Order
                String sql = "INSERT INTO [dbo].[Orders]([UserID],[TotalPrice],[PaymentID],[OrderDate],[OrderStatus]) VALUES(?,?,1,?,1)";
                //Lay order vua chen 
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userID);
                pst.setInt(2, totalPrice); //1: pending
                pst.setDate(3, new Date(System.currentTimeMillis()));
                result = pst.executeUpdate();

                if (result >= 1) {
                    sql = "select top 1 OrderID from Orders order by OrderID desc";
                    pst = cn.prepareStatement(sql);
                    ResultSet table = pst.executeQuery();
                    if (table != null && table.next()) {
                        int orderID = table.getInt("OrderID");
                        for (ProductDTO p : cart.keySet()) {
                            sql = "INSERT INTO [dbo].[OrderDetails]([ProductID],[Quantity],[OrderID]) VALUES(?,?,?)";
                            pst = cn.prepareStatement(sql);
                            pst.setInt(1, p.getProductID());
                            pst.setInt(2, cart.get(p));
                            pst.setInt(3, orderID);
                            result = pst.executeUpdate();
                        }
                        cn.commit();
                    }
                }
                System.out.println("Da toi day");
                //Duyet cart de insert vao bang order details
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.setAutoCommit(true);
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        System.out.println(result);
        return result;

    }

}
