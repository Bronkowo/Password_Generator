Add-Type -AssemblyName System.Windows.Forms

$passwortgenerator = New-Object system.Windows.Forms.Form 
$passwortgenerator.Text = "Passwortgenerator"
$passwortgenerator.TopMost = $true
$passwortgenerator.Width = 415
$passwortgenerator.Height = 215

$pw_count_label = New-Object system.windows.Forms.Label 
$pw_count_label.Text = "Anzahl der Passwoerter"
$pw_count_label.AutoSize = $true
$pw_count_label.Width = 25
$pw_count_label.Height = 10
$pw_count_label.location = new-object system.drawing.point(24,32)
$pw_count_label.Font = "Microsoft Sans Serif,10"
$passwortgenerator.controls.Add($pw_count_label) 

$pw_count_box = New-Object system.windows.Forms.TextBox 
$pw_count_box.Text = "5"
$pw_count_box.Width = 100
$pw_count_box.Height = 20
$pw_count_box.location = new-object system.drawing.point(227,32)
$pw_count_box.Font = "Microsoft Sans Serif,10"
$passwortgenerator.controls.Add($pw_count_box) 

$pw_length_label = New-Object system.windows.Forms.Label 
$pw_length_label.Text = "Laenge der Passwoerter"
$pw_length_label.AutoSize = $true
$pw_length_label.Width = 25
$pw_length_label.Height = 10
$pw_length_label.location = new-object system.drawing.point(24,77)
$pw_length_label.Font = "Microsoft Sans Serif,10"
$passwortgenerator.controls.Add($pw_length_label) 

$pw_length_box = New-Object system.windows.Forms.TextBox 
$pw_length_box.Text = "8"
$pw_length_box.Width = 100
$pw_length_box.Height = 20
$pw_length_box.location = new-object system.drawing.point(228,77)
$pw_length_box.Font = "Microsoft Sans Serif,10"
$passwortgenerator.controls.Add($pw_length_box) 

$create = New-Object system.windows.Forms.Button 
$create.Text = "Erstellen"
$create.Width = 70
$create.Height = 30
$create.location = new-object system.drawing.point(67,131)
$create.Font = "Microsoft Sans Serif,10"
$create.add_MouseClick({ 
#region Variablen
$ErrorActionPreference = "SilentlyContinue"
$Result = $null

[String]$SmallLetter = 'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
[String]$BigLetter   = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'
[String]$Numeral     = '1,2,3,4,5,6,7,8,9,0'
[String]$Symbol      = '!,",#,%,&'
[String]$All         = $SmallLetter + "," + $BigLetter + "," + $Numeral + "," + $Symbol 


[int]$Number = $pw_count_box.Text
[int]$Length = $pw_length_box.Text
#endregion

#region Errorhandling
if ($Length -lt 8)
    {
     Write-Warning -Message "Die mindest Passwortlaenge betraegt 8 Zeichen!"
     Write-Warning -Message "Darf aber nur aus Zahlen bestehen!"
     Start-Sleep -Seconds 5
     exit
    }
#endregion

#region Passwort generieren
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

#region Passwortausgabe
$Result.Split(";") | Out-File -FilePath $env:USERPROFILE\Desktop\Passwoerter.txt
$passwortgenerator.Dispose()
#endregion 
})

$passwortgenerator.controls.Add($create) 

$cancel = New-Object system.windows.Forms.Button 
$cancel.Text = "Abbrechen"
$cancel.Width = 100
$cancel.Height = 30
$cancel.location = new-object system.drawing.point(277,131)
$cancel.Font = "Microsoft Sans Serif,10"
$cancel.add_MouseClick({$passwortgenerator.Dispose()})
$passwortgenerator.controls.Add($cancel) 

[void]$passwortgenerator.ShowDialog() 
$passwortgenerator.Dispose() 