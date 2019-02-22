program Chess;

{$APPTYPE CONSOLE}

uses
  SysUtils;
type
  chess_table = array of array of Byte;
var
  ch: chess_table;
  movek: array[1..8] of array[1..2] of ShortInt = ((-2, 1), (-1, 2), (1, 2), (2,
    1), (2, -1), (1, -2), (-1, -2), (-2, -1));
  log: array of array[1..3] of Byte;
  count, si, x, y, u, v, i, j, n, m, nm: Byte;
  outin: Boolean = True;
begin
  Write('Input size of the table n(line) m(row): ');
  Readln(n, m);
  nm := n * m;
  //chess table initialization
  SetLength(ch, n, m);
  for i := 0 to n - 1 do
    for j := 0 to m - 1 do
      Ch[i, j] := 0;
  count := 0;
  //story table initialization
  SetLength(log, nm + 1);
  for i := 0 to nm do
    log[i, 3] := 0;
  Write('Input x and y: ');
  readln(x, y);
  Dec(x);
  Dec(y);
  while outin do
  begin
    Inc(count);
    ch[x, y] := count;
    if count = nm then
      Break;
    log[count, 1] := x;
    log[count, 2] := y;
    si := log[count, 3];
    while true do
    begin
      Inc(si);
      //revers
      if si > 8 then
      begin
        log[count, 3] := 0;
        Dec(count);
        if count = 0 then
        begin
          outin := False;
          Break;
        end;
        ch[x,y]:=0;
        si := log[count, 3];
        x := log[count, 1];
        y := log[count, 2];
        Continue
      end;
      // new coord
      u := x + movek[si, 1];
      v := y + movek[si, 2];
      if ((u >= 0) and (u < n)) and ((v >= 0) and (v < m)) then
        if ch[u, v] = 0 then
        begin
          log[count, 3] := si;
          x := u;
          y := v;
          Break;
        end;
    end;
  end;
  for i := n -1 downto 0 do
  begin
    for j := 0 to m - 1 do
      write(ch[i, j]:3);
    Writeln;
  end;
  Writeln(outin);
  Readln;
end.

