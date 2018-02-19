program Studenti(input, output, inputFile, outputFile);

type
 StudentData = record
 index : string[9];
 forename : string[20];
 surname : string[20];
 isPresent : char;
 score : real;
 end;
 StudentNodePointer = ^StudentNode;
 StudentNode = record
 student : StudentData;
 next : StudentNodePointer;
 end;
 
var
 inputFileName,outputFileName : string;
 inputFile,outputFile : text;
 head,last,newNode,previous,current,old :StudentNodePointer;
 temp : char;
 
begin
 writeln(output, 'Input file?');
 readln(input, inputFileName);
 writeln(output, 'Output file?');
 readln(input, outputFileName);
assign(inputFile, inputFileName);
 reset(inputFile);
 head := nil;
 last := nil;
 newNode := nil;
 while (not eof(inputFile)) do begin
 new(newNode);
 read(inputFile, newNode^.student.index);
 read(inputFile, temp);
 newNode^.student.forename := '';
 read(inputFile, temp);
 while (temp <> ' ') do begin

newNode^.student.forename:=newNode^.student.forename+temp;
 read(inputFile, temp);
 end;
 newNode^.student.surname:= '';
 read(inputFile, temp);
 while (temp <> ' ') do begin
 
 newNode^.student.surname:=newNode^.student.surname+temp;
 read(inputFile, temp);
 end;
 read(inputFile, newNode^.student.isPresent);
 if (newNode^.student.isPresent = 'P') then
 read(inputFile, newNode^.student.score);
 else newNode^.student.score := 0;
 newNode^.next := nil;
 readln(inputFile);
 if (head = nil) then head := newNode;
 else last^.next := newNode;
 last := newNode;
 end;
 close(inputFile);
 previous := nil;
 current := head;
 while (current <> nil) do begin
 if ((current^.student.isPresent = 'N') or
(current^.student.score <= 50)) then begin
 old := current;
 current := current^.next;
 if (previous = nil) then head := current;
 end else previous^.next := current;
 dispose(old);
 end else begin
 previous := current;
 current := current^.next;
 end;
 end;
 assign(outputFile, outputFileName);
 rewrite(outputFile);
 current := head;
 while (current <> nil) do begin
 write(outputFile, current^.student.index, ' ',
current^.student.forename, ' ', current^.student.surname, '
');
 if ((current^.student.score > 50) and
(current^.student.score <= 60)) then write(outputFile, 6);
 else if ((current^.student.score > 60) and
(current^.student.score <= 70)) then write(outputFile, 7);
 else if ((current^.student.score > 70) and
(current^.student.score <= 80)) then write(outputFile, 8);
 else if ((current^.student.score > 80) and
(current^.student.score <= 90)) then write(outputFile, 9);
 else write(outputFile, 10);
 writeln(outputFile);
 current := current^.next;
 end;
 close(outputFile);
 while (head <> nil) do begin
 old := head;
 head := head^.next;
 dispose(old);
 end;
end. 