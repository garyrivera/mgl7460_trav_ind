
   $files = Get-ChildItem *.txt
   $pattern = "^\d{0,3}\,?\d{0,3}\,?\d{0,3}\,?\d{0,3}\,?\d{0,3}\,?d{0,3}[\S|\s]"

        Write-Output   $files
  
  ForEach ($file in $files)  {

        
        $file_new = "NEW_{0}"  -f $file.Name
        $file_new = $file_new.Replace('.txt','.csv')


        Write-Output   $file_new 
        Write-Output   $file


        foreach($line in Get-Content $file) {
    
                 if(([regex]::IsMatch($line,$pattern) ) )
                {  

                    $new_line = $line.Replace(',','')
                    $new_line = $new_line.Replace(' ** ',' ')
                    $new_line = $new_line.Replace('    *--------* ',' ')

                }

                Write-Output   $new_line
                Add-Content   $file_new  $new_line
        }
    }
