Make the following changes:


Intrdouce intractive canvas art:

    Make it possible the lesson genetator can create intractive canvas art just like graphical, also enable 3D support with THREE.js:
        Give advanced example prohrams and a good template html so even the lite model can make good graphics

        also optimize the prompt so that they will create for default aspect ratio of the window rather tan full screen

Fix old generation errors:
    Include all latex guide along with prompt in order to reduce error in latex generation

Extra debug:
    Add a view reference button near to unit header (also fix that the lesson node was rendered on top of it during generation) to open the splitted pdf for that specific lesson
    Also make it possible I can edit each options and steps (in proofs) by double tap
    Add option to regenerate a whole lesson by long clicking on the node

Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
