package Viewers;

import Controllers.DataAccessObject;
import Models.PositionModel;
import java.util.Vector;
import javax.swing.AbstractListModel;
import javax.swing.ComboBoxModel;
import javax.swing.ListModel;

public class ListPositions extends AbstractListModel implements ComboBoxModel, ListModel {
    private Vector<PositionModel> dataVector;
    private DataAccessObject dataAccessObject;
    private int selectedItemIndex = -1;

    public ListPositions(DataAccessObject dataAccessObject) {
        this.dataAccessObject = dataAccessObject;
        reload();
    }
    public void reload() {
        dataVector = this.dataAccessObject.getAllPositions();
        //fireContentsChanged(this, 0, getSize());

        // Add some sort of reference to all other instances of this class.
        // Or switch to a public static?
        fireIntervalAdded(this, 0, getSize());
    }

    public int getSize() {
        return dataVector.size();
    }

    public Object getElementAt(int index) {
        return (Object) dataVector.get(index).getPositionname();
    }

    public Object[] getElementAt(int[] indices) {
        Vector<PositionModel> buffer = new Vector<PositionModel>();

        if(indices.length > 0) {
            for(int index : indices) {
                buffer.add(dataVector.get(index));
            }
        }
        return buffer.toArray();
    }

    public int getIndexOfTeamName(Object teamname) {
        for(int i = 0; i < dataVector.size(); ++i) {
            if(dataVector.get(i).getPositionname().equals(teamname)) return i;
        }
        
        return -1;
    }

    public PositionModel getPositionModelAt(int index) {
        return dataVector.get(index);
    }

    public int getSelectedPositionID() {
        if(selectedItemIndex == -1) return -1;
        return dataVector.get(selectedItemIndex).getPositionid();
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
