import email, smtplib, ssl

from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

subject = "New Candidate"
body = "Can you all review this resume and let me know what you think?  A friend of mine sent it to me :) \n \n \n "
sender_email = "name@email.com"
receiver_email = ['name@email.com', 'name2@email']
#password = input("Type your password and press enter:")


# Create a multipart message and set headers
message = MIMEMultipart()
message["From"] = sender_email
#message["To"] = receiver_email
message["To"] = ", ".join(receiver_email)
message["Subject"] = subject
message["Bcc"] = ', '.join(receiver_email)  # Recommended for mass emails

# Add body to email
message.attach(MIMEText(body, "plain"))

filename = "JeffHall-resume-May-2022.docm"  # In same directory as script

# Open PDF file in binary mode
with open(filename, "rb") as attachment:
    # Add file as application/octet-stream
    # Email client can usually download this automatically as attachment
    part = MIMEBase("application", "octet-stream")
    part.set_payload(attachment.read())

# Encode file in ASCII characters to send by email    
encoders.encode_base64(part)

# Add header as key/value pair to attachment part
part.add_header(
    "Content-Disposition",
    f"attachment; filename= {filename}",
)


# Add attachment to message and convert message to string
message.attach(part)
text = message.as_string()

# Log in to server using secure context and send email
context = ssl.create_default_context()
with smtplib.SMTP_SSL("mail.smtp_server.com", 465, context=context) as server:
    #server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, text)
