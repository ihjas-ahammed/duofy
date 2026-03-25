Make the following changes:

    - Add exam paper analysis also a notification based process so user can minimize

    - Improved personlized slide generation:
        - Initially ask a few questions to user to understand their likings on stories:
            Ask it once every user, it will be five questions with options and user can retry it on settings
    
    
    - Update lesson generation settings:
        - Add a prioirity type, like only generate if the lesson has this kind, like for proof we dont need it for all lessons
        - So make sure I can add multiple types of lessons to generate like theory, example, question etc.
            - USer can add their own types and make sure we only generate such lessons

    - Update lesson list:
        It looks like on last update u removed my section and module selector, bring it back and in lesson path only show current selected section
    
    - Fix theory screen:
        It gets more space than usual, so if there is more space, combine with next theory slide and show like two cards in same one and continue
    - Fix fill in the blank, give the same color and same spacing, it will be like I directly write between the texts even without line break
    
Make sure there wont be any screensize error, our ideal screen is 720x1520 with 271 dpi
When adding a new ui, create very compact design based on the theme of duolingo

Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
