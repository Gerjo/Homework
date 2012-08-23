package Toolkit;

import java.util.ArrayList;

public class G_toolkit {
    public static String implode(Object[] object) {
        return join(object, "");
    }
    public static String join(Object[] object) {
        return join(object, "");
    }
    public static String implode(Object[] object, String separator) {
        return join(object, separator);
    }
    public static String join(Object[] object, String separator) {
        String buffer = "";

        for(Object value : object) {
            buffer += value.toString() + separator;
        }
        
        return rtrim(buffer, separator);
    }
    public static String rtrim(String subject, String cutoff) {
        if(subject.equals(cutoff)) return "";
        
        while(subject.substring(subject.length()-1, subject.length()).equals(cutoff)) {
            subject = subject.substring(0, subject.length()-1);
        }
        return subject;
    }
    public static String ltrim(String subject, String cutoff) {
        if(subject.equals(cutoff)) return "";

        while(subject.substring(0, 1).equals(cutoff)) {
            subject = subject.substring(1, subject.length());
        }
        return subject;
    }
    public static Object[] getColumnFromMultiArray(Object[][] subject, int columnIndex) {
        ArrayList<Object> buffer = new ArrayList<Object>();
        for(int i = 0, length = subject.length; i < length; ++i) {
            buffer.add(i, subject[i][columnIndex]);
        }

        return buffer.toArray();
    }
}
