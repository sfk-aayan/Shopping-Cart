package com.example.shopping_cart;

import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

/**
 * Mainly used for logging in
 * and for starting the session.
 * The user's name is kept as a
 * session attribute and then a
 * request is dispatched to the
 * view.jsp file.
 **/

public class ControllerServlet extends HttpServlet {

    public void init() {
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String username = request.getParameter("name");

        HttpSession session = request.getSession(true);
        session.setAttribute("currentUser", username);
        session.setMaxInactiveInterval(30*60);

        RequestDispatcher rd = request.getRequestDispatcher("/view.jsp");
        rd.include(request, response);
    }

    public void destroy() {
    }
}