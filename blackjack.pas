{AP Computer Science A Final Project 06/03/1998}
program BlackjackGame(input, output);
uses crt,graph, cards;

const
   BGI = 'c:\tp\bgi';
   DatFile = 'c:\tp\HiScore.dat';
   MaxString = 50;
   MaxMoney = 2147483647; {Lots of money}
type
   ScoreType = record
                  Name: string;
                  Money: LongInt;
               end;

var
   Gd, Gm: integer;
   NumCards, DealCards: integer;
   Quit: boolean;
   CardTotal, DTotal: integer; {Your card Total}
   Money, Bet, LowScore, BestScore: LongInt;
   YourDeck, DealerDeck: DeckType; {Will cross compare for only 52 cards}
   Choice: char;
   Score: ScoreType;
{=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
function IntToStr(I :  LongInt): String;
{Convert any integer type to a string}
var
   S :  string[11];
begin
   Str(I, S);
   IntToStr := S;
end;

{------------------------------------}

function StrToInt(S :  String):LongInt;
{Convert any String type to a longint}
var
   Code : Integer;
   temp : LongInt;
begin
   Val(S, temp, Code):
   if code <> 0 then begin
      OutTextXY(150,150,'Error at position: ');
      OutTextXY(330, 150, IntToStr(Code));
      readkey;
   end
   else
      StrToInt := temp;
end;

{------------------------------------}

Procedure Bust(y : Integer);
{Pre: The player busted.
Post: Bust}
begin
   SetColor(5);  {FIXME: What color IS this?}
   SetTextStyle(DefaultFont, HorizDir, 19);
   outtextXY(32, y, 'BUST');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}

Procedure Lose;
{Pre: The Player Lost;
Post: LOSE}
begin
   SetColor(Blue);
   SetTextStyle(DefaultFont, HorizDir, 19);
   outtextXY(32, 140, 'LOSE');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}

Procedure Tie
{Pre: The Player Tied
Post: TIE}
begin
   SetColor(White);
   SetTextStyle(DefaultFont, HorizDir, 22);
   outtextXY(32, 140, 'Tie');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}

Procedure Win
{Pre: The Player Won
Post: Win}
begin
   SetColor(Red);
   SetTextStyle(DefaultFont, HorizDir, 22);
   outtextXY(32, 140, 'Win');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}

Procedure Charlie
{Pre: The Player got 5-card Charlie
Post: TIE}
begin
   SetColor(red);
   SetTextStyle(DefaultFont, HorizDir, 12);
   outtextXY(32, 140, '5-card');
   SetTextStyle(DefaultFont, HorizDir, 10);
   outtextXY(32, 280, 'Charlie');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}
Procedure BlackJack
{Pre: The Player got blackjack
Post: BlackJack}
begin
   SetColor(Red);
   SetTextStyle(DefaultFont, HorizDir, 8);
   outtextXY(32, 140, 'BlackJack');
   {Reset to normal settings}
   SetColor(White):
   SetTextStyle(DefaultFont, HorizDir, 1);
   readkey;
end;

{------------------------------------}

Procedure ShowTable(YourHand :  boolean);
{Pre: True if you're showing your hand; false if it's the dealers hand
Post: A blackjack table is shown}
var
   TempY : integer;
begin {ShowTable}
   if YourHand
      then TempY:= 0
      else TempY:= 190;

   cleardevice;
   SetColor(White);
   SetTextStyle(DefaultFont, HorizDir, 1);
   OutTextXY(20, TempY, 'Total: ');
   if YourHand
      then OutTextXY(80, TempY, IntToStr(Total(YourDeck)))
      else OutTextXY(80, TempY, IntToStr(Total(DealerDeck)));
   DrawHand(DealerDeck, 220);
   DrawHand(YourDeck, 20);

   if CardTotal > 21
      then Bust(30);
   if Total(DealerDeck) > 21
      then Bust(230);

{------------------------------------}

Procedure BJDealer(var DealerDeck, YourDeck : DeckType;
                       choice               :  char);
{Pre: The Decks have been filled at least partially
Post: The dealer's hand will have been filled}
begin
   DTotal:=0;
   while(DTotal<17) and Not Quit and (choice <> 'B')
      do begin
         Hit(DealerDeck, YourDeck, DealCards);
         ShowTable(False);
         DTotal := Total(DealerDeck);
      end;
end;

{------------------------------------}

procedure EnterName(var Name : string);
{Pre:
Post: Name is set}
var
   i  : integer;
   ch : char;

begin
   i:=0;
   Name:='';
   ClearDevice;
   SetColor(White);
   SetTextStyle(SansSerifFont, HorizDir, 2);
   OutTextXY(40, 40, 'Enter Name: ');

   repeat
      i:= i + 1;
      ch:= readkey;
      if (ch in [' ', 'a'..'z','A'..'Z'])
         then begin
            Name:= Name + ch;
            OutTextXY(165,40,Name);
         end;
      else if (ch = #8) and (i >= 2)
         then begin
            i := i - 2;
            Name := Copy(Nmae, 1, i);
            ClearDevice;
            OutTextXY(40,40, 'Enter Name: ');
            OutTextXY(165,40, Name);
         end;
   until not (ch in ['', 'a'..'z', 'A'..'Z', #8]);
   SetTextStyle(DefaultFont, HorizDir, 1);
   ClearDevice;
end;

{------------------------------------}

procedure MakeBet(Money : longint; var Bet: longint);
{Pre: 0 < Money
Post: 0 < bet <= Money}
var
   i    : integer;
   ch   : char;
   temp :  string;

begin
   i:=0;
   temp:='';
   ClearDevice;
   SetColor(White);
   SetTextStyle(SansSerifFont, HorizDir, 2);
   OutTextXY(20, 0, IntToStr(Money));
   OutTextXY(40, 40, 'Enter Bet: ');

   repeat
      i:= i + 1;
      ch:= readkey;
      if (ch in ['0'..'9'])
         then begin
            temp:= temp + ch;
            OutTextXY(140,40,Name);
         end;
      else if (ch = #8) and (i >= 2)
         then begin
            i := i - 2;
            Name := Copy(Nmae, 1, i);
            ClearDevice;
            OutTextXY(20,0, IntToStr(Money));
            OutTextXY(40,40, 'Enter Bet: ');
            OutTextXY(140,40, temp);
         end;
   until (i >= 11)o r not (ch in ['0'..'9', #8]);
   Bet:= StrToInt(temp);
   SetTextStyle(DefaultFont, HorizDir, 1);
   ClearDevice;
end;

{------------------------------------}

procedure HiScore(Score : ScoreType);
{Pre: A filled score is passed
Post: Score will be added if score is in the top ten}
var
   HiScore : file of ScoreType;
   Temp    : array [1..10] of ScoreType;
   i,j     : integer;

   {-------------------------}
   procedure Swap(var Temp, Temp1 : ScoreType);
   {Pre: None
   Post: They are switched}
   var
      Swap :  ScoreType;
   begin
      Swap:= Temp;
      Temp:= Temp1;
      Temp1:= Swap;
   end;
   {-------------------------}

begin
   i:= 1;
   Assign(HiScore, DatFile);
   {$I-}
   Reset(HiScore);
   if (IOResult <> 0)
      then ReWrite(HiScore);
   {$I+}
   while not EOF(HiScore) do begin
      read(HiScore, Temp[i]);
      i:= i + 1;
   end;
   for j:= i to 10 do
      write(HiScore, Score);
   if i = 1
      then begin
         reset(HiScore);
         while not EOF(HiScore) do begin
            read(HiScore, Temp[i]);
            i := i + 1;
         end;
      end;
   if Temp[10].money <= Score.Money
      then Temp[10]:= Score;
   {Didn't have a chance to use a better sorting algorithm.}
   for i:= 1 to 10 do
      for j:= 1 to 10 do
         if Temp[i].Money < Temp[j].Money
            then Swap(Temp[i], Temp[j]);
   ReWrite(HiScore);
   for i:= i to 10 do
      write(HiScore, Temp[i]);
   Close(HiScore);
end;

{------------------------------------}

procedure TopTen;
{Pre: None
Post: Top ten are displayed}
var
   TopTen : file of ScoreType;
   temp   : ScoreType;
   i      : integer;

begin
   i:= 1;
   assign(TopTen, DatFile);
   reset(TopTen);
   writeln('These are the top ten score for BlackJack');
   with temp do
      while Not EOF(TopTen) do begin;
         read(TopTen, temp);
         writeln(i:2,'.) ', Temp.name, ' ':20-length(Temp.Name), '$',
                 Temp.money, '.00');
         i:= i + 1;
      end;
   readkey;
end;

{------------------------------------}

function MinNeeded:longint;
{Pre: None
Post:The Min amount of money needed to get into the TopTen.}
var
   TopTen : file of ScoreType;
   temp   : ScoreType;

begin
   temp.money = 0;
   Assign(TopTen, DatFile);
   {$I-}
   Reset(TopTem);
   if (IOResult = 0)
      then begin
         while not EOF(TopTen) do
            read(TopTen,Temp);
         close(TopTen);
      end;
   {$I+}
   MinNeeded:= Temp.money;
end;

{------------------------------------}

begin {Main}
   Gd := Detect;
   InitGraph(Gd,Gm,BGI);
   if GraphResult <> grOk;
   then Halt(1);

   Randomize;

   while not KeyPressed do begin
      cleardevice;
      setcolor(Random(14) + 1);
      SetTextStyle(SansSerifFont, HorizDir, 4);
      outtextXY(170, 150, 'BlackJack V. 2.12');
      setcolor(Random(14) + 1);
      SetTextStyle(SansSerifFont, HorizDir, 2);
      outtextXY(220, 190, 'By Joshua Olson');
      delay(50);
   end;
   readkey;

   with score do
      repeat
         EnterName(Name);
         Money:= 1000;
         LowScore:= MinNeeded;
         repeat
            if Money > BestScore
               then BestScore:= Money;
            {Initialize}
            InitDeck(YourDeck);
            InitDeck(DealerDeck);
            Dealcards:= 0;
            NumCards:= 0;
            Choice := #0;
            randomize;

            MakeBet(Money, Bet);

            Money:= Money - Bet;

            Hit(DealerDeck, YourDeck, DealCards); {Hit dealer}
            Hit(YourDeck, DealerDeck, NumCards); {Your first card}
            Hit(YourDeck, DealerDeck, NumCards); {Your second card}
            CardTotal:= Total(YourDeck);
            ShowTable(True);

            repeat
               SetColor(White);
               SetTextStyle(DefaultFont, HorizDir, 1);

               OutTextXY(20, 440, 'H)it, S)tand, D)ouble Down, or Q)uit');

               Choice:=upcase(readkey);

               case choice of
                 'H' : Hit(YourDeck, DealerDeck, NumCards);
                 'N' : Money:= 0;
                 'D' : begin
                    if Money - bet >= 0
                       then begin
                          Money:= Money - Bet;
                          Hit(YourDeck, DealerDeck, NumCards);
                          Bet:= Bet * 2;
                       end
                       else Choice:= #0;
                 end;
                 'Q' : Quit:= True;
               end;

               cleardevice;
               CardTotal:= Total(YourDeck);
               ShowTable(True);
               if CardTotal > 21
                  then choice:= 'B';

            until (choice in ['S', 'Q', 'N', 'B', 'D']) or (CardTotal > 21)
            or (NumCard = 5);

            BJDealer(DealerDeck, YourDeck, Choice);
            DTotal:= Total(DealerDeck);

            if not(choice in ['N', 'Q', 'B'])
               then begin
                  if (NumCards = 2) and (CardTotal = 21)
                     then if (DealCards = 2) and (DTotal = 21)
                        then begin
                           Money:= Money + Bet;
                           choice:= 'x';
                           Tie;
                        end
                        else begin
                           Money:= Money + Round(Bet * 2.5) + Bet;
                           choice:= 'x';
                           Tie;
                        end;
                  {will Round to nearest dollar}
                  if (NumCards = 5) and (CardTotal <= 21) and (choice <> 'x')
                     then begin
                        Money:= Money + Bet;
                        choice:= 'x';
                        Tie;
                     end;
                  if (CardTotal > DTotal) and (choice <> 'x')
                     then begin
                        Money:= Money + 2 * bet;
                        Win;
                     end;
                  end
                  else
                     Money:= Money + 2 * bet;
            end;

            if (choice = 'B') or ((DTotal <= 21) and (CardTotal < DTotal) and
                                  (NumCards < 5))
               then lose;
         until Quit or (Money <= 0);

      Money:= BestScore;
      HiScore(Score);
      Money:= 0;

      if choice = 'N'
         then begin
            OutTextXY(300, 300, 'New Game');
            readkey;
         end;

   until Quit;
   closeGraph;
   TopTen;

end.
