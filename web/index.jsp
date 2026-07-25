<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.UniversityDAO, model.University" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>BoardingFinder — Rooms for Sri Lankan Uni Students</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>

        <section>

            <div id="heroCarousel" class="carousel slide carousel-fade"
                 data-bs-ride="carousel"
                 data-bs-interval="3000">

                <div class="carousel-inner">

                    <div class="carousel-item active">
                        <img src="images/image1.png"
                             class="d-block w-100 hero-img">

                        <div class="carousel-caption hero-caption">
                            <h1>Find Your Perfect Boarding Room</h1>
                            <p>Safe, Comfortable & Affordable</p>

                            <a href="search"
                               class="btn btn-warning btn-lg px-4">
                                <i class="bi bi-search"></i>
                                Find a Boarding Room
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <img src="images/image2.png"
                             class="d-block w-100 hero-img">

                        <div class="carousel-caption hero-caption">
                            <h1>Boarding Near Universities</h1>
                            <p>Find boarding rooms close to your campus.</p>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <img src="images/image3.png"
                             class="d-block w-100 hero-img">

                        <div class="carousel-caption hero-caption">
                            <h1>Easy Online Booking</h1>
                            <p>Book your room anytime, anywhere.</p>
                        </div>
                    </div>

                </div>

                <button class="carousel-control-prev"
                        type="button"
                        data-bs-target="#heroCarousel"
                        data-bs-slide="prev">

                    <span class="carousel-control-prev-icon"></span>

                </button>

                <button class="carousel-control-next"
                        type="button"
                        data-bs-target="#heroCarousel"
                        data-bs-slide="next">

                    <span class="carousel-control-next-icon"></span>

                </button>

            </div>

        </section>

        <section class="container my-5">
            <h2 class="mb-4 text-center">Universities We Cover</h2>
            <div class="row g-3">
                <%
                    try {
                        List<University> unis = new UniversityDAO().getAll();
                        for (University u : unis) {
                %>
                <div class="col-md-4 col-sm-6">
                    <a class="text-decoration-none" href="search?universityId=<%= u.getUniversityId()%>">
                        <div class="uni-card p-3 d-flex align-items-center gap-3">
                            <i class="bi bi-mortarboard-fill fs-2 text-primary-custom"></i>
                            <div>
                                <h6 class="mb-0"><%= u.getUniversityName()%></h6>
                                <small class="text-muted"><%= u.getCity()%></small>
                            </div>
                        </div>
                    </a>
                </div>
                <%   }
                } catch (Exception e) {%>
                <div class="col-12"><div class="alert alert-warning">Database not reachable: <%= e.getMessage()%></div></div>
                <% }%>
            </div>
        </section>

        <%@ include file="footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/script.js"></script>
    </body>
</html>
