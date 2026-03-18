Make the following changes:

    - Introduce adaptive progressbar:
        Since it takes a lot of time to generate data we need to add a psychologically less boring progress bar with a predicted time (based on my initial values and averging last three AI runs)
        Time taken:
            - Metadata generation:
                Add a time based on the internet upload speed because we have the file: +size/uploadspeed
                Add a time for usual AI generatiom, this could be based on size of book but we assume the initial is upto 3 minutes
            - Unit generation:
                Stage 1: This was relatively fast upto 40 seconds
                Stage 2: This took based on the metadata, when we had 10 lessons it took 1.2 min

        Psychology: Make it faster at beginning then slow down, so it will look less boring!


    - Fix multiple choice:
        As given in the answer, we faced two type of error:
            1. The anwer is wrong
            2. Even if the correct answer is selected it was shown in currect

    - Improve Big Question:
        It was supposed to be in the same format as proof question, so use that element instead of spplitting into slides


Make sure there wont be any screensize error, our ideal screen is 720x1520 with 271 dpi
When adding a new ui, create very compact design based on the theme of duolingo

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
