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
* Takes requests from the cart.jsp file.
 * The job of this class is to perform a
 * checkout. For simplicity's sake, I just
 * removed all the ModelBean objects from my
 * cartList ArrayList to mimic the feeling of
 * a checkout. My database doesn't have a price
 * column, so I didn't need to carry out calculations
 * during checkout.
**/

public class CheckoutControllerServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");

            if (cartList != null)
            {
                cartList.clear();
            }
            response.sendRedirect("view.jsp");
        }

    }


