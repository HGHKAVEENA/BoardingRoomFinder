<%@ page contentType="text/html;charset=UTF-8" %>
<%-- Reusable navigation bar --%>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="bi bi-house-door-fill"></i> BoardingFinder
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-2">

                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="search">Search Rooms</a>
                </li>

                <!-- Theme Toggle -->
                <li class="nav-item">
                    <button id="themeToggle" class="btn btn-outline-secondary rounded-circle">
                        <i class="bi bi-moon-fill"></i>
                    </button>
                </li>

                <% if (session.getAttribute("user") == null) { %>

                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-primary" href="register.jsp">Register</a>
                </li>

                <% } else {

                    String role = (String) session.getAttribute("role");
                    String dash = "Owner".equalsIgnoreCase(role)
                            ? "owner-dashboard.jsp"
                            : "student-dashboard.jsp";

                %>

                <li class="nav-item">
                    <a class="nav-link" href="<%= dash%>">Dashboard</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-outline-danger btn-sm" href="logout">Logout</a>
                </li>

                <% }%>

            </ul>
        </div>
    </div>
</nav>
