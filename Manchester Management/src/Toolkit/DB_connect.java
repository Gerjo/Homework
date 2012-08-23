package Toolkit;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public abstract class DB_connect implements IDBC {
    protected Connection dbc  = null;
    protected Statement stmt  = null;
    //protected ResultSet res   = null;

    protected boolean isDriverLoaded  = false;

    public ResultSet select(String sql) throws SQLException {
        if(isDriverLoaded) {
            stmt = dbc.createStatement();
            return stmt.executeQuery(sql);
        }
        return null;
        new Throwable();
    }

    public void update(String sql) throws SQLException {
        if(isDriverLoaded) {
            stmt.executeUpdate(sql);
        }
    }

    public int fetchInt(String sql) {
        try {
            ResultSet res = select(sql);
            res.next();
            return res.getInt(1);
        } catch(Exception e) {
            return -1;
        }
    }

    public Object[] getColumnFromMultiArray(Object[][] subject, int columnIndex) {
        ArrayList<Object> buffer = new ArrayList<Object>();
        for(int i = 0, length = subject.length; i < length; ++i) {
            buffer.add(i, subject[i][columnIndex]);
        }

        return buffer.toArray();
    }


        /*
     * This method has to be rewritten once I am better at Java.
     * Method assumes that the ResultSet has atleast once record.
     */
    public String[][] SQLtoArray(String sql) {
       ArrayList<String[]> allData = new ArrayList<String[]>();
       int columnCount             = -1;

       try {
           // Execute the query:
           ResultSet res = this.select(sql);

           // Iterate over the result set and put the items in an arrayList:
           while(res.next()) {
              if(columnCount == -1) columnCount = res.getMetaData().getColumnCount();

              String[] fieldData = new String[columnCount];

              // Iterate over each column and store the field value in an array:
              for(int i = 0; i < columnCount; ++i) {
                  fieldData[i] = res.getString(i+1);
              }
              // Store the newly generated array in the arrayList:
              allData.add(fieldData);
           }

           // Build a multidimensional (string) array from the arrayList:
           int i = 0;
           String[][] finalData = new String[allData.size()][columnCount];
           for(String[] foo : allData) {
               finalData[i++] = foo;
           }

           //return (String[][]) allData.toArray();

           return finalData;

       // Should the SQL query fail:
       } catch(Exception e) {
           System.out.println(e);
           return new String[0][0];
       }
    }
}
