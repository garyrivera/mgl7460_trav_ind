
    # git log --pretty='commit:%H  ad:%cd cd:%cd' --date=short --dirstat=files,10 > dirstat2.txt

    $commit = ""
    $dateAut   = ""
    $matcher=""
    $dateCommit   = ""
    $autorEmail= ""
    $commiterEmail= ""

    foreach($line in Get-Content C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\mgl7460_trav_ind\Q3\dirstat2Test.txt) {
    
    
            if(([regex]::IsMatch($line,"\bcommit:(?<commit>.*)\sad:(?<date>\d\d\d\d-\d\d-\d\d)\scd:(?<dateCommit>\d\d\d\d-\d\d-\d\d)\saE:(?<autorEmail>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))\sce:(?<commiterEmail>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))$") ) )
            {  

                $matcher =[regex]::Matches($line,"\bcommit:(?<commit>.*)\sad:(?<date>\d\d\d\d-\d\d-\d\d)\scd:(?<dateCommit>\d\d\d\d-\d\d-\d\d)\saE:(?<autorEmail>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))\sce:(?<commiterEmail>([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}))$")
                $commit =  $matcher[0].Groups["commit"].value.TrimEnd()
                $dateAut   =  $matcher[0].Groups["date"].value.TrimEnd()
				$dateCommit   =  $matcher[0].Groups["dateCommit"].value.TrimEnd()
                $autorEmail=  $matcher[0].Groups["autorEmail"].value.TrimEnd()
                $commiterEmail=  $matcher[0].Groups["commiterEmail"].value.TrimEnd()
           

            }
            elseif([regex]::IsMatch($line,"\b(?<pourcent>(\d|\d\d)\.(\d|\d\d)\%)\s(?<file>.*)$"))
            {
                    
               $matcher =[regex]::Matches($line,"\b(?<pourcent>(\d|\d\d)\.(\d|\d\d)\%)\s(?<file>.*)$")
               if($matcher.Success)
                {
                   $pourcent =  $matcher[0].Groups["pourcent"].value.TrimEnd()
                   $file   =    $matcher[0].Groups["file"].value.TrimEnd()
                  
                   $new_line = "{0};{1};{2};{3};{4};{5};{6}" -f $commit.Trim(), $dateAut.Trim(), $dateCommit.Trim(), $autorEmail, $commiterEmail, $pourcent.Trim(), $file.Trim()
                
                   Write-Output   $new_line
                 
                  Add-Content  C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\mgl7460_trav_ind\Q3\dirsta_L2.csv  $new_line
               }
            
            }
            
}