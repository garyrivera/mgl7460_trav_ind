
     Function GetTagNormalized($tag)
{
    $arrPaternValue=(("^change.*","change"),("^release.*", "release"),("^clean.*","cleanup"),("^example.*","example"),
                      ("^build.*","build") ,("^buid.*","build"),("^buid.*","build"),("^refacor.*","refactor"),
                      ( "^refact.*","refactor"), ("^reafactor.*","refactor"),("^refactor.*","refactor"),("^refector.*","refactor"),
                      ("^refat.*","refactor"),("^reafac.*","refactor"),( "^revert.*","revert") ,( ,"^doc.*","docs") ,( "^\(doc.*","docs"),
                      ( "^bug.*","bug"),("^feat.*","feat"),("^upda.*","update"),  
                      ("^benchmark.*","benchmark"), ("^aadd.*","add"), ("^ci.*","ci"), ("^fix.*","fix"),("^ch[o|a]re.*","chore"), 
                      ("^wip.*","wip"), ("^perf.*","perf") , ("^style.*","style") , ("^typ.*","typo")  , ("^patch.*","patch"), ("^design.*","design"),("^test\(aio\).*","test"))
   
    $tag=  $tag.ToLower()
               
    $NewTag =$tag.Trim();

    for ($i=0; $i -lt $arrPaternValue.length; $i++) {

        if(([regex]::IsMatch($tag, $arrPaternValue[$i][0]) ) ){
            $NewTag=$arrPaternValue[$i][1]
            Return  $NewTag
        }
    }

    Return  $NewTag
  }
   
    #  git log --pretty='commit:%H %ce %cd %s' --date=short > commit_by_type.txt

    $commit = ""
    $email   = ""
    $date=""
	$tag   = ""
    $message   = ""
    Write-Output "debut $(Get-Date)"   

    foreach($line in Get-Content C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\Q5\commit_by_type.txt) {
    
    
            if(([regex]::IsMatch($line,"\bcommit:(?<commit>.*)\s(?<email>.*)\s(?<date>\d\d\d\d-\d\d-\d\d)\s(?<tag>.*\:)\s(?<message>.*)$") ) )
            {  

                $matcher = [regex]::Matches($line,"\bcommit:(?<commit>.*)\s(?<email>.*)\s(?<date>\d\d\d\d-\d\d-\d\d)\s(?<tag>.*\:)\s(?<message>.*)$")
                $commit  =  $matcher[0].Groups["commit"].value.TrimEnd()
                $email   =  $matcher[0].Groups["email"].value.TrimEnd()
				$date    =  $matcher[0].Groups["date"].value.TrimEnd()
				$annee    = $date.substring(0,4)
                $tag    =  $matcher[0].Groups["tag"].value.TrimEnd()
                $message    =  $matcher[0].Groups["message"].value.TrimEnd()


                $tag= GetTagNormalized($tag)
         
               $new_line = "{0}|{1}|{2}|{3}|{4}|{5}" -f $commit.Trim(),  $email.Trim(), $date.Trim(),  $tag.Trim(), $message.Trim(),$annee.Trim()

               
               Add-Content C:\Users\Gary\Documents\UQAM\H20-MGL-7460\ProjetInd\Q5\commit_by_type3.csv  $new_line
               
            }
            
}
    Write-Output "fin $(Get-Date)"   