Make the following changes:

    - Fix split pdf size issue: After I split the pdf it seems they have a certain new margin and also sometimes the content is not covered, i think this is because the split happens similar in a way we use print feature, so find another way like real split, by uding same sizing at parent pdf and also same ratio of size like if i take 10 pages from a 100 page pdf of 10 mb, the 10 pages must be near 1 mb and also have the same split without margin or different size

    - Add a new slide type:
        Intractive canvas art:
            this work as a web view, it uses canvas 2d to visualize the topic, this goes along with theory slides (like above theory, below canvas art) update the unit generation prompt for this and also add support for canvas art in the slide viewer



Make sure there wont be any screensize error, our ideal screen is 720x1520 with 271 dpi
When adding a new ui, create very compact design based on the theme of duolingo

Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
