package com.example.shopping_cart;

/**
 * The Bean class was made with the
 * required getters and setters according
 * to the data present in the MySQL database
 * I created. The only extra field here(not
 * present in the database) is the quantity
 * field, which was maintained using session
 * management.
 **/

public class ModelBean implements java.io.Serializable{
    private String name;
    private int id;
    private String image;
    private int quantity;

    public ModelBean(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity){this.quantity = quantity;}
    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

}
