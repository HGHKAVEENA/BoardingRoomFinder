package servlet;

import dao.BookingDAO;
import model.Owner;
import model.Student;
import model.User;
import dao.RoomDAO;
import model.Room;
import model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        BookingDAO dao = new BookingDAO();
        try {

            if ("create".equals(action) && user instanceof Student) {

                System.out.println("Step 1: Create booking started");

                int roomId = Integer.parseInt(req.getParameter("roomId"));

                RoomDAO roomDAO = new RoomDAO();
                Room room = roomDAO.getRoomById(roomId);

                // Check whether the room is already full
                if (room.getStatus().equals("Booked")) {
                    resp.sendRedirect("room-details.jsp?id=" + roomId + "&msg=roomFull");
                    return;
                }
                if (dao.alreadyBooked(user.getId(), roomId)) {
                    resp.sendRedirect("room-details.jsp?id=" + roomId + "&msg=alreadyBooked");
                    return;
                }
                // Create booking only
                dao.createBooking(user.getId(), roomId);

                resp.sendRedirect("student-dashboard.jsp?msg=bookingSuccess");

            } else if ("cancel".equals(action) && user instanceof Student) {

    int bookingId = Integer.parseInt(req.getParameter("bookingId"));

    Booking booking = dao.getBookingById(bookingId);

    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(booking.getRoomId());

    // If booking was already accepted, free one space
    if ("Accepted".equals(booking.getBookingStatus())) {

        room.setOccupied(room.getOccupied() - 1);

        if (room.getOccupied() < room.getCapacity()) {
            room.setStatus("Available");
        }

        roomDAO.updateRoom(room);
    }

    dao.cancelBooking(
            bookingId,
            user.getId(),
            "Cancelled by Student"
    );

    resp.sendRedirect("student-dashboard.jsp?msg=bookingCancelled");
    return;
} else if (("accept".equals(action)
        || "reject".equals(action)
        || "ownerCancel".equals(action))
        && user instanceof Owner) {

    int bookingId = Integer.parseInt(req.getParameter("bookingId"));

    Booking booking = dao.getBookingById(bookingId);

    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(booking.getRoomId());

    if ("accept".equals(action)) {

        // Check if room is already full
        if (room.getOccupied() >= room.getCapacity()) {
            resp.sendRedirect("owner-dashboard.jsp?msg=roomFull");
            return;
        }

        // Accept booking
        dao.updateStatus(bookingId, "Accepted");

        // Increase occupied count
        room.setOccupied(room.getOccupied() + 1);

        // Mark room as booked if full
if (room.getOccupied() >= room.getCapacity()) {
    room.setStatus("Booked");
}

roomDAO.updateRoom(room);

// If the room is now full, reject all other pending bookings
if (room.getOccupied() >= room.getCapacity()) {
    dao.rejectOtherPendingBookings(room.getRoomId(), bookingId);
}

resp.sendRedirect("owner-dashboard.jsp?msg=accepted");
return;

    } else if ("reject".equals(action)) {

        dao.updateStatus(bookingId, "Rejected");

        resp.sendRedirect("owner-dashboard.jsp?msg=rejected");
        return;

    } else if ("ownerCancel".equals(action)) {

        // Reduce occupied count safely
        if (room.getOccupied() > 0) {
            room.setOccupied(room.getOccupied() - 1);
        }

        // Make room available again
        if (room.getOccupied() < room.getCapacity()) {
            room.setStatus("Available");
        }

        roomDAO.updateRoom(room);

        dao.updateStatus(bookingId, "Cancelled by Owner");

        resp.sendRedirect("owner-dashboard.jsp?msg=ownerCancelled");
        return;
    }

}

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
