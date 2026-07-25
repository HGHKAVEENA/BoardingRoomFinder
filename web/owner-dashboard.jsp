<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.RoomDAO, dao.BookingDAO, model.Room, model.Booking, model.User" %>
<%
  User u = (User) session.getAttribute("user");
  if (u == null || !"Owner".equalsIgnoreCase(u.getRole())) { response.sendRedirect("login.jsp"); return; }
  List<Room> rooms = new RoomDAO().getRoomsByOwner(u.getId());
  List<Booking> requests = new BookingDAO().getByOwner(u.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Owner Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container my-4">
  <%
String msg = request.getParameter("msg");

if ("roomAdded".equals(msg)) {
%>

<div class="alert alert-success alert-dismissible fade show">
    <strong>✅ Room added successfully!</strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<%
} else if ("accepted".equals(msg)) {
%>

<div class="alert alert-success alert-dismissible fade show">
    <strong>✅ Booking accepted successfully!</strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<%
} else if ("rejected".equals(msg)) {
%>

<div class="alert alert-danger alert-dismissible fade show">
    <strong>❌ Booking rejected successfully!</strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<%
} else if ("ownerCancelled".equals(msg)) {
%>

<div class="alert alert-warning alert-dismissible fade show">
    <strong>⚠️ Booking cancelled by owner successfully!</strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>

<%
}
%>

  <h2>Welcome, <%= u.getFirstName() %></h2>

  <div class="d-flex justify-content-between align-items-center mt-4 mb-2">
    <h4>Your Rooms</h4>
    <a href="add-room.jsp" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Add Room</a>
  </div>

  <div class="row g-3">
    <% if (rooms.isEmpty()) { %>
      <div class="col-12"><div class="alert alert-info">You haven't listed any rooms yet.</div></div>
    <% } else for (Room r : rooms) { %>
      <div class="col-md-4">
        <div class="room-card">
         <img src="image?file=<%= r.getImage() %>"
     alt="Room Image"
     class="img-fluid rounded shadow-sm">
          <div class="p-3">
    <h6><%= r.getTitle() %></h6>

    <p class="mb-1">
        <span class="price-tag">
            LKR <%= String.format("%,.0f", r.getPrice()) %>
        </span>
    </p>

    <small class="text-muted">
        <%= r.getStatus() %>
    </small>

    <div class="room-actions">

        <a href="edit-room.jsp?id=<%= r.getRoomId() %>"
           class="btn btn-primary">
            <i class="bi bi-pencil"></i> Edit
        </a>

        <a href="deleteRoom?id=<%= r.getRoomId() %>"
           class="btn btn-danger"
           onclick="return confirm('Are you sure you want to delete this room?');">
            <i class="bi bi-trash"></i> Delete
        </a>

    </div>
</div>
        </div>
      </div>
    <% } %>
  </div>

  <h4 class="mt-5">Booking Requests</h4>
  <div class="table-responsive">
    <table class="table bg-white shadow-sm">
      <thead class="table-light">
        <tr><th>#</th><th>Student</th><th>Room</th><th>Date</th><th>Status</th><th>Actions</th></tr>
      </thead>
      <tbody>
        <% if (requests.isEmpty()) { %>
          <tr><td colspan="6" class="text-center text-muted">No booking requests yet.</td></tr>
        <% } else { int i=1; for (Booking b : requests) { %>
          <tr>
            <td><%= i++ %></td>
            <td><%= b.getStudentName() %></td>
            <td><%= b.getRoomTitle() %></td>
            <td><%= b.getBookingDate() %></td>
            <td><%= b.getBookingStatus() %></td>
            <td>
             <% if ("Pending".equals(b.getBookingStatus())) { %>

    <form action="booking" method="post" class="d-inline">
        <input type="hidden" name="action" value="accept">
        <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
        <button class="btn btn-sm btn-success">Accept</button>
    </form>

    <form action="booking" method="post" class="d-inline">
        <input type="hidden" name="action" value="reject">
        <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
        <button class="btn btn-sm btn-outline-danger">Reject</button>
    </form>

<% } else if ("Accepted".equals(b.getBookingStatus())) { %>

    <form action="booking" method="post" class="d-inline"
          onsubmit="return confirm('Cancel this accepted booking?');">

        <input type="hidden" name="action" value="ownerCancel">
        <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">

        <button class="btn btn-sm btn-warning">
            Cancel Booking
        </button>

    </form>

<% } %>
            </td>
          </tr>
        <% }} %>
      </tbody>
    </table>
  </div>
</div>
<%@ include file="footer.jsp" %>
<script src="js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
setTimeout(function () {
    const alertElement = document.querySelector(".alert");
    if (alertElement) {
        const bsAlert = bootstrap.Alert.getOrCreateInstance(alertElement);
        bsAlert.close();
    }
}, 5000);
</script>
</body>
</html>
