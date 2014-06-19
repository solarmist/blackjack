{AP Computer Science A Final Project 06/03/1998}

unit Cards;

interface

type
   SuitType = (Hearts, Diamonds, Clubs, Spades);
   SuitNum  = array [1..13] of boolean;
   DeckType = array [Hearts..Spades] of SuitNum;

procedure Hit(var Deck,Deal: DeckType; var NumCards: integer);
{Pre: A deck is passed
Post: A card is added to your hand and NumCards is + 1}
{------------------}
procedure DrawHand(var Deck: DeckType; y: integer);
{Pre: Y is set correctly and a valid deck is passed
Post: one's hand is drawn on the screen}
procedure DrawCard(x,y: integer; var CType: SuitType; num: integer);
{Pre: (x,y)
Post: A card is drawn}
{------------------}
procedure DrawClub(x,y: integer);
{Pre: (x,y)
Post: A Club is drawn}
{------------------}
procedure DrawHeart(x,y: integer);
{Pre: (x,y)
Post: A Heart is drawn}
{------------------}
procedure DrawDiamond(x,y: integer);
{Pre: (x,y)
Post: A Diamond is drawn}
{------------------}
procedure DrawSpade(x,y: integer);
{Pre: (x,y)
Post: A Spade is drawn}
{------------------}
function CardNum(num: integer): String;
{Pre: An integer between 1..13 is passed
Post: A string with the card label is returned}
{------------------}
function RandSuit:SuitType;
{Pre: none
Post: A random suit is returned.}
{------------------}
procedure InitDeck(var Deck: DeckType);
{Pre: A deck is passed
Post: An unused deck is returned}
{------------------}
function Total(var Deck: DeckType):integer;
{Pre: A single hand is in the deck
Post: The total of the cards is returned}
{------------------}

implementation
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-}

procedure InitDeck(var Deck: DeckType);
{Pre: A deck is passed
Post: An unused deck is returned}
var
  i: integer;
  Suit: SuitType;
begin
  for suit:= hearts to spades do
    for i:= 1 to 13 do
      Deck[Suit, i]:= false;
end;
{----------------------------------}

procedure Hit(var Deck,Deal: DeckType; var NumCards: integer);
{Pre: A deck is passed
Post: A card is added to your hand and NumCards is + 1}
var
  Num: integer;
  Suit: SuitType;
begin
if NumCards < 5
  then begin
    repeat
      Num:= Random(12) + 1;
      Suit:= RandSuit;
    until Not Deck[Suit, Num] and Not Deal[Suit, Num];

    Deck[Suit, Num]:= True;
    NumCards:= NumCards + 1;
  end;{then}
end;
{----------------------------------}

function Total(var Deck: DeckType):integer;
{Pre: A single hand is in the deck
Post: The total of the cards is returned}
var
  Num, Aces: integer;
  Suit: SuitType;
  Temp: integer;
begin
  Temp:=0;
  Aces:=0;
  for Num:= 13 downto 1 do
    for Suit:= Hearts to Spades do begin
      if Deck[Suit, Num] = True
        then case Num of
          10..13:  Temp:= Temp + 10;
          2..9:  Temp:= Temp + Num;
          1:  begin
                if Temp + 11 > 21
                  then Temp:= Temp + 1
                  else begin
                    Temp:= Temp + 11;
                    Aces:= Aces + 1;
                end;
          end; {case}
        end; {if}
    end; {for}
    while (Temp > 21) and (Aces > 0) do
      Temp:= Temp - 10;
  Total:= temp;
end;
{----------------------------------}

function RandSuit:SuitType;
{Pre: none
Post: A random suit is returned.}
begin
  randomize;

  case random(3) of
    0:  RandSuit:= Hearts;
    1:  RandSuit:= Diamonds;
    2:  RandSuit:= Clubs;
    3:  RandSuit:= Spades;
  end;
end;
{----------------------------------}

function CardNum(num: integer): String;
{Pre: An integer between 1..13 is passed
Post: A string with the card label is returned}
begin
  case num of
    1:  CardNum:='A';
    2:  CardNum:='2';
    3:  CardNum:='3';
    4:  CardNum:='4';
    5:  CardNum:='5';
    6:  CardNum:='6';
    7:  CardNum:='7';
    8:  CardNum:='8';
    9:  CardNum:='9';
    10:  CardNum:='10';
    11:  CardNum:='J';
    12:  CardNum:='Q';
    13:  CardNum:='K';
  end;
end;
{----------------------------------}

procedure DrawClub(x,y:integer);
{Pre: (x,y)
Post: A Club is drawn}
var
  OldPattern:FillPatternType;
begin
  GetFillPattern(OldPattern);
  SetFillPattern(OldPattern, Blue);
  SetColor(Blue);

  {Draw the club head}
  arc(x+7, y+5, 0, 360, 7);
  arc(x, y-6, 0, 360, 7);
  arc(x-7, y+5, 0, 360, 7);

  {Draw the base}
  arc(x-12, y+11, 290, 20, 10);
  arc(x+12, y+11, 180, 260, 10);
  line(x-10, y+21, x+9, y+21);

  {Fill in the base}
  line(x, y, x, y+2);
  line(x-8, y+20, x+7, y+20);
  line(x-6, y+20, x+6, y+19);
  line(x-5, y+20, x+5, y+18);
  line(x-4, y+20, x+4, y+17);
  line(x-3, y+20, x+3, y+16);
  line(x-2, y+20, x+2, y+15);
  line(x-2, y+20, x+2, y+14);
  line(x-2, y+20, x+2, y+13);
  line(x-2, y+20, x+2, y+12);
  line(x-2, y+20, x+2, y+11);
  line(x-2, y+20, x+2, y+10);
  line(x-1, y+9, x+1, y+9);
  line(x-1, y+8, x+1, y+8);

  fillEllipse(x+7, y+5, 7, 7);
  fillEllipse(x, y-6, 7, 7);
  fillEllipse(x-7, y+5, 7, 7);
end;
{----------------------------------}

procedure DrawHeart(x,y:integer);
{Pre: (x,y)
Post: A Heart is drawn}
var
  OldPattern:FillPatternType;
begin
  y:= y - 4;

  GetFillPattern(OldPattern);
  SetFillPattern(OldPattern, Red);
  SetColor(Red);

  {Draw the heart}
  arc(x-8, y, 0, 230, 8);
  arc(x+8, y, 320, 180, 8);
  line(x+15, y+4, x, y+25);
  line(x-15, y+4, x, y+25);
  fillEllipse(x-8, y, 8, 8);
  fillEllipse(x+8, y, 8, 8);

  {Draw the dividing line}
  line(x, y+25, x, y);

  {Fill left side}
  line(x, y+25, x-1, y);
  line(x, y+25, x-3, y);
  line(x, y+25, x-5, y-1);
  line(x, y+25, x-7, y-2);
  line(x, y+25, x-9, y-3);
  line(x, y+25, x-11, y-4);
  line(x, y+25, x-12, y-4);
  line(x, y+25, x-13, y-5);
  line(x, y+25, x-14, y-4);
  line(x, y+25, x-15, y-4);
  line(x, y+25, x-16, y);
  line(x-6, y+15, x-12, y+4);

  {Fill right side}
  line(x, y+25, x+1, y);
  line(x, y+25, x+3, y);
  line(x, y+25, x+5, y-1);
  line(x, y+25, x+7, y-2);
  line(x, y+25, x+9, y-3);
  line(x, y+25, x+11, y-4);
  line(x, y+25, x+12, y-4);
  line(x, y+25, x+13, y-5);
  line(x, y+25, x+14, y-4);
  line(x, y+25, x+15, y-4);
  line(x, y+25, x+16, y);
  line(x+6, y+15, x+12, y+4);
end
{----------------------------------}

procedure DrawDiamond(x,y:integer);
{Pre: (x,y)
Post: A Diamond is drawn}
var
  Diamond: array[1..4] of PointType;
  OldPattern:FillPatternType;
begin
  y:= y + 4

  GetFillPattern(OldPattern);
  SetFillPattern(OldPattern, Red);
  SetColor(Red);

  Diamond[1].x:= x - 15;
  Diamond[1].y:= y;
  Diamond[2].x:= x;
  Diamond[2].y:= y - 20;
  Diamond[3].x:= x + 15;
  Diamond[3].y:= y;
  Diamond[4].x:= x;
  Diamond[4].y:= y + 20;

  line(x-12, y, x, y-17);
  line(x+12, y, x, y-17);
  line(x, y+17, x+12, y);
  line(x, y+17, x-12, y);

  fillPoly(4, Diamond);

end
{----------------------------------}

procedure DrawSpade(x,y:integer);
{Pre: (x,y)
Post: A Spade is drawn}
var
  OldPattern:FillPatternType;
begin
  y:= y + 6;

  GetFillPattern(OldPattern);
  SetFillPattern(OldPattern, Blue);
  SetColor(Blue);

  {Draw upside down heart}
  arc(x-8, y, 0, 230, 8);
  arc(x+8, y, 320, 180, 8);
  line(x+15, y-4, x, y-25);
  line(x-15, y-4, x, y-25);
  fillEllipse(x-8, y, 8, 8);
  fillEllipse(x+8, y, 8, 8);

  {Draw the dividing line}
  line(x, y-25, x, y);

  {Fill the left side}
  line(x, y-25, x-1, y);
  line(x, y-25, x-3, y);
  line(x, y-25, x-5, y+1);
  line(x, y-25, x-7, y+2);
  line(x, y-25, x-9, y+3);
  line(x, y-25, x-11, y+4);
  line(x, y-25, x-12, y+4);
  line(x, y-25, x-13, y+5);
  line(x, y-25, x-14, y+4);
  line(x, y-25, x-15, y+4);
  line(x, y-25, x-16, y);
  line(x-6, y-15, x-12, y-4);

  {Fill the right side}
  line(x, y-25, x+1, y);
  line(x, y-25, x+3, y);
  line(x, y-25, x+5, y+1);
  line(x, y-25, x+7, y+2);
  line(x, y-25, x+9, y+3);
  line(x, y-25, x+11, y+4);
  line(x, y-25, x+12, y+4);
  line(x, y-25, x+13, y+5);
  line(x, y-25, x+14, y+4);
  line(x, y-25, x+15, y+4);
  line(x, y-25, x+16, y);
  line(x+6, y-15, x+12, y-4);

  {Draw the base}
  arc(x-12, y+7, 290, 20, 10);
  arc(x+12, y+7, 140, 260, 10);
  line(x-10, y+17, x+9, y+17);

  {Fill in the base}
  line(x, y, x, y+3);
  line(x-8, y+16, x+7, y+16);
  line(x-6, y+15, x+6, y+15);
  line(x-5, y+14, x+5, y+14);
  line(x-4, y+13, x+4, y+13);
  line(x-3, y+12, x+3, y+12);
  line(x-2, y+11, x+2, y+11);
  line(x-2, y+10, x+2, y+10);
  line(x-2, y+9, x+2, y+9);
  line(x-2, y+8, x+2, y+8);
  line(x-2, y+7, x+2, y+7);
  line(x-2, y+6, x+2, y+6);
  line(x-1, y+4, x+1, y+5);
  line(x-1, y+4, x+1, y+4);
end
{----------------------------------}

procedure DrawCard(x,y: integer, var CType: SuitType, num: integer);
{Pre: (x,y)
Post: A card is drawn}
begin
  SetColor(White);

  {Draw the number}
  SetTextStyle(DefaultFont, HorizDir, 2);
  OutTextXY(x-2, y, CardNum(num));
  OutTextXY(x+78, y+135, CardNum(num));

  {Draw the card}
  Arc(x, y, 90, 180, 10);
  Arc(x+100, y, 0, 90, 10);
  Arc(x+100, y+150, 270, 0, 10);
  Arc(x, y+150, 180, 270, 10)

  line(x, y-10, x+100, y-10);
  line(x-10, y, x-10, y+150);
  line(x+110, y, x+110, y+150);
  line(x, y+160, x+100, y+160);

  {Draw the suit}
  case CType of
    Hearts:  DrawHeart(x+50, y+65);
    Clubs:  DrawClub(x+50, y+65);
    Diamonds:  DrawDiamond(x+50, y+65);
    Spades:  DrawSpade(x+50, y+65);
  end;
end
{----------------------------------}

procedure DrawHand(var Deck: DeckType, y: integer);
{Pre: Y is set correctly and a valid deck is passed
Post: one's hand is drawn on the screen}
var
  Num,x: integer;
  Suit: SuitType;
begin
  x:= 20;
  for Num:= 1 to 13 do
    for Suit:= Hearts to Spades do
      If Deck[Suit, Num] = true
        then begin
          DrawCard(x, y, Suit, Num);
          x:= x + 125;
        end;
    end;
  end;
end;

end.{CardUnit}
