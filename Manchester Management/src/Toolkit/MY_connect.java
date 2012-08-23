package Toolkit;

import Toolkit.IDBC;
import java.sql.DriverManager;


public class MY_connect extends DB_connect implements IDBC {
    public void loadDriver() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        isDriverLoaded = true;
    }
    public void setup(String database, String username, String password) throws Exception {
        setup(database, username, password, "localhost", 3306);
    }
    public void setup(String database, String username, String password, String host) throws Exception {
        setup(database, username, password, host, 3306);
    }
    public void setup(String database, String username, String password, String host, int port) throws Exception {
        if(!isDriverLoaded) {
            loadDriver();
        }

        dbc  = DriverManager.getConnection("jdbc:mysql://" + host + ":" + port + "/" + database + "", username, password);
        stmt = dbc.createStatement();
    }
}
