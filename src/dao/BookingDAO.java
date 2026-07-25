package dao;

import model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean alreadyBooked(int studentId, int roomId) throws SQLException {

        String sql = "SELECT COUNT(*) FROM bookings "
           + "WHERE student_id=? AND room_id=? "
           + "AND booking_status IN ('Pending','Accepted')";

        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, roomId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }

        return false;
    }

    public boolean rejectOtherPendingBookings(int roomId, int acceptedBookingId) {

    String sql = "UPDATE bookings "
               + "SET booking_status = ? "
               + "WHERE room_id = ? "
               + "AND booking_status = ? "
               + "AND booking_id <> ?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, "Rejected");
        ps.setInt(2, roomId);
        ps.setString(3, "Pending");
        ps.setInt(4, acceptedBookingId);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}
    
    public int createBooking(int studentId, int roomId) throws SQLException {
        String sql = "INSERT INTO bookings (student_id, room_id, booking_date, booking_status) VALUES (?,?,?, 'Pending')";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, studentId);
            ps.setInt(2, roomId);
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            if (ps.executeUpdate() == 0) {
                return -1;
            }
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public boolean updateStatus(int bookingId, String status) throws SQLException {
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement("UPDATE bookings SET booking_status=? WHERE booking_id=?")) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean cancelBooking(int bookingId,
                             int studentId,
                             String status) throws SQLException {

    String sql =
        "UPDATE bookings SET booking_status=? " +
        "WHERE booking_id=? AND student_id=?";

    try (Connection c = DBConnection.getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setString(1, status);
        ps.setInt(2, bookingId);
        ps.setInt(3, studentId);

        return ps.executeUpdate() > 0;
    }
}

    public Booking getBookingById(int bookingId) throws SQLException {

        String sql = "SELECT * FROM bookings WHERE booking_id=?";

        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }

        return null;
    }

    public List<Booking> getByStudent(int studentId) throws SQLException {
        String sql = "SELECT b.*, r.title AS room_title FROM bookings b "
                + "JOIN rooms r ON b.room_id = r.room_id WHERE b.student_id=? ORDER BY b.booking_date DESC";
        List<Booking> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = map(rs);
                    b.setRoomTitle(rs.getString("room_title"));
                    list.add(b);
                }
            }
        }
        return list;
    }

    public List<Booking> getByOwner(int ownerId) throws SQLException {
        String sql = "SELECT b.*, r.title AS room_title, CONCAT(u.first_name,' ',u.last_name) AS student_name "
                + "FROM bookings b JOIN rooms r ON b.room_id=r.room_id "
                + "JOIN users u ON b.student_id=u.id WHERE r.owner_id=? ORDER BY b.booking_date DESC";
        List<Booking> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = map(rs);
                    b.setRoomTitle(rs.getString("room_title"));
                    b.setStudentName(rs.getString("student_name"));
                    list.add(b);
                }
            }
        }
        return list;
    }

    private Booking map(ResultSet rs) throws SQLException {
        return new Booking(
                rs.getInt("booking_id"), rs.getInt("student_id"), rs.getInt("room_id"),
                rs.getTimestamp("booking_date"), rs.getString("booking_status")
        );
    }
}
