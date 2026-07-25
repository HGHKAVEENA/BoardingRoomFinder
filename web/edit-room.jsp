<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dao.RoomDAO, model.Room, model.User" %>

<%
    User u = (User) session.getAttribute("user");

    if (u == null || !"Owner".equalsIgnoreCase(u.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    int roomId = Integer.parseInt(request.getParameter("id"));
    Room room = new RoomDAO().getRoomById(roomId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="card shadow-lg border-0 rounded-4">

                <div class="card-body p-4">

                    <h2 class="mb-4 text-center">
                        <i class="bi bi-pencil-square"></i>
                        Edit Room
                    </h2>

                    <form action="updateRoom" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">

                        <div class="mb-3">
                            <label class="form-label">Title</label>

                            <input
                                type="text"
                                name="title"
                                class="form-control"
                                value="<%= room.getTitle() %>">
                        </div>

                        <div class="mb-3">

                            <label class="form-label">Description</label>

                            <textarea
                                name="description"
                                class="form-control"
                                rows="4"><%= room.getDescription() %></textarea>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">Location</label>

                            <input
                                type="text"
                                name="location"
                                class="form-control"
                                value="<%= room.getLocation() %>">

                        </div>

                        <div class="mb-3">

                            <label class="form-label">Price (LKR)</label>

                            <input
                                type="number"
                                name="price"
                                class="form-control"
                                value="<%= room.getPrice() %>">

                        </div>

                        <div class="mb-3">

                            <label class="form-label">Room Type</label>

                            <select name="roomType" class="form-select">

                                <option value="Single">Single</option>
                                <option value="Shared">Shared</option>
                                <option value="Studio">Studio</option>

                            </select>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">Gender</label>

                            <select name="gender" class="form-select">

                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Any">Any</option>

                            </select>

                        </div>

                       <div class="mb-4">

    <label class="form-label">Current Image</label><br>

    <img src="image?file=<%= room.getImage() %>"
         class="img-thumbnail mb-3"
         style="width:200px; height:140px; object-fit:cover;">

    <label class="form-label">Choose New Image (Optional)</label>

    <input type="file"
           name="image"
           accept="image/*"
           class="form-control">

</div>

                        <div class="text-center">

                            <button class="btn btn-success btn-lg px-5">

                                <i class="bi bi-check-circle"></i>

                                Update Room

                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>