import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 50;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r, c);
        }
    }
    //your code to initialize buttons goes here
    
    setMines();


}

public void setMines()
{
    while(mines.size() < NUM_MINES)
    {
        int r = (int)(Math.random() * NUM_ROWS);
        int c = (int)(Math.random() * NUM_COLS);
    
        if(mines.contains(buttons[r][c]) == false)
        {
            mines.add(buttons[r][c]);
            System.out.println(r + ", " + c);

        }


    }
}


public void draw ()
{
    background( 0 );
    //if(flagged)
       // fill(0);

    //if(clicked && mines.contains(this))
        //fill(255, 0, 0);

    if(isWon() == true)
        displayWinningMessage();


}
public boolean isWon()
{
    for(int i = 0; i < buttons.length; i++)
    {
        for(int j = 0; j < buttons[i].length; j++)
        {
            if(buttons[i][j].isFlagged() == false || buttons[i][j].clicked == false)
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    String loseString = "You Lost!";
    for(int i = 0; i < loseString.length(); i++)
    {
        buttons[NUM_ROWS/2][5 + i].setLabel(loseString.substring(i, i + 1));
    }

}
public void displayWinningMessage()
{
    String winString = "You Won!";
    for(int i = 0; i < winString.length(); i++)
    {
        buttons[NUM_ROWS/2][5 + i].setLabel(winString.substring(i, i + 1));
    }
}
public boolean isValid(int r, int c)
{
    if(r <= NUM_ROWS && r >= 0 && c <= NUM_COLS && c >= 0)
  {
    return true;
  }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row, col - 1) && mines.contains(buttons[row][col - 1]))
      numMines += 1;
   if(isValid(row, col + 1)  && mines.contains(buttons[row][col + 1]))
      numMines += 1;
    if(isValid(row - 1, col)  && mines.contains(buttons[row - 1][col])) 
      numMines += 1;
    if(isValid(row + 1, col)  && mines.contains(buttons[row + 1][col])) 
      numMines += 1;
    if(isValid(row + 1, col + 1) && mines.contains(buttons[row + 1][col + 1])) 
      numMines += 1;
    if(isValid(row + 1, col - 1)  && mines.contains(buttons[row + 1][col - 1]))
      numMines += 1;
    if(isValid(row - 1, col + 1)  && mines.contains(buttons[row - 1][col + 1]))
      numMines += 1;
    if(isValid(row - 1, col - 1)  && mines.contains(buttons[row - 1][col - 1]))
      numMines += 1;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        
        if(mouseButton == RIGHT)
        {
            flagged = !flagged;
        }
        else if(mines.contains(this))
        {
            displayLosingMessage();
        }
        else if(countMines(myRow, myCol) > 0)
        {
            setLabel(countMines(myRow, myCol));
        }
        else 
        {
            mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if(clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
