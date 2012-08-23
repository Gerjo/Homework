

package Viewers;

import Controllers.DataAccessObject;
import java.util.Vector;
import javax.swing.table.AbstractTableModel;
import Models.*;

public class TablePlayers extends AbstractTableModel {
    private String[] columnNames           = new String[] {"First Name", "Last Name", "Team Name", "Position"};
    private Vector<PlayerModel> dataVector = null;
    private DataAccessObject dataAccessObject;
    private TeamModel         lastSelected = null;

    public TablePlayers(DataAccessObject dataAccessObject) {
        this.dataAccessObject = dataAccessObject;

        refresh();
    }
    
    public void refresh() {
        dataVector = dataAccessObject.getAllPlayers();
        fireTableDataChanged();
    }

    public void showOnlyByTeam(TeamModel team) {
        dataVector   = dataAccessObject.getPlayersByTeam(team);
        lastSelected = team;
        fireTableDataChanged();
    }

    public void showOnlyByTeam() {
        if(lastSelected != null) {
            showOnlyByTeam(lastSelected);
        } else {
            refresh();
        }
    }

    public PlayerModel getModelAt(int rowIndex) {
        return dataVector.get(rowIndex);
    }

    @Override
    public String getColumnName(int column) {
        return columnNames[column];
    }

    public int getRowCount() {
        return dataVector.size();
    }

    public int getColumnCount() {
        return columnNames.length;
    }

    public Object getValueAt(int row, int column) {
        PlayerModel player = ((PlayerModel)dataVector.get(row));
        switch(column) {
            case 0: return player.getFirstname();
            case 1: return player.getLastname();
            case 2: return player.getTeamname();
            case 3: return player.getPosition();
        }

        return "";
    }

    @Override
    public boolean isCellEditable(int rowIndex, int column) {
	switch(column) {
            case 0:  return true;
            case 1:  return true;
            default: return false;
        }
    }

    @Override
    public void setValueAt(Object value, int row, int column) {
        PlayerModel player = this.getModelAt(row);
        switch(column) {
            case 0: player.setFirstname(value.toString()); break;
            case 1: player.setLastname(value.toString());  break;
            case 2: player.setTeamname(value.toString());  break;
            case 3: player.setPosition(value.toString());  break;
        }
        dataAccessObject.updatePlayer(player);
    }
}
