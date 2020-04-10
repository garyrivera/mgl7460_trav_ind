
    #  git log --pretty='commit:%H date:%cd email:%ce comment:%s' --date=short --numstat --grep='fix' --source > log_commit_files_fixed.txt


    $commit = ""
    $date   = ""
    $email= ""
    $comment= ""
    $matcher=""

    foreach($line in Get-Content C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\mgl7460_trav_ind\Q8\log_commit_files_feat.txt) {
    
    
            if(([regex]::IsMatch($line,"commit:(?<commit>.*)\sdate:(?<date>\d\d\d\d-\d\d-\d\d)\semail:(?<email>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))\scomment:(?<comment>.*)$") ) )
            {

                $matcher =  [regex]::Matches($line,"commit:(?<commit>.*)\sdate:(?<date>\d\d\d\d-\d\d-\d\d)\semail:(?<email>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))\scomment:(?<comment>.*)$")
                $commit  =  $matcher[0].Groups["commit"].value.TrimEnd()
                $date    =  $matcher[0].Groups["date"].value.TrimEnd()
				$email   =  $matcher[0].Groups["email"].value.TrimEnd()
                $comment  =  $matcher[0].Groups["comment"].value.TrimEnd()
           
            }
            elseif([regex]::IsMatch($line,"^(?<added>\d*)\s*(?<deleted>\d*)\s(?<file>\S*)$"))
            {
                    
               $matcher =[regex]::Matches($line,"^(?<added>\d*)\s*(?<deleted>\d*)\s(?<file>\S*)$")
               if($matcher.Success)
                {
                   $added =  $matcher[0].Groups["added"].value.TrimEnd()
                   $deleted  =    $matcher[0].Groups["deleted"].value.TrimEnd()
                   $file=    $matcher[0].Groups["file"].value.TrimEnd()

                   $new_line = "{0};{1};{2};{3};{4};{5};{6}" -f $commit.Trim(), $date.Trim(), $email,  $added.Trim(),$deleted , $file.Trim(),$comment
                
                   Write-Output   $new_line
                 
                  Add-Content  C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\mgl7460_trav_ind\Q8\files_feat.csv  $new_line
               }
            
            }
            
}