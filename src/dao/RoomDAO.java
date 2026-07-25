package dao;

import model.Room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public int addRoom(Room r) throws SQLException {
        String sql = "INSERT INTO rooms ("
                + "owner_id, university_id, title, description, location, "
                + "room_type, gender, price, bathroom, image, status, capacity, occupied"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            bind(ps, r);
            if (ps.executeUpdate() == 0) {
                return -1;
            }
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public boolean updateRoom(Room r) throws SQLException {
        String sql = "UPDATE rooms SET owner_id=?, university_id=?, title=?, description=?, location=?, room_type=?, gender=?, price=?, bathroom=?, image=?, status=?, capacity=?, occupied=? WHERE room_id=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            bind(ps, r);
            ps.setInt(14, r.getRoomId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteRoom(int roomId) throws SQLException {
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement("DELETE FROM rooms WHERE room_id=?")) {
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        }
    }

    public Room getRoomById(int roomId) throws SQLException {
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement("SELECT * FROM rooms WHERE room_id=?")) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? map(rs) : null;
            }
        }
    }

    public List<Room> getRoomsByOwner(int ownerId) throws SQLException {
        List<Room> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement("SELECT * FROM rooms WHERE owner_id=? ORDER BY room_id DESC")) {
            ps.setInt(1, ownerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    /**
     * Search with optional filters (null / <=0 = ignore).
     */
    public List<Room> search(Integer universityId, Double maxPrice, String gender) throws SQLException {
       StringBuilder sql = new StringBuilder("SELECT * FROM rooms WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (universityId != null && universityId > 0) {
            sql.append(" AND university_id=?");
            params.add(universityId);
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }
        if (gender != null && !gender.isEmpty() && !"Any".equalsIgnoreCase(gender)) {
            sql.append(" AND (gender=? OR gender='Any')");
            params.add(gender);
        }
        sql.append(" ORDER BY price ASC");

        List<Room> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    // ---- helpers ----
    private void bind(PreparedStatement ps, Room r) throws SQLException {
        ps.setInt(1, r.getOwnerId());
        ps.setInt(2, r.getUniversityId());
        ps.setString(3, r.getTitle());
        ps.setString(4, r.getDescription());
        ps.setString(5, r.getLocation());
        ps.setString(6, r.getRoomType());
        ps.setString(7, r.getGender());
        ps.setDouble(8, r.getPrice());
        ps.setBoolean(9, r.isBathroom());
        ps.setString(10, r.getImage());
        ps.setString(11, r.getStatus() == null ? "Available" : r.getStatus());
        ps.setInt(12, r.getCapacity());
        ps.setInt(13, r.getOccupied());

    }

    private Room map(ResultSet rs) throws SQLException {

        Room r = new Room();

        r.setRoomId(rs.getInt("room_id"));
        r.setOwnerId(rs.getInt("owner_id"));
        r.setUniversityId(rs.getInt("university_id"));

        r.setTitle(rs.getString("title"));
        r.setDescription(rs.getString("description"));
        r.setLocation(rs.getString("location"));
        r.setRoomType(rs.getString("room_type"));
        r.setGender(rs.getString("gender"));

        r.setPrice(rs.getDouble("price"));
        r.setBathroom(rs.getBoolean("bathroom"));

        r.setImage(rs.getString("image"));
        r.setStatus(rs.getString("status"));

        r.setCapacity(rs.getInt("capacity"));
        r.setOccupied(rs.getInt("occupied"));

        return r;
    }
}
