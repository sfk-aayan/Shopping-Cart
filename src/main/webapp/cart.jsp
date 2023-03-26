<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.shopping_cart.ModelBean" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 3/26/2023
  Time: 10:48 AM
  To change this template use File | Settings | File Templates.
--%>

<%--
  Contains the cart and the main frontend part of the
  code. The designs were done using Tailwind CSS and
  Javascript was used to provide click functionality
  to the buttons. Depending on the action taken by the
  client, requests are sent to either the other JSP files
  or to many of the servlets available. I tried to maintain the MVC
  architecture here by using bean elements to do much of the
  work. A database connection was also set up here to get the
  data of the products chosen from the shop.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");
    ArrayList<ModelBean> cart_products = new ArrayList<ModelBean>();

    if (cartList != null){
        try{
            if(cartList.size() > 0) {
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:port/dbname", "user", "password");

                for (ModelBean m : cartList) {
                    Statement statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("select * from webarch.products where id = " + m.getId());

                    while (rs.next()) {
                        ModelBean item = new ModelBean();
                        item.setId(rs.getInt(1));
                        item.setName(rs.getString(2));
                        item.setImage(rs.getString(3));
                        item.setQuantity(m.getQuantity());
                        cart_products.add(item);
                    }
                }
            }
    }
    catch (Exception e){
        System.out.println(e);
    }

        request.setAttribute("cartList", cartList);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Cart</title>
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100">
<header class="header sticky top-0 bg-gray-100 flex items-center justify-between px-8 py-02 my-5">
    <div class="flex md:order-2 pb-4">
        <button id="logout_btn" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-3 md:mr-0 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Logout</button>
        <button data-collapse-toggle="navbar-sticky" type="button" class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-sticky" aria-expanded="false">
        </button>
    </div>
</header>

<div class="container mx-auto mt-10">
    <div class="flex shadow-md my-10">
        <div class="w-3/4 bg-white px-10 py-10">
    <div class="flex justify-between border-b pb-8">
        <h1 class="font-semibold text-2xl">Shopping Cart</h1>
        <h2 class="font-semibold text-2xl">${cartList.size()} Product(s)</h2>
    </div>
            <div class="flex mt-10 mb-5">
                <h3 class="font-semibold text-gray-600 text-xs uppercase w-3/5">Product Details</h3>
                <h3 class="font-semibold text-center text-gray-600 text-xs uppercase w-full text-center">Quantity</h3>
            </div>

        <%
            if (cartList != null) {
                for (ModelBean c : cart_products) {
        %>
            <div class="flex items-center hover:bg-gray-100 -mx-8 px-6 py-5">
        <div class="flex w-2/5">
            <div class="w-20">
                <img class="h-24" src="images/<%=c.getImage() %>" alt="Image Spot">
            </div>
            <div class="flex flex-col justify-between ml-4 flex-grow">
                <span class="font-bold text-sm"><%=c.getName()%></span>
                <a href="removecartcontrollerServlet?id=<%=c.getId()%>" class="font-semibold hover:text-red-500 text-gray-500 text-xs">Remove</a>
            </div>
        </div>

            <div class="minus flex justify-center w-11/12">
                <a class="bnt-minus font-bold fill-current text-gray-600 w-3 transition ease-in-out delay-150 bg-white hover:-translate-y-1 hover:scale-110 hover:bg-gray-100 duration-300 ..." href="updatecartcontrollerServlet?op=minus&id=<%=c.getId()%>">-</a>

                <input class="mx-2 border text-center w-8" type="text" value="<%=c.getQuantity()%>" readonly>

                <a class="btn-plus font-bold fill-current text-gray-600 w-3 transition ease-in-out delay-150 bg-white hover:-translate-y-1 hover:scale-110 hover:bg-gray-100 duration-300 ..." href="updatecartcontrollerServlet?op=plus&id=<%=c.getId()%>">+</a>
            </div>
            </div>


        <%
                }}%>

    </div>

        <%
            Integer total = 0;
            for(ModelBean b : cartList){
                total += b.getQuantity();
            }
        %>


        <div id="summary" class="w-1/4 px-8 py-10">
            <h1 class="font-semibold text-2xl border-b pb-8">Order Summary</h1>
            <div class="flex justify-between mt-10 mb-5">
                <span class="font-semibold text-sm">Total Item(s) <%=total%></span>
            </div>
            <div class="border-t mt-8">
                <div class="flex font-semibold justify-between py-6 text-sm">
                    <span>Thanks for shopping with us!</span>
                </div>
                <button id="checkout_btn" class="bg-indigo-500 font-semibold hover:bg-indigo-600 py-3 text-sm text-white uppercase w-full">Checkout</button>
            </div>
        </div>

</div>
    <a href="view.jsp" class="flex font-semibold text-indigo-600 text-sm mt-10">

        <svg class="fill-current mr-2 text-indigo-600 w-4" viewBox="0 0 448 512"><path d="M134.059 296H436c6.627 0 12-5.373 12-12v-56c0-6.627-5.373-12-12-12H134.059v-46.059c0-21.382-25.851-32.09-40.971-16.971L7.029 239.029c-9.373 9.373-9.373 24.569 0 33.941l86.059 86.059c15.119 15.119 40.971 4.411 40.971-16.971V296z"/></svg>
        Continue Shopping
    </a>
</div>

</div>

<script type="text/javascript">
    document.getElementById("checkout_btn").onclick = function () {
        location.href = "checkoutcontrollerServlet";
    };
</script>

<script type="text/javascript">
    document.getElementById("logout_btn").onclick = function () {
        location.href = "logoutcontrollerServlet";
    };
</script>

</body>
</html>
