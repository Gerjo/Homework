package Toolkit;

import java.sql.ResultSet;
import java.sql.SQLException;


public interface IDBC {
    public void update(String sql) throws SQLException;
    public ResultSet select(String sql) throws SQLException;
    public void loadDriver() throws Exception;
    public void setup(String database, String username, String password) throws Exception;
    public void setup(String database, String username, String password, String host) throws Exception;
    public void setup(String database, String username, String password, String host, int port) throws Exception;
    public int fetchInt(String sql);
    public String[][] SQLtoArray(String sql);
    public Object[] getColumnFromMultiArray(Object[][] subject, int columnIndex);
}
