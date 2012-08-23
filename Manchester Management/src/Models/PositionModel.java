package Models;


public class PositionModel {
    private int positionid;
    private String positionName;
    
    public PositionModel(int positionID, String positionName) {
        this.positionid = positionID;
        this.positionName = positionName;
    }

    public int getPositionid() {
        return positionid;
    }

    public void setPositionid(int positionID) {
        this.positionid = positionID;
    }

    public String getPositionname() {
        return positionName;
    }

    public void setPositionname(String positionName) {
        this.positionName = positionName;
    }

    @Override
    public String toString() {
       return getPositionname();
    }
}
