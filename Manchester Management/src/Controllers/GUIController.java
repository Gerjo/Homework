package Controllers;

import javax.swing.JFrame;
import Viewers.*;
import java.awt.Image;
import java.awt.Point;
import java.awt.Toolkit;

public class GUIController {
    private Overview overview                 = null;
    private AddTeam addTeam                   = null;
    private DataAccessObject dataAccessObject = null;
    private AddPlayer addPlayer               = null;
    private Image defaultFrameIcon            = null;

    private JFrame frame_overview   = null;
    private JFrame frame_addTeam    = null;
    private JFrame frame_addPlayer  = null;

    public GUIController() {
        defaultFrameIcon = Toolkit.getDefaultToolkit().getImage("C:\\svn\\Netbeans\\Manchester\\src\\Resources\\united_logo_small.png");
        //new javax.swing.ImageIcon(getClass().getResource("/Resources/united_logo.png"))

        dataAccessObject = new DataAccessObject();
        showOverview();
    }

    public void showOverview() {
        if(overview == null) overview = new Overview(this);

        frame_overview = new JFrame("Football Club Management");
        frame_overview.setIconImage(defaultFrameIcon);
        frame_overview.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame_overview.getContentPane().add(overview);
        frame_overview.setSize(650, 490);
        frame_overview.setResizable(false);
        frame_overview.setVisible(true);
    }

    public void showAddTeam() {
        if(addTeam == null) addTeam = new AddTeam(this);

        frame_addTeam = new JFrame("Add New Team");
        frame_addTeam.setIconImage(defaultFrameIcon);
        frame_addTeam.setSize(280, 130);

        frame_addTeam.setLocation(getCenteredPoint(frame_overview, frame_addTeam));

        //frame_addTeam.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame_addTeam.getContentPane().add(addTeam);
        frame_addTeam.setResizable(false);
        frame_addTeam.setVisible(true);
    }

    public void showAddPlayer() {
        /*if(addPlayer == null)*/ addPlayer = new AddPlayer(this);

        frame_addPlayer = new JFrame("Add New Player");
        frame_addPlayer.setIconImage(defaultFrameIcon);
        frame_addPlayer.setSize(280, 300);

        frame_addPlayer.setLocation(getCenteredPoint(frame_overview, frame_addPlayer));

        //frame_addTeam.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame_addPlayer.getContentPane().add(addPlayer);
        frame_addPlayer.setResizable(false);
        frame_addPlayer.setVisible(true);
    }

    public void hideAddTeam() {
        frame_addTeam.setVisible(false);
    }

    public void hideAddPlayer() {
        frame_addPlayer.setVisible(false);
    }

    public Point getCenteredPoint(JFrame parent, JFrame child) {
        int x = (parent.getX() + parent.getWidth()/2)-child.getWidth()/2;
        int y = (parent.getY() + parent.getHeight()/2)-child.getHeight()/2;

        return new Point(x, y);
    }
    
    public AddTeam getAddTeam() { return addTeam; }
    public Overview getOverview() { return overview; }
    public DataAccessObject getDataAccessObject() { return dataAccessObject; }
}