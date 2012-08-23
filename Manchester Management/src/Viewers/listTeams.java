package Viewers;

import Controllers.DataAccessObject;
import java.util.Vector;
import Models.TeamModel;
import javax.swing.AbstractListModel;
import javax.swing.ComboBoxModel;
import javax.swing.ListModel;

public class listTeams extends AbstractListModel implements ComboBoxModel, ListModel {
    private Vector<TeamModel> dataVector;
    private DataAccessObject dataAccessObject;
    private int selectedItemIndex = -1;

    public listTeams(DataAccessObject dataAccessObject) {
        this.dataAccessObject = dataAccessObject;
        reload();
    }
    
    public void reload() {
        dataVector = this.dataAccessObject.getAllTeams();
        //fireContentsChanged(this, 0, getSize());

        // Add some sort of reference to all other instances of this class.
        // Or switch to a public static?
        fireIntervalAdded(this, 0, getSize());
    }

    public int getSize() {
        return dataVector.size();
    }

    public Object getElementAt(int index) {
        return (Object) dataVector.get(index).getTeamname();
    }

    public Object[] getElementAt(int[] indices) {
        Vector<TeamModel> buffer = new Vector<TeamModel>();

        if(indices.length > 0) {
            for(int index : indices) {
                buffer.add(dataVector.get(index));
            }
        }
        return buffer.toArray();
    }

    public int getIndexOfTeamName(Object teamname) {
        for(int i = 0; i < dataVector.size(); ++i) {
            if(dataVector.get(i).getTeamname().equals(teamname)) return i;
        }
        
        return -1;
    }

    public TeamModel getTeamModelAt(int index) {
        try {
            return dataVector.get(index);
        } catch(Exception e) {

        }
        return null;
    }

    public int getSelectedTeamID() {
        if(selectedItemIndex == -1) return -1;
        return dataVector.get(selectedItemIndex).getTeamid();
    }

    // Used only for the combobox
    public void setSelectedItem(Object anItem) {
       selectedItemIndex = getIndexOfTeamName(anItem);
    }

    // Used only for the combobox
    public Object getSelectedItem() {
        if(selectedItemIndex == -1) return new String("Default Value");

        return this.getElementAt(selectedItemIndex);
    }
}
