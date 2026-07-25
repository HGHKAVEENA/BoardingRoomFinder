package model;

import java.sql.Timestamp;

public class Booking {

    private int bookingId;
    private int studentId;
    private int roomId;
    private Timestamp bookingDate;
    private String bookingStatus; // Pending / Accepted / Rejected

    // Optional joined display fields
    private String roomTitle;
    private String studentName;

    public Booking() {
    }

    public Booking(int bookingId, int studentId, int roomId,
            Timestamp bookingDate, String bookingStatus) {
        this.bookingId = bookingId;
        this.studentId = studentId;
        this.roomId = roomId;
        this.bookingDate = bookingDate;
        this.bookingStatus = bookingStatus;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public String getRoomTitle() {
        return roomTitle;
    }

    public void setRoomTitle(String roomTitle) {
        this.roomTitle = roomTitle;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}
