Make the following changes:

    - Fix pdf split file size:
        It looks like all pdfs I split have parent file size, which makes the whole idea of splitting worthless
        So, make sure size gets reduced on split, if a new library is needed use that
        Also while doing this make sure u wont do anything like print over pdf, u could do some new method like converting whole pdf into small quality images and combining them back based on the pages for each split, anyway use most relevent and fast method and also show each process on the loading, make sure you wont create pdf of another frame size which will lead to losing part of a page
    - Give lesson spacing, for a better look of the lesson path


Make sure there wont be any screensize error, our ideal screen is 720x1520 with 271 dpi
When adding a new ui, create very compact design based on the theme of duolingo

Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
