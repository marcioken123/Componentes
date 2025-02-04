THIS SOFTWARE IS FREEWARE.  As such, we provide no guarantees, warranties, expressed or otherwise.  If you use it, you take full responsibilities.

You are free to use this software in anyway you see fit.  We would appreciate any acknowledgement if you do use this in a commercial software or if you do not remove the header of the .PAS files.

This component allows you to store the structures of one or more tables in a text file.  Using this same component, you may recreate any one or all of the tables during runtime.  It supports only non-SQL tables like .DB, .DBF, and ASCII tables.

This may be useful if you prefer not to include your tables in your installation and create them only when needed.  This may save you space on your distribution media as text files compress more readily than binary files.  The created text file may even be smaller than the tables and its related files.

This component do not generate any code.  So you would not need to recompile your application should you change any of your table's structure.  Just change the data file and your ready to deploy.

METHODS:

procedure GetTables(aStrings: TStrings);
    This method retrieves the names of the table previously added to the 
    table structure definition file (usually an .INI).

procedure MakeTable(aTableName: string);
    Creates the table named aTableName. Allows you to selectively recreate
    one or more tables.


procedure MakeAllTables;
    Create all the tables in the INIFileName.  


procedure AddTable(aTable: TTable);
    Include aTable in the INIFileName table definitions.  


procedure AddTableData;
    add the table assigned to the property Table to the INIFileName table 
    definition.  This is an alternative to AddTable().


procedure GetStrings(aStrings: TStrings);
    Retrieve all the strings that defines all the tables in the INIFileName.
    Allowing you to view the table definitions during runtime.  (and possibly
    allow your user to alter it.  you can then save it to another file and 
    use that file to actually recreate the tables.


procedure Open;
    Open the INIFileName data file.  You have to call this before performing
    any other operations.  (This is called when you set the property Active to
    True.)

procedure Close;
    Close the INIFileName data file.  Call this to close the datafile.  This is 
    automatically called when you set the Active property to false or when this
    component is freed.  (After closing, you can then access the file for changes.)

PROPERTIES:

property Active: boolean;
    Need I say more??


property INIFileName: TFileName;
    Specifies what file to open/use.


property Table: TTable;
    Used by the component to recreate the tables.  The TTable properties does 
    not need to be set as the component replaces this during the recreation
    process.
    Also used as the input for the AddTableData method.  This is where AddTableData
    gets its table definition to store into the INIFileName. 


