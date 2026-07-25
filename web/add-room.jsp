<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.UniversityDAO, model.University, model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"Owner".equalsIgnoreCase(u.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<University> unis = new UniversityDAO().getAll();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Room</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <div class="container my-4" style="max-width:720px;">
            <h2>Add New Room</h2>


            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>

            <form action="addRoom" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="mb-3"><label>Title</label>
                    <input name="title" class="form-control" required></div>
                <div class="mb-3"><label>Description</label>
                    <textarea name="description" rows="3" class="form-control"></textarea></div>
                <div class="row">
                    <div class="col-md-6 mb-3"><label>University</label>
                        <select name="universityId" class="form-select" required>
                            <% for (University uni : unis) {%>
                            <option value="<%= uni.getUniversityId()%>"><%= uni.getUniversityName()%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3"><label>Location</label>
                        <input name="location" class="form-control" required></div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3"><label>Room Type</label>
                        <select name="roomType" class="form-select">
                            <option>Single</option><option>Shared</option><option>Family</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3"><label>Gender</label>
                        <label class="form-label">Maximum Occupants</label>

                        <select name="capacity" class="form-select" required>
                            <option value="1">1 Person</option>
                            <option value="2">2 Persons</option>
                            <option value="3">3 Persons</option>
                            <option value="4">4 Persons</option>
                        </select>

                        <small class="text-muted">
                            Select how many students can stay in this room.
                        </small>
                        <select name="gender" class="form-select">
                            <option>Any</option><option>Male</option><option>Female</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3"><label>Price (LKR)</label>
                        <input type="number"
                               name="price"
                               class="form-control"
                               min="1"
                               step="0.01"
                               required></div>
                </div>
                <div class="mb-3 d-flex flex-wrap gap-3">
                    <div class="form-check"><input type="checkbox" name="bathroom" class="form-check-input"><label class="form-check-label">Attached Bathroom</label></div>
                </div>
                <div class="mb-3"><label>Room Image</label>
                    <input type="file" name="image" accept="image/*" class="form-control"></div>
                <button class="btn btn-primary">Save Room</button>
                <a href="owner-dashboard.jsp" class="btn btn-link">Cancel</a>
            </form>
        </div>
        <%@ include file="footer.jsp" %>
        <script src="js/script.js"></script>
    </body>
</html>
