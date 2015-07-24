import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by wisteria on 2015/07/17.
 */
public class Rotate {
    public static void main(String[] argv) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(new File(argv[0])));
            String str;
            Status status = Status.First;

            Rotate rotate = null;
            int q = 0;
            int index = 1;
            Pattern sizePattern = Pattern.compile("(\\d+) (\\d+)");

            while ((str = br.readLine()) != null) {

                switch (status) {
                    case First:
                        q = Integer.parseInt(str);
                        status = Status.Size;
                        break;
                    case Size:
                        Matcher m = sizePattern.matcher(str);
                        if (m.find()) {
                            rotate = new Rotate(Integer.parseInt(m.group(1)), Integer.parseInt(m.group(2)));
                            status = Status.Table;
                        } else {
                            // error.
                            break;
                        }
                        break;
                    case Table:
                        rotate.update(str);
                        if (rotate.isFinished()) {
                            System.out.println("Case #" + index + ": " + rotate.solve());
                            index++;
                            status = Status.Size;
                        }
                        break;
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private int rows;
    private int lines;
    private int currentIndex = 0;
    private boolean debug = false;
    private String[] field;

    public Rotate(int n, int k) {
        rows = n;
        lines = k;
        field = new String[n];
    }

    public void setDebug(boolean d) {
        debug = d;
    }

    public void update(String line) {
        field[currentIndex++] = line;
    }

    public boolean isFinished() {
        return rows == currentIndex;
    }

    public String solve() {
        if (debug) {
            for (String s : field) {
                System.out.println(s);
            }
        }
        //System.out.println("left");
        return rotate(ROTATE_DIRECTION_RIGHT);
    }

    public static final int ROTATE_DIRECTION_LEFT  = 0x00;
    public static final int ROTATE_DIRECTION_RIGHT = 0x01;

    public String rotate(int direction) {
        String[] newField = new String[rows];
        System.arraycopy(field, 0, newField, 0, rows);

        for (int i=0; i<rows; i++) {
            newField[i] = newField[i].replaceAll("\\.", "");
            String padding = "";
            for (int j = 0; j < rows - newField[i].length(); j++) {
                padding += ".";
            }
            switch (direction) {
                case ROTATE_DIRECTION_LEFT:
                    newField[i] = newField[i] + padding;
                    break;
                case ROTATE_DIRECTION_RIGHT:
                    newField[i] = padding + newField[i];
                    break;
            }
        }

        if (debug) {
            System.out.println("direction: " + (direction == ROTATE_DIRECTION_LEFT ? "left" : "right"));
            for (String s : newField) {
                System.out.println(s);
            }
        }

        return check(newField);
    }

    public String check(String[] field) {
        CheckWinCondition cond = new CheckWinCondition(lines);

        // 左→上チェック
        int currentRed = 0;
        int currentBlue = 0;
        char last = '.';
        boolean redWin = false;
        boolean blueWin = false;
        for (int i=lines-1; i<rows; i++) {
            for (int j=0; j<i+1; j++) {
                char c = field[i-j].charAt(j);
                cond.update(c);
            }
            cond.reset();
        }

        // 下→右チェック
        for (int i=0; i<rows-lines+1; i++) {
            for (int j=i; j<rows; j++) {
                char c = field[rows - 1 - j + i].charAt(j);
                cond.update(c);
            }
            cond.reset();
        }

        // 左→下チェック
        for (int i=0; i<rows-lines+1; i++) {
            for (int j=0; j<rows-i; j++) {
                char c = field[i + j].charAt(j);
                cond.update(c);
            }
            cond.reset();
        }

        // 上→右チェック
        for (int i=0; i<rows-lines+1; i++) {
            for (int j=0; j<rows-i; j++) {
                char c = field[j].charAt(i+j);
                cond.update(c);
            }
            cond.reset();
        }

        // 横チェック
        for (int i=0; i<field.length; i++) {
            for (int j=0; j<field.length; j++) {
                char c = field[i].charAt(j);
                cond.update(c);
            }
            cond.reset();
        }

        // 縦チェック
        for (int i=0; i<field.length; i++) {
            for (int j=0; j<field.length; j++) {
                char c = field[j].charAt(i);
                cond.update(c);
            }
            cond.reset();
        }

        return cond.getResult();
    }
}

class CheckWinCondition {
    public static final int RED_WIN = 0b01;
    public static final int BLUE_WIN = 0b10;

    private final int winLength;

    private int winStatus = 0;

    private char last = '.';
    private int lineLength = 0;

    public CheckWinCondition(int winLength) {
        this.winLength = winLength;
    }

    public void update(char c) {
        if (last != '.' && c == last) {
            lineLength += 1;
            if (lineLength >= winLength) {
                if (c == 'R') {
                    winStatus |= RED_WIN;
                } else {
                    winStatus |= BLUE_WIN;
                }
            }
        } else {
            if (c == '.') {
                lineLength = 0;
            } else {
                lineLength = 1;
            }
        }
        last = c;
    }

    public void reset() {
        last = '.';
        lineLength = 0;
    }

    public String getResult() {
        if (winStatus == (RED_WIN | BLUE_WIN)) {
            return "Both";
        } else if (winStatus == RED_WIN) {
            return "Red";
        } else if (winStatus == BLUE_WIN) {
            return "Blue";
        } else {
            return "Neither";
        }
    }
}

enum Status {
    First,
    Size,
    Table
}
