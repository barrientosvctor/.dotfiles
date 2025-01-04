Import-Module PSReadLine
Import-Module PSFzf
Set-PSReadLineOption -BellStyle None # disable the bell tone on terminal
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
