package model;

/**
 * Room entity — ENCAPSULATION with private fields + accessors.
 */
public class Room {

    private int roomId;
    private int ownerId;
    private int universityId;
    private String title;
    private String description;
    private String location;
    private String roomType;   // Single / Shared / Studio
    private String gender;     // Male / Female / Any
    private double price;
    private boolean bathroom;
    private String image;
    private String status;
    private int capacity;
    private int occupied;
    // Available / Booked

    public Room() {
    }

    public Room(int roomId, int ownerId, int universityId, String title,
        String description, String location, String roomType, String gender,
        double price,
        boolean bathroom, String image, String status,
        int capacity, int occupied) {

    this.roomId = roomId;
    this.ownerId = ownerId;
    this.universityId = universityId;
    this.title = title;
    this.description = description;
    this.location = location;
    this.roomType = roomType;
    this.gender = gender;
    this.price = price;
    this.bathroom = bathroom;
    this.image = image;
    this.status = status;
    this.capacity = capacity;
    this.occupied = occupied;
}

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getUniversityId() {
        return universityId;
    }

    public void setUniversityId(int universityId) {
        this.universityId = universityId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isBathroom() {
        return bathroom;
    }

    public void setBathroom(boolean bathroom) {
        this.bathroom = bathroom;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCapacity() {
        return capacity;
    }

    public int getOccupied() {
        return occupied;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public void setOccupied(int occupied) {
        this.occupied = occupied;
    }
    
}
