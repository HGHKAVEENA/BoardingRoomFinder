<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Room, model.University" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Search Rooms — BoardingFinder</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>

        <div class="container my-4">
            <h2 class="mb-3">Search Boarding Rooms</h2>
            <form class="row g-2 mb-4" method="get" action="search">
                <div class="col-md-4">
                    <select name="universityId" class="form-select">
                        <option value="">All Universities</option>
                        <%
                            List<University> unis = (List<University>) request.getAttribute("universities");
                            if (unis != null)
                                for (University u : unis) {
                        %>
                        <option value="<%= u.getUniversityId()%>"><%= u.getUniversityName()%></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="number" name="maxPrice" class="form-control" placeholder="Max Price (LKR)">
                </div>
                <div class="col-md-3">
                    <select name="gender" class="form-select">
                        <option value="">Any Gender</option>
                        <option>Male</option><option>Female</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-primary w-100"><i class="bi bi-search"></i> Filter</button>
                </div>
            </form>

            <div class="row g-4">
                <%
                    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                    if (rooms == null || rooms.isEmpty()) {
                %>
                <div class="col-12"><div class="alert alert-info">No rooms match your filters.</div></div>
                <% } else
                    for (Room r : rooms) {%>
                <div class="col-md-4 col-sm-6">
                    <div class="room-card">
                        <img src="image?file=<%= r.getImage()%>"
                             alt="Room Image"
                             class="card-img-top"
                             style="height:220px; object-fit:cover;">         <div class="p-3">
                            <h5><%= r.getTitle()%></h5>
                            <p class="text-muted mb-1"><i class="bi bi-geo-alt"></i> <%= r.getLocation()%></p>
                            <div class="mb-2">

                                <span class="badge bg-primary me-1">
                                    <i class="bi bi-door-open"></i>
                                    <%= r.getRoomType()%>
                                </span>

                                <span class="badge bg-secondary me-1">
                                    <i class="bi bi-person"></i>
                                    <%= r.getGender()%>
                                </span>

                                <% if (r.isBathroom()) { %>
                                <span class="badge bg-success">
                                    <i class="bi bi-droplet-fill"></i>
                                    Attached Bathroom
                                </span>
                                <% }%>

                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="price-tag">LKR <%= String.format("%,.0f", r.getPrice())%></span>
                                <a href="room-details.jsp?id=<%= r.getRoomId()%>" class="btn btn-sm btn-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
        <script src="js/script.js"></script>
    </body>
</html>
