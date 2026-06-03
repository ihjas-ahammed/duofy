Make the following changes:

- Support web and Implement cloud manager:
    1. For web version, since we cannot create pdf, only show a page with all published books:
        1. at home page, all published books are listed
        2. when a published book is clicked, directly open it with a path /book-id/, but still save last section open, completion progress etc. also support pyq analyzer because it doesnt need pdf splittting and saving, also save all new data in localstorage indexdb
        3. Give the same icon
        4. Support install to homescreen as web app
        5. Rename Commmunity Books -> Published Courses , also make sure Owner can also delete their own published course or unpublish if needed
    2. Cloud manager:
        1. Show last sync time in settings
        2. Add quick sync button
        3. To fix conflict when multiple device are used, when overwriting already written database element in a different version, show a confirmtaion dialog with write time of both (only if its written from another device)
        4. For published projects:
            1. Ask sync everytime the published project data is edited/new content is generated
            2. Also instead of publish to - turn that button to sync after published with last sync date


Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
