function Get-RandomPassword
    {
    Param 
        (
        [int]$Number = 1,
        [int]$Length = 8,
        [Switch]$AsSecureString
        )
    #region Variable
    $Result       = $null
    $SecureResult = $null
    $PlainResult  = $null

    [String]$SmallLetter = 'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
    [String]$BigLetter   = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'
    [String]$Numeral     = '1,2,3,4,5,6,7,8,9,0'
    [String]$Symbol      = '!,",#,%,&'
    [String]$All         = $SmallLetter + "," + $BigLetter + "," + $Numeral + "," + $Symbol 
    #endregion

    #Errorhandling
    if ($Length -lt 8)
        { Write-Error -Message 'Argument "-Length" must be greater than or equal 8.' -Category InvalidData -ErrorId 666 }
    else
        {
        if ($Number -le 0)
            { Write-Error -Message 'Argument "-Number" must be greater than 0.' -Category InvalidData -ErrorId 999 }
        else 
            {
          
            #region Generate Passwords
            for ($x = 1; $x -le $Number ; $x++)
                { 
                [String]$NewPW = ""
                $NewPW += Get-Random -InputObject $SmallLetter.Split(",")
                $NewPW += Get-Random -InputObject $BigLetter.Split(",")
                $NewPW += Get-Random -InputObject $Symbol.Split(",")
            
                for ($i = 1; $i -le ($Length - 3) ; $i++)
                    { 
                    $NewPW += Get-Random -InputObject $All.Split(",")
                    }
            
                [String[]]$Result += $NewPW
                }
            #endregion
          
            #region Password Output
            if ($AsSecureString)
                {
                foreach ($Item in $Result)
                    {
                    $SecureResult += @([PSCustomObject]@{ Password = $Item ; SecurePassword = (ConvertTo-SecureString -String $Item -AsPlainText -Force)})  
                    }
                $SecureResult
                }
            else
                { 
                foreach ($Item in $Result)
                    { $PlainResult += @([PSCustomObject]@{ Password = $Item } ) }
                $PlainResult 
                }

            #endregion
            }
        }
    }