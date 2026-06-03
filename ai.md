Make the following changes:

- Enable Lesson Assistance:
    - Use gemini-flash-live (latest: search on google)
    1. It will be given current section notes (generated) as input 
    2. Simple chat screen: with optional voice input and also voice output (but still use live model because its fast), also it must be connected from the beginning to make it fluent
    3. Add this to the lesson screen, and especially give info about current open lesson and slide, so user can directly ask question about that
    4. Make sure even if its normal model it has latex support, also add model switch inside the chat if needed (like for complex problem)
    5. Add a new model type: Live in settings (along with our default model time)

Update prompt accordingly as I add new features and slide types

Always append process and instructions on readme
After applying the changes recreate project_snapshot.txt only for new files and files with changes, each time improve modularity of the program by introducing new component files (only on modified or new files), don't modify system files like pubspec, if we need new packages, or file path changes, removal etc, give the command for bash


Thoroughly check for ui sizing errors before writing the code
Note: as output only give project_snapshot and commands if needed
