package com.example.shopping_cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * This takes requests from the cart.jsp file.
 * For every product selected, the cart.jsp file
 * offers a counter to either increment or
 * decrement the number of products selected.
 * The increments and decrements are carried out by
 * this class, where the quantity variables of the
 * cartList session attributes are either incremented
 * or decremented depending on the choice of the users.
 * However, the number of items cannot go below one, so
 * checks have been made to handle that.
 **/

public class UpdateCartController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        Integer id = Integer.parseInt(request.getParameter("id"));
        String operation = request.getParameter("op");


        if (id != null && operation != null) {

            ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");

            if (cartList != null)
            {
                if(operation.equals("plus")){
                    for (ModelBean m : cartList) {
                        if (m.getId() == id) {
                            int quantity = m.getQuantity();
                            quantity++;
                            m.setQuantity(quantity);
                            break;
                        }
                    }
                }
                else if (operation.equals("minus")){
                    for (ModelBean m : cartList) {
                        if (m.getId() == id && m.getQuantity() > 1) {
                            int quantity = m.getQuantity();
                            quantity--;
                            m.setQuantity(quantity);
                            break;
                        }
                    }
                }

            }
           response.sendRedirect("cart.jsp");

        } else {
            response.sendRedirect("cart.jsp");
        }

    }

}
