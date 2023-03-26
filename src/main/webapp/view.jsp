<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.shopping_cart.ModelBean" %>
<%@ page import="com.example.shopping_cart.ModelListBean" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 3/25/2023
  Time: 7:24 PM
  To change this template use File | Settings | File Templates.
--%>

<%--
  Contains the shop items and the main frontend part of the
  code. The designs were done using Tailwind CSS and
  Javascript was used to provide click functionality
  to the logout button and for making sure that each
  item was added to the cart only once, otherwise an alert
  would be sent. Depending on the action taken by the
  client, requests are sent to either the other JSP files
  or to many of the servlets available. I tried to maintain the MVC
  architecture here by using an ArrayList of my ModelBean class.
  I also used the ModelListBean to initialize a database connection
  so as to get the necessary information for showcasing the products
  available in the shop.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ModelListBean items = new ModelListBean();
    ArrayList<ModelBean> itemList = items.getModelList();

    ArrayList <Integer> id_list = new ArrayList<Integer>();
    ArrayList<ModelBean> cartList = (ArrayList<ModelBean>) session.getAttribute("cartList");

    if(cartList != null){
        request.setAttribute("cartList", cartList);
        for(ModelBean b : cartList){
            id_list.add(b.getId());
        }
    }
%>
<html>
<head>
    <title>JSP - View</title>
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>

<header class="header sticky top-0 bg-white shadow-md flex items-center justify-between px-8 py-02 my-5">
    <div class="flex md:order-2 pb-4">
        <button id="logout_btn" type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-3 md:mr-0 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Logout</button>
        <button data-collapse-toggle="navbar-sticky" type="button" class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-sticky" aria-expanded="false">
        </button>
    </div>

    <div class="w-3/12 flex md:order-1 pb-4">
        <a href="cart.jsp">
            <svg class="h-8 p-1 hover:text-green-500 duration-200" aria-hidden="true" focusable="false" data-prefix="far" data-icon="shopping-cart" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class2="svg-inline--fa fa-shopping-cart fa-w-18 fa-7x"><path fill="currentColor" d="M551.991 64H144.28l-8.726-44.608C133.35 8.128 123.478 0 112 0H12C5.373 0 0 5.373 0 12v24c0 6.627 5.373 12 12 12h80.24l69.594 355.701C150.796 415.201 144 430.802 144 448c0 35.346 28.654 64 64 64s64-28.654 64-64a63.681 63.681 0 0 0-8.583-32h145.167a63.681 63.681 0 0 0-8.583 32c0 35.346 28.654 64 64 64 35.346 0 64-28.654 64-64 0-18.136-7.556-34.496-19.676-46.142l1.035-4.757c3.254-14.96-8.142-29.101-23.452-29.101H203.76l-9.39-48h312.405c11.29 0 21.054-7.869 23.452-18.902l45.216-208C578.695 78.139 567.299 64 551.991 64zM208 472c-13.234 0-24-10.766-24-24s10.766-24 24-24 24 10.766 24 24-10.766 24-24 24zm256 0c-13.234 0-24-10.766-24-24s10.766-24 24-24 24 10.766 24 24-10.766 24-24 24zm23.438-200H184.98l-31.31-160h368.548l-34.78 160z" class=""></path></svg>
            <span class="bg-green-100 text-green-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300">${cartList.size()}</span>
        </a>
    </div>
</header>

<div class="container flex flex-wrap justify-center">
        <%
            if (!itemList.isEmpty()) {
                for (ModelBean m : itemList) {
        %>
        <div class="my-6 mx-20 w-64 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
            <div class="card">
                <div class="card-body">
                        <img class="card-img rounded-t-lg" src="images/<%=m.getImage() %>"
                             alt="Card Image Ref">
                    <h5 class="card-title text-xl font-semibold tracking-tight text-gray-900 dark:text-white text-center"><%=m.getName() %></h5>
                    <div class="flex justify-center">
                    <a class="my-2 w-11/12 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 cursor-pointer" href="addcontrollerServlet?id=<%=m.getId()%>" onclick="return idCheck(<%=m.getId()%>);">Add to Cart</a>
                    </div>
                </div>
            </div>
    </div>
        <%
                }
            } else {
                out.println("No products available!");
            }
        %>
</div>
<script type="text/javascript">
    function idCheck (id) {
        const idList = "<%=id_list%>"
        if (idList.includes(id)){
            alert("Item already added to cart!")
            return false
        }
        return true
    }
</script>

<script type="text/javascript">
    document.getElementById("logout_btn").onclick = function () {
        location.href = "logoutcontrollerServlet";
    };
</script>
</body>
</html>
