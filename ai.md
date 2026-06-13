Make the following changes:


- Update default lesson generation, content chosing prompts:
    1. Force to take textbook writing style, include every theory, example, axioms, etc from textbook, also even small 
    2. Make the need of diagrams optional for each lessons, ie make diagrams only if they are needed and also reuse old diagrams like if they are already generated

- Introduce optimistic progress bar:
    - In AI requests, we dont know how much time it will take so get a predicted max time (for each request, calculated based on the model and payload, also auto update these parameter as we make requests so they become correct by time) and use this simple values to predict the max of each progress bar in ai generation
    - Using these values make every progress bar time based and also with a max value

    - When generating lesson nodes:
        Cover the generating lesson node with a rounded progress bar with above defined features

    Also update diagram generation - give the same optimistic progress bar, same goes for every kind of regeneration

    - Also make android notification also use the same progress bar but from now own let it show only one notification for entire unit, with real time progress-update


Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash