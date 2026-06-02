Make the following changes:

- Update AI Generation system:
    Schduled Generation:
        Front-end:
            A screen that shows all running AI requests with completed ones updated in real time, also scheduled ai requests:
                Also a settings option to set auto schedule hours (by defualt 9pm - 9am) and 
            A button to enabled shedule generation in long-click menu of book, modules and sections
                Also show what kind of egenaryon: text/diagrams -> for sections this means autoplan and proceed

        Back-end:
            Make sure the threading is correct,like if I set 2 parallel then only 2 parallel requests mustbe  going, every other gets  qued, and scheduled are simply mean sto qued with least priority and only be ran if within those hours

            Also if they have more than one api keys, use one for one of the paralle request to stop getting resource exhausion issue
            
        






Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
