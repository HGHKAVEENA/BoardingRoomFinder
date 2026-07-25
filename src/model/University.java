package model;

public class University {
    private int universityId;
    private String universityName;
    private String city;

    public University() {}
    public University(int universityId, String universityName, String city) {
        this.universityId = universityId;
        this.universityName = universityName;
        this.city = city;
    }
    public int getUniversityId() { return universityId; }
    public void setUniversityId(int universityId) { this.universityId = universityId; }
    public String getUniversityName() { return universityName; }
    public void setUniversityName(String universityName) { this.universityName = universityName; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
}
