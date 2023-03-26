package com.example.shopping_cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Straightforward session management
 * implementation. At the end of all
 * the operations, the session is invalidated
 * and the user is logged out. Note that objects
 * in the cart will be lost if the user didn't check out
 * before logging out.
 **/


public class LogoutControllerServlet extends HttpServlet {
    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        if(session != null){
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }

    public void destroy() {
    }
}
