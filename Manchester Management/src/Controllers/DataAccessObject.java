
package Controllers;

import Models.PlayerModel;
import Models.PositionModel;
import Models.TeamModel;
import Toolkit.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/* IMPORTANT: File must be rewritten for prepared statements.
 *
 *
 */

public class DataAccessObject {
    private IDBC dbc;

    public DataAccessObject() {
        try {
           // dbc = new PG_connect();
           dbc = new MY_connect();

           dbc.setup("school", "school", "fiction"); //"83.87.181.228"
           
        } catch(Exception e) {
            System.out.println("Unable to connect to the database: " + e);
        }
    }

    public Vector<PlayerModel> getAllPlayers() {
       Vector<PlayerModel> players = new Vector<PlayerModel>();
       try {
            ResultSet res = dbc.select("SELECT playerid, firstname, lastname, teamname, positionname as position FROM players LEFT JOIN teams USING (teamid) LEFT JOIN positions USING (positionid) ORDER BY playerid DESC");
            while(res.next()) {
                players.add(new PlayerModel( res.getInt(1), res.getString(2),res.getString(3), res.getString(4),res.getString(5)));
            }
        } catch(Exception e) {
            System.out.println("hiya " + e);
        }

       return players;
    }

    public Vector<PlayerModel> getPlayersByTeam(TeamModel team) {
       Vector<PlayerModel> players = new Vector<PlayerModel>();
       try {
            ResultSet res = dbc.select("SELECT playerid, firstname, lastname, teamname, positionname as position FROM players LEFT JOIN teams USING (teamid)  LEFT JOIN positions USING (positionid) WHERE teamid = " + team.getTeamid() + " ORDER BY playerid DESC");
            while(res.next()) {
                players.add(new PlayerModel( res.getInt(1), res.getString(2),res.getString(3), res.getString(4),res.getString(5)));
            }
        } catch(Exception e) {
            System.out.println(e);
        }

       return players;
    }

    public Vector<TeamModel> getAllTeams() {
        Vector<TeamModel> teams = new Vector<TeamModel>();

        try {
            ResultSet res = dbc.select("SELECT teamid, teamname FROM teams ORDER BY teamid DESC");
            while(res.next()) {
                teams.add(new TeamModel(res.getInt(1), res.getString(2)));
            }
            
        } catch(Exception e) {
            System.out.println(e);
        }
        return teams;
    }

    public Vector<PositionModel> getAllPositions() {
        Vector<PositionModel> teams = new Vector<PositionModel>();

        try {
            ResultSet res = dbc.select("SELECT positionid, positionname FROM positions ORDER BY positionid DESC");
            while(res.next()) {
                teams.add(new PositionModel(res.getInt(1), res.getString(2)));
            }

        } catch(Exception e) {
            System.out.println(e);
        }
        return teams;
    }


    public void deletePlayers(Object[] indices) {
        if(indices.length > 0) {
            for(Object index : indices) {
                System.out.println(index);
                String[] playerData = null;//_model.getPlayerByIndex(index);
                try {
                   dbc.update("DELETE FROM players WHERE playerid = '" + index + "' LIMIT 1");
                } catch(Exception e) {
                   System.out.println("Delete failed: " + e);
                }
            }
        }
    }

    public void updatePlayer(PlayerModel player) {
        try {
            dbc.update("UPDATE players SET firstname = '" + player.getFirstname() + "', lastname = '" + player.getLastname() + "' WHERE playerid = '" + player.getPlayerid() + "' LIMIT 1");
        } catch(Exception e) {
            System.out.println(e);
        }
    }

    public void addNewTeam(String teamname) {
        try {
            dbc.update("INSERT INTO teams (teamname) VALUES ('" + teamname + "')");
        } catch(Exception e) {
            System.out.println(e);
        }
    }

    public void addNewPlayer(String firstname, String lastname, int positionid, int teamid) {
       try {
            dbc.update("INSERT INTO players (firstname, lastname, positionid, teamid) VALUES ('" + firstname + "','" + lastname + "','" + positionid + "','" + teamid + "')");
        } catch(Exception e) {
            System.out.println(e);
        }
    }

    public boolean isUniqueTeam(String teamname) {
        try {
            return !dbc.select("SELECT 1 FROM teams WHERE teamname = '" + teamname + "' LIMIT 1").next();
        } catch(Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public void deleteTeams(Object[] teams) {
        if(teams.length > 0) {
            for(Object team : teams) {
                TeamModel temp = (TeamModel) team;
                try {
                    if (!dbc.select("SELECT 1 FROM players WHERE teamid = '" + temp.getTeamid() + "' LIMIT 1").next()) {
                        dbc.update("DELETE FROM teams WHERE teamid = '" + temp.getTeamid() + "' LIMIT 1");
                    } else { }
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        } else { }
    }
}
