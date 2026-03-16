Make the following changes:

    
    - Update AI generation:
        Make async working like I can also close the window and its auto added to the grid, then I can click on the grid item to see the progress

        but once the ai gets the metadata ask for confiration to split pdf
    
    - Update settings:
        Make it possible to use upto five models, like if one fails the another just like we had with api keys

    - Update lesson generation:
        Add an fix for possible string leteral errors after AI generation especially with MathJax

    - Update pdf splitting:
        - Use REAL splitting like it should decrease the file size based on the split, because there is some other kind of split somehow keeps the same file size?!

    - Update HOME SCREEN:
        - MAke it looks like app store screen.
        - Make it possible I can delete the generated books
        


    So it will be like this, I add the book and name, then click generate but this generation will be quick and it should show the loading screen, first step to get the metadata as explained in first generation, then pdf splitting and saving, then thats it

    After that I open the book and I only see the names of units and a generate button for each, when I click that unit will be generated
                
    


Make sure there wont be any screensize error, our ideal screen is 720x1520 with 271 dpi
When adding a new ui, create very compact design based on the theme of duolingo

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
