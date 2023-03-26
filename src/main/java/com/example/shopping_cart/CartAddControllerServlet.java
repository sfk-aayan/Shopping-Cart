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
 * Takes requests from the view.jsp file.
 * The job of this class is to add the user's
 * selected products into a cartList. This class
 * also creates a session attribute called cartList
 * so that the selected items can be tracked even when
 * users jump to other pages of the website. Every new item
 * added by the user gets added to the cartList attribute.
 **/

public class CartAddControllerServlet extends HttpServlet {
    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        ArrayList<ModelBean> ogcartList = new ArrayList<ModelBean>();

        int id = Integer.parseInt(request.getParameter("id"));
        ModelBean new_cart = new ModelBean();
        new_cart.setId(id);
        new_cart.setQuantity(1);

        HttpSession session = request.getSession();
        ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");

        if(cartList == null){
            ogcartList.add(new_cart);
            session.setAttribute("cartList", ogcartList);
            response.sendRedirect("view.jsp");
        }
        else{
            ogcartList = cartList;
            boolean exists = false;
            for(ModelBean m: ogcartList){
                if(m.getId() == id){
                    exists = true;
                    out.println("Item already chosen!");
                    response.sendRedirect("view.jsp");
                }
            }
            if(!exists){
                ogcartList.add(new_cart);
                response.sendRedirect("view.jsp");
            }
        }

    }

    public void destroy() {
    }

}
