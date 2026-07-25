<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.BookingDAO, model.Booking, model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null || !"Student".equalsIgnoreCase(u.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Booking> bookings = new BookingDAO().getByStudent(u.getId());
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Student Dashboard</title>
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

                if ("bookingSuccess".equals(msg)) {
            %>

            <div class="alert alert-success alert-dismissible fade show">
                <strong>✅ Booking request sent successfully!</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <%
            } else if ("bookingCancelled".equals(msg)) {
            %>

            <div class="alert alert-info alert-dismissible fade show">
                <strong>ℹ️ Booking cancelled successfully.</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <%
                }
            %>

            <h2>Welcome, <%= u.getFirstName()%>!</h2>
            <p class="text-muted">Here are your booking requests.</p>
            <a href="search" class="btn btn-primary mb-3"><i class="bi bi-search"></i> Find More Rooms</a>

            <div class="table-responsive">
                <table class="table bg-white shadow-sm">
                    <thead class="table-light">
                        <tr><th>#</th><th>Room</th><th>Booked On</th><th>Status</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                        <% if (bookings.isEmpty()) { %>
                        <tr><td colspan="5" class="text-center text-muted">No bookings yet.</td></tr>
                        <% } else {
            int i = 1;
            for (Booking b : bookings) {%>
                        <tr>
                            <td><%= i++%></td>
                            <td><%= b.getRoomTitle()%></td>
                            <td><%= b.getBookingDate()%></td>
                            <td>
                                  <%
String badgeClass;

switch (b.getBookingStatus()) {

    case "Accepted":
        badgeClass = "bg-success";
        break;

    case "Rejected":
        badgeClass = "bg-danger";
        break;

    case "Cancelled by Student":
        badgeClass = "bg-secondary";
        break;

    case "Cancelled by Owner":
        badgeClass = "bg-dark";
        break;

    default: // Pending
        badgeClass = "bg-warning text-dark";
}
%>

<span class="badge <%= badgeClass %>">
    <%= b.getBookingStatus() %>
</span>
                            </td>
                            <td>
                                <% if ("Pending".equals(b.getBookingStatus())
        || "Accepted".equals(b.getBookingStatus())) { %>
                                <form action="booking" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="bookingId" value="<%= b.getBookingId()%>">
                                    <button class="btn btn-sm btn-outline-danger" data-confirm="Cancel this booking?">Cancel</button>
                                </form>
                                <% } %>
                            </td>
                        </tr>
                        <% }
            }%>
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
