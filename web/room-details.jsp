<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dao.RoomDAO,dao.UserDAO, model.Room, model.User" %>
<%
    String idParam = request.getParameter("id");

    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("search.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);

    Room r = new RoomDAO().getRoomById(id);
    User owner = new UserDAO().getUserById(r.getOwnerId());
    User u = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title><%= r != null ? r.getTitle() : "Room"%> — BoardingFinder</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <div class="container my-4">
            <% if (r == null) { %>
            <div class="alert alert-danger">Room not found.</div>
            <% } else {%>
            <div class="row g-4">

                <%
                    String msg = request.getParameter("msg");

                    if ("alreadyBooked".equals(msg)) {
                %>

                <div class="alert alert-warning d-flex justify-content-between align-items-center">

                    <div>
                        <strong>⚠️ You have already booked this room.</strong><br>
                        Please search for another available boarding room.
                    </div>

                    <a href="search" class="btn btn-warning btn-sm">
                        Find Another Room
                    </a>

                </div>

                <%
                } else if ("roomFull".equals(msg)) {
                %>

                <div class="alert alert-danger d-flex justify-content-between align-items-center">

                    <div>
                        <strong>❌ Sorry! This room is fully occupied.</strong><br>
                        Please search for another available boarding room.
                    </div>

                    <a href="search" class="btn btn-warning btn-sm">
                        Find Another Room
                    </a>

                </div>

                <%
                    }
                %>
                <div class="col-md-6">
                    <img src="image?file=<%= r.getImage()%>"
                         alt="Room Image"
                         class="img-fluid rounded shadow-sm w-100"
                         style="height:450px; object-fit:cover;">
                </div>
                <div class="col-md-6">
                    <h1 class="fw-bold mb-3"><%= r.getTitle()%></h1>
                    <a href="https://www.google.com/maps/search/?api=1&query=<%= r.getLocation() %>"
   target="_blank"
   class="text-decoration-none text-primary">
    <i class="bi bi-geo-alt-fill"></i>
    <%= r.getLocation() %>
</a>
                    <p class="mb-4"><%= r.getDescription()%></p>
                    <div class="mb-4">
                        <% if (r.isBathroom()) { %>
                        <span class="badge bg-success">Private Bathroom</span>
                        <% }%>

                        <span class="badge bg-primary"><%=r.getRoomType()%></span>
                        <span class="badge bg-warning text-dark"><%=r.getGender()%></span>
                        <% if ("Available".equals(r.getStatus())) { %>
                        <span class="badge bg-info">Available</span>
                        <% } else { %>
                        <span class="badge bg-danger">Not Available</span>
                        <% }%>
                    </div>

                    <h2 class="text-primary fw-bold mb-4">LKR <%= String.format("%,.0f", r.getPrice())%> / month</h2>

                    <div class="card shadow-sm border-0 rounded-4 mb-4 w-50">
                        <div class="card-body">
                            <h5 class="card-title">Owner Information</h5>

                            <p class="mb-1">
                                <i class="bi bi-person-fill"></i>
                                <strong>Name:</strong>
                                <%= owner.getFirstName()%> <%= owner.getLastName()%>
                            </p>

                            <p class="mb-0">
                                <i class="bi bi-telephone-fill"></i>
                                <strong>Phone:</strong>
                                <%= owner.getPhone()%>
                            </p>
                        </div>
                    </div>

                    <% if (u == null) { %>
                    <a href="login.jsp" class="btn btn-primary">Login to Book</a>
                    <% } else if ("Student".equalsIgnoreCase(u.getRole())) { %>

                    <% if ("Available".equals(r.getStatus())) {%>

                    <div class="mt-4">
                        <form action="booking" method="post" class="d-inline">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="roomId" value="<%= r.getRoomId()%>">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-calendar-check"></i> Book This Room
                            </button>
                        </form>
                    </div>

                    <% } else { %>

                    <a href="search"
                       class="btn btn-outline-primary btn-sm mt-3">
                        <i class="bi bi-search"></i> Find Another Room
                    </a>

                    <% } %>
                    <% } %>
                </div>
            </div>
            <% }%>
        </div>
        <%@ include file="footer.jsp" %>
        <script src="js/script.js"></script>
    </body>
</html>
