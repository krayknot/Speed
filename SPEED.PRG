SET CURSOR OFF
SET TALK OFF
CLEAR ALL
CLOSE ALL
SET COLOR TO N
CLEAR
ON ERROR DO copy_error
WAIT WINDOW "Please wait for a moment..." TIMEOUT 2

*Sets the Background of the Program
 SET CLOCK TO 0,1 COLOR SCHEME 4
 @1,0 SAY "ษออออออออออออออออออออ" COLOR W++/N++
 @2,0 SAY "บ ษออออออออออออออออออ" COLOR W++/N++
 @3,0 SAY "บ บ                  " COLOR W++/N++
 @4,0 SAY "บ บ                  " COLOR W++/N++
 @5,0 SAY "บ บ                  " COLOR W++/N++
 @6,0 SAY "บ บ                  " COLOR W++/N++
 @7,0 SAY "บ บ                  " COLOR W++/N++
 @8,0 SAY "บ บ                  " COLOR W++/N++

 @16,0 SAY "บ บ " COLOR W++/N++
 @17,0 SAY "บ บ " COLOR W++/N++
 @18,0 SAY "บ บ " COLOR W++/N++
 @19,0 SAY "บ บ " COLOR W++/N++
 @20,0 SAY "บ บ " COLOR W++/N++
 @21,0 SAY "บ บ " COLOR W++/N++
 @22,0 SAY "บ ศออออออออออออออออออ" COLOR W++/N++
 @23,0 SAY "ศออออออออออออออออออออ" COLOR W++/N++
 
 @0,61 SAY DATE() COLOR W++/N++
 @1,60 SAY "อออออออออออออออออออป" COLOR W++/N++
 @2,60 SAY "อออออออออออออออออป บ" COLOR W++/N++
 @3,60 SAY "                 บ บ" COLOR W++/N++
 @4,60 SAY "                 บ บ" COLOR W++/N++
 @5,60 SAY "                 บ บ" COLOR W++/N++
 @6,60 SAY "                 บ บ" COLOR W++/N++
 @7,60 SAY "                 บ บ" COLOR W++/N++
 @8,60 SAY "                 บ บ" COLOR W++/N++

 @16,60 SAY "                 บ บ" COLOR W++/N++
 @17,60 SAY "                 บ บ" COLOR W++/N++
 @18,60 SAY "                 บ บ" COLOR W++/N++
 @19,60 SAY "                 บ บ" COLOR W++/N++
 @20,60 SAY "                 บ บ" COLOR W++/N++
 @21,60 SAY "                 บ บ" COLOR W++/N++
 @22,60 SAY "อออออออออออออออออผ บ" COLOR W++/N++
 @23,60 SAY "อออออออออออออออออออผ" COLOR W++/N++         

@0,29 TO 2,50 DOUBLE COLOR W++
@1,34 SAY "SPEED - 1.0" COLOR W++/N++
@3,27 SAY "Copies faster than WINDOWS" COLOR BG++/N++
@4,27 SAY "Created By: Kshitij" COLOR BG++/N++
@22,27 say "KrayKnot" COLOR B++/N++
@23,27 say "Breaking Technologies" COLOR BG++/N++

DEFINE WINDOW copy_file FROM 5,15 TO 18,60 DOUBLE COLOR SCHEME 7
ACTIVATE WINDOW copy_file

@1,0 SAY "ออออออออออออออออออออออออออออออออออออออออออออ" COLOR B++/r
@8,0 SAY "ออออออออออออออออออออออออออออออออออออออออออออ" COLOR B++/r
@10,0 SAY "ออออออออออออออออออออออออออออออออออออออออออออ" COLOR B++/r

=TRAIN("Checking Drives and Directories....",0,1,"T")

*Code to extract the filename from the full pathname
source_file = GETFILE("*.*","Select the file you want to copy","Open")

sfile = FOPEN(source_file,0)

FOR i = 1 TO LEN(source_file)
temp = RIGHT(source_file,i)
temp1 = LEFT(temp,1)
 IF temp1 = "\"
  EXIT FOR
 ENDIF
ENDFOR

temp = RIGHT(temp,LEN(temp) -1)
dest = ALLTRIM(temp)

destination = GETDIR("Select","Select the Destination where you want to copy")
dest = destination + dest

 IF FILE(dest)
 @0,1 TO 0,58 CLEAR
 =TRAIN("File already exists and will overwrite",0,1,"T")  
 DO wait
 ENDIF
 
dfile = FCREATE(dest,0)

IF sfile < 0 AND dfile < 0
@0,1 TO 0,58 CLEAR
=TRAIN("File Permission Denied.",0,1,"T")
DO wait
ELSE
@0,1 TO 0,58 CLEAR
=TRAIN("File Permission Succeeded",0,1,"T")
DO wait
ENDIF

@0,1 TO 0,58 CLEAR
 =TRAIN("Collecting Information about File",0,1,"T")
DO wait

STORE 0 TO fsize
DIMENSION size(1)
=ADIR(size,source_file)
fsize = size(1,2)

STORE SPACE(10) TO mdate
mdate = DTOC(size(1,3))
mstatus = size(1,5)

file_name   = "File Name         : " + RTRIM(size(1,1))
file_size   = "File Size         : " + RTRIM(str(size(1,2)/1024) + " KB")
file_Date   = "File Creation Date: " + RTRIM(mdate)
file_time   = "File Creation Time: " + RTRIM(size(1,4))
file_status = "File Status       : " + RTRIM(mstatus)
 
@9,2 SAY "A=Archive H=Hidden R=Read only S=System"  
SET COLOR TO G++/R++
=TRAIN("File Information",2,1,"F")
SET COLOR TO gr++/r++
=TRAIN(file_name,3,1,"F")
=TRAIN(file_size,4,1,"F")
=TRAIN(file_date,5,1,"F")
=TRAIN(file_time,6,1,"F") 
=TRAIN(file_status,7,1,"F")  

STORE 0 TO loop_count,rest_bar,value
loop_count = INT(fsize/15000)

@0,1 TO 0,58 CLEAR
 =TRAIN("Copying in process. Please wait...",0,1,"T")

mbar = 1
bar_value = 3

@11,36 SAY "percent"

FOR i = 1 TO loop_count
file_read = FREAD(sfile,15000)
=FWRITE(dfile,file_read)

IF mbar != 30
@11,mbar TO 11,mbar PANEL
value = INT(mbar) + 3
@11,32 SAY ALLTRIM(STR(value))
mbar = mbar + 0.0010
ENDIF

rest_bar = INT(mbar)
ENDFOR

FOR k = rest_bar TO 30
@11,k TO 11,k PANEL
value = INT(rest_bar) + 3
@11,32 SAY ALLTRIM(STR(value))
rest_bar = rest_bar + 3
DO wait
ENDFOR

FOR l =rest_bar TO 100
value = INT(rest_bar) &&+ 3
@11,32 SAY ALLTRIM(STR(value))
rest_bar = rest_bar + 1
ENDFOR
CLOSE ALL

IF FILE(dest)
@0,1 TO 0,58 CLEAR
 =TRAIN("File has successfully copied.",0,1,"T")
WAIT WINDOW "File has successfully copied. Press any key to continue..."
CLEAR ALL
ELSE
@0,1 TO 0,58 CLEAR
 =TRAIN("File has not successfully copied.",0,1,"T")
WAIT WINDOW "File has not successfully copied. Please try again."
CLEAR ALL
clear
ENDIF

PROCEDURE wait
FOR j = 1 TO 200000
ENDFOR
RETURN

PROCEDURE train_wait
FOR j = 1 TO 80000
ENDFOR
RETURN

PROCEDURE copy_error
CLEAR ALL
WAIT WINDOW "May be you didn't select any source and destination.";
 TIMEOUT 2
CLEAR
CLEAR ALL
CANCEL
RETURN

FUNCTION TRAIN
PARAMETER string,rpos,cpos,visible
length = LEN(string)
FOR i = 1 TO length
left = LEFT(string,i)
@rpos,cpos SAY left + "" 
DO train_wait
ENDFOR
IF visible = "T"
@rpos,length + 1 SAY "" color gr++*/R++
ELSE
IF visible = "F"
@rpos,length + 1 SAY " " color gr++*/R++
ENDIF
ENDIF
RETURN
*****************************************************************
