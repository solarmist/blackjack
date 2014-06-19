{AP Computer Science A Final Project 06/03/1998}

unit Cards;

interface
uses Graph;

type
   SuitType = (Hearts, Diamonds, Clubs, Spades);
   SuitNum  = array [1..13] of boolean;
   DeckType = array [Hearts..Spades] of SuitNum;

procedure DrawCard(x,y : integer, var CType:SuitType, num:integer);
{Pre: (x,y)
Post: A card is drawn}
{------------------}
procedure DrawHand(var Deck : DeckType, y:integer);
{Pre: Y is set correctly and a valid deck is passed
Post: one's hand is drawn on the screen}
{------------------}
procedure RandSuit:SuitType;
{Pre: none
Post: A random suit is returned.}
{------------------}
procedure InitDeck(var Deck :DeckType);
{Pre: A deck is passed
Post: An unused deck is returned}
{------------------}
procedure Total(var Deck :DeckType);
{Pre: A single hand is in the deck
Post: The total of the cards is returned}
{------------------}
procedure Hit(var Deck,Deal : DeckType, var NumCards:integer;
{Pre: A deck is passed
Post: A card is added to your hand and NumCards is + 1}
