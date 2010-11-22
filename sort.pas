unit Sort;

interface

uses Windows,SysUtils;

procedure QuickSort(var Vals:Array of double;ACount:Integer);

implementation

procedure QuickSort(var Vals:Array of double;ACount:Integer);

  procedure PerformQuickSort(ALo,AHi:Integer);
  var i,j,k,m:Integer;
      Hold:Double;
  begin
    i:=ALo;j:=AHi;
    Hold:=Vals[(ALo + AHi) shr 1];
    //for starters take the midpoint value as the comparison value CV

    repeat
      repeat
        m:=ord(Vals[i] < Hold) or (ord(Vals[j] > Hold) shl 1);
        inc(i,ord(m and 1 > 0));
        dec(j,ord(m and 2 > 0));
        {Most implementations use two while loops. For moderately
         large values of ACount there is a significant benefit in
         using a single repeat loop and some math as we have done
         here.}
      until (m = 0);
      {We do the following

       a. Increase i until Vals[i] >= CV
       b. Decrease j until Vals[j] <= CV
      }


      if (i <= j) then
      begin
        Hold:=Vals[i];
        Vals[i]:=Vals[j];
        Vals[j]:=Hold;
        inc(i);dec(j);
      {If i is to the left of, or same as, j then we swap Vals
       at i & j. Incidentally this gives us a new CV}
      end;
    until (i > j);
    //keep repeating until i > j

    if (ALo < j) then PerformQuickSort(ALo,j);
    if (i < AHi) then PerformQuickSort(i,AHi);
  end;

begin
  PerformQuickSort(0,ACount - 1);
end;

End.
