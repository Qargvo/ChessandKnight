program Chess;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  chess_table = array of array of Byte;

function time: int64;
asm
   rdtsc
end;

procedure Write_Mas(const mas: chess_table);
var
  i, j: cardinal;
begin
  for i := Length(mas) - 1 downto 0 do
  begin
    for j := 0 to Length(mas[i]) - 1 do
      write(mas[i, j]:3);
    Writeln;
  end;
  writeln;
end;

var
  ch: chess_table;
  movek: array[1..8] of array[1..2] of ShortInt = ((-2, 1), (-1, 2), (1, 2), (2,
    1), (2, -1), (1, -2), (-1, -2), (-2, -1));
  log: array of array[1..3] of Byte;
  count, si, x, y, u, v, i, j, n, m, nm: Byte;
  outin: Boolean = True;
  t, fr: Int64;
  options_count:Cardinal=0;
   step_counter:Cardinal=0;
   fn :string = 'outfile.txt';
begin
  while true do
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
    AssignFile(Output, fn);
    Rewrite(output);
    QueryPerformanceFrequency(fr);
    t := time;
    Dec(x);
    Dec(y);
    while outin do
    begin
      Inc(count);
      ch[x, y] := count;

      //write opyion and continue
      if count = nm then
      begin

        Write_Mas(ch);
        Inc(options_count);
//        AssignFile(Output, '');
//        Writeln(options_count);
//        AssignFile(Output, fn);
          log[count, 3] := 0;
        Dec(count);
        Inc(step_counter);
        if count = 0 then
        begin
          outin := False;
          Break;
        end;
        ch[x, y] := 0;
        si := log[count, 3];
        x := log[count, 1];
        y := log[count, 2];
        Dec(count);
        Continue
      end;
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
          Inc(step_counter);
          if count = 0 then
          begin
            outin := False;
            Break;
          end;
          ch[x, y] := 0;
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
    t := time - t;
    writeln(options_count);
    CloseFile(Output);
  AssignFile(Output, '');
    writeln(' time = ', t / fr: 0: 4, ' ms');
    Writeln('Option count = ',options_count);
    ch:=nil;
    si:=0;
    outin:=true;
    options_count:=0;
     Writeln('number of step: ',step_counter) ;
     step_counter:=0;
  end;

  Readln;
end.
{QueryPerformanceFrequency(fr);
t := time;
t := time - t;
writeln('n=', n, ' time = ', t / fr: 0: 4, ' ms');    }

