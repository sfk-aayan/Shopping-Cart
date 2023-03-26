package com.example.shopping_cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;

/**
 * This class takes requests from the cart.jsp file.
 * Whenever the user wants to delete a selection from
 * his cart, the cart.jsp sends a request to this class
 * along with an id parameter. The class then iterates over
 * the list of cart items in the cartList session attribute
 * to find a matching ID. The record with the matched ID is then
 * removed from the cartList.
 **/

public class RemoveCartController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        HttpSession session = request.getSession();

        Integer id = Integer.parseInt(request.getParameter("id"));

        if (id != null) {

                ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");
                if (cartList != null)
                {
                    for (ModelBean m : cartList) {
                        if (m.getId() == id) {
                            cartList.remove(cartList.indexOf(m));
                            session.setAttribute("cartList", cartList);
                            break;
                        }
                    }
                }
                response.sendRedirect("cart.jsp");

            } else {
                response.sendRedirect("cart.jsp");
            }

    }

}
