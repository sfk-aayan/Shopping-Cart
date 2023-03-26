package com.example.shopping_cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * A class used to initialize a connection
 * to the database and also to take the data
 * from the database to create an ArrayList,
 * which can be easily accessed by the view
 * files.
 **/

public class ModelListBean {
    private ArrayList<ModelBean> model = new ArrayList<ModelBean>();

    public ArrayList<ModelBean> getModelList(){

        try{
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:port/dbname", "user", "password");

            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from webarch.products");

            while (rs.next()){
                ModelBean item = new ModelBean();
                item.setId(rs.getInt(1));
                item.setName(rs.getString(2));
                item.setImage(rs.getString(3));
                model.add(item);
            }
        }
        catch (Exception e){
            System.out.println(e);
        }
        return model;
    }
}
