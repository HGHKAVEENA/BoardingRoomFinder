<%@ page contentType="text/html;charset=UTF-8" %>
<%-- Simple booking confirmation page (optional standalone view) --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Booking — BoardingFinder</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container my-5 text-center">
  <h2 class="mb-3">Booking Submitted</h2>
  <p class="text-muted">Your request is pending owner approval.</p>
  <a href="student-dashboard.jsp" class="btn btn-primary">View My Bookings</a>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
