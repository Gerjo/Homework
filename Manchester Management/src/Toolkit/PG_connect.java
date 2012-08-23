package Toolkit;

import java.sql.DriverManager;


public class PG_connect extends DB_connect implements IDBC {
    public void loadDriver() throws Exception {
        Class.forName("org.postgresql.Driver");
        isDriverLoaded = true;
    }
    public void setup(String database, String username, String password) throws Exception {
        setup(database, username, password, "localhost", 5432);
    }
    public void setup(String database, String username, String password, String host) throws Exception {
        setup(database, username, password, host, 5432);
    }
    public void setup(String database, String username, String password, String host, int port) throws Exception {
        if(!isDriverLoaded) {
            loadDriver();
        }

        dbc  = DriverManager.getConnection("jdbc:postgresql://" + host + ":" + port + "/" + database + "", username, password);
        stmt = dbc.createStatement();
    }
}
