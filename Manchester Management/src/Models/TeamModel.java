
package Models;

import javax.swing.DefaultListSelectionModel;

public class TeamModel extends DefaultListSelectionModel {
    protected int teamid;
    protected String teamname;

    public TeamModel(int teamid, String teamname) {
        this.teamid = teamid;
        this.teamname = teamname;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }

    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }

    @Override
    public String toString() {
        return teamname;
    }
}
