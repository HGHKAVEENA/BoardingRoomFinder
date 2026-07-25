<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login — BoardingFinder</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <div class="container my-5" style="max-width:460px;">
            <div class="card border-0 shadow-lg rounded-4">
                <div class="card-body p-4">
                    <div class="text-center mb-3">
                        <i class="bi bi-house-door-fill text-primary"
                           style="font-size:55px;"></i>
                    </div>
                    <h3 class="text-center mb-4">Welcome Back</h3>
                    <p class="text-muted text-center mb-4">
                        Sign in to continue to BoardingFinder
                    </p>
                    <% if (request.getParameter("registered") != null) { %>
                    <div class="alert alert-success">Registration successful. Please log in.</div>
                    <% } %>
                    <% if (request.getAttribute("error") != null) {%>
                    <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
                    <% }%>
                    <form action="login" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label>
                                <i class="bi bi-envelope"></i>
                                Email Address
                            </label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>
                                <i class="bi bi-lock"></i>
                                Password
                            </label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button class="btn btn-primary btn-lg w-100">
                            Login to Account
                        </button>                        <p class="text-center mt-3 mb-0">No account? <a href="register.jsp">Register</a></p>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
        <script src="js/script.js"></script>
    </body>
</html>
