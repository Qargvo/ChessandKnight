program Chess;

{$APPTYPE CONSOLE}

uses
  SysUtils;
type
  chess_table = array of array of Byte;
var
  ch: chess_table;
  movek: array[1..8] of array[1..2] of ShortInt = ((-2,1),(-1,2),(1,2),(2,1),(2,-1),(1,-2),(-1,-2),(-2,-1));
  log: array of array[1..3] of Byte;
  count, si , x, y, u, v, i, j, n, m, nm: Byte;
begin
Write('Input size of the table n(line) m(row): ');
 Readln(n,m);
 nm:=n*m;
 //chess table initialization
 SetLength(ch, n, m);
 for i := 0 to n -1 do
  for j := 0 to m -1 do
    Ch[i,j]:=0;
 count := 0;
 //story table initialization
 SetLength(log, nm+1);
 for i:=0 to nm do
  log[i,3]:=0;

Readln;
end.

