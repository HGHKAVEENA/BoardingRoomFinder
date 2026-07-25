<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Register — BoardingFinder</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <div class="container my-5" style="max-width:560px;">
            <div class="card border-0 shadow-lg rounded-4">                <div class="card-body p-4">
                    <div class="text-center mb-4">

                        <i class="bi bi-person-plus-fill text-primary"
                           style="font-size:55px;"></i>

                        <h2 class="mt-3 fw-bold">
                            Create Your Account
                        </h2>

                        <p class="text-muted">
                            Join BoardingFinder and discover boarding rooms
                            near universities across Sri Lanka.
                        </p>

                    </div>
                    <% if (request.getAttribute("error") != null) {%>
                    <div class="alert alert-danger"><%= request.getAttribute("error")%></div>
                    <% }%>
                    <form action="register" method="post" class="needs-validation" novalidate>
                        <div class="row">
                            <div class="col-md-6 mb-3"><label class="form-label">
                                    <i class="bi bi-person"></i>
                                    First Name
                                </label>
                                <input name="firstName" class="form-control" required></div>
                            <div class="col-md-6 mb-3"><label class="form-label">
                                    <i class="bi bi-person"></i>
                                    Last Name
                                </label>
                                <input name="lastName" class="form-control" required></div>
                        </div>
                        <div class="mb-3"><label class="form-label">
                                <i class="bi bi-envelope"></i>
                                Email Address
                            </label>
                            <input type="email" name="email" class="form-control" required></div>
                        <div class="mb-3"><label class="form-label">
                                <i class="bi bi-telephone"></i>
                                Phone Number
                            </label>
                            <input type="tel" name="phone" class="form-control" pattern="[0-9]{10}" placeholder="07XXXXXXXX" autocomplete="off" required=""></div>
                        <div class="mb-3"><label class="form-label">
                                <i class="bi bi-lock"></i>
                                Password
                            </label>
                            <input type="password" name="password" class="form-control" minlength="4" required></div>
                        <div class="mb-3"><label class="form-label">
                                <i class="bi bi-person-badge"></i>
                                Register As
                            </label>
                            <select name="role" class="form-select" required>
                                <option value="" selected disabled>-- Select Role --</option>
                                <option value="Student">Student</option>
                                <option value="Owner">Boarding Owner</option>
                            </select>
                        </div>
                        <button class="btn btn-primary btn-lg w-100">
                            Create Account
                        </button>
                        <div class="text-center mt-4">
                            <span class="text-muted">
                                Already have an account?
                            </span>

                            <a href="login.jsp"
                               class="fw-semibold text-decoration-none">
                                Sign In
                            </a>
                        </div>                    </form>
                </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
        <script src="js/script.js"></script>
    </body>
</html>
