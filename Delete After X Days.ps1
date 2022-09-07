<# ------------------------------------------------------------------

                          Simple Deletion Script

                       Written by: Mitchell Edwards
                       Created: 9/7/22

                change the FilePath location to the 
                folder you're trying to delete files in. 
                Then, delete the # before path destination.
                
                Adjust the ".AddDays(-30)" to the time
                you wish.

                Remember to use negatives when talking
                about files older than X amount of days.

------------------------------------------------------------------ #>

$FilePath = #"C:\File\Path\Here

# Set Path for items to be deleted
Get-ChildItem –Path $FilePath -Recurse |

    # Selects items where their last write time was 30 days or older. 
    Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-30))} | 

        # Deletes the items.
        Remove-Item

# To automate, setup task manager to run script every X days.