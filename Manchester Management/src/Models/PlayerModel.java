package Models;

public class PlayerModel {
    protected int playerid;
    protected String firstname;
    protected String lastname;
    protected String teamname;
    protected String position;

    public PlayerModel() {
        this(0, "", "", "", "");
    }
    /**
     * 
     * @param playerid  Playerid unique
     * @param firstname Firstname
     * @param lastname  Lastname
     * @param teamname  Teamname
     */
    public PlayerModel(int playerid, String firstname, String lastname, String teamname, String position) {
        this.playerid = playerid;
        this.firstname = firstname;
        this.lastname = lastname;
        this.teamname = teamname;
        this.position = position;
    }
    
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public int getPlayerid() {
        return playerid;
    }

    public void setPlayerid(int playerid) {
        this.playerid = playerid;
    }

    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }
    
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

}
