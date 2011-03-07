Place:

function M029_jobdonenotifier('mailaddress',SubjectID,'message','attachment')

through your pipeline to get the instant notification and the report of results
direct into your e-mail address.

% M029_jobdonenotifier('mahesh.casiraghi@gmail.com',SubjectID,'The job on this is eventually done.','JDN_Disclaimer.txt')

% M029_jobdonenotifier('ciccio.ingrassia@medusa.it','soggetto_comico','Io in realta' preferivo Franco Franchi.','per_esempio.avi')

% Adapted by Mahesh from the send_mail_to()

Where:

argument 1 is the mail you want send the message to,

argument 2 is the STRING indexing the current subject (or the STRING variable stanfing for it),

argument 3 is the body of the message, and

argument 4 is the name of the file to attach.

The output is an email (if the pc is connected to internet) to your account from Matlab.JobDone.Notifier@gmail.com, with actually pretty cool information, together with the textmessage and the attachement that you specified.

I had to encrypt the funtion for the only reason of protecting the account [Matlab.JobDone.Notifier@gmail.com] from potential scamming.

If you are interested in the source code to create your own account and\or to modify the function, drop me two lines at mahesh.casiraghi@gmail.com.

Mahesh

ps> it is worth nothing that if you try to open an re-save the .p with a text editor, it won't work anymore.
