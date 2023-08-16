---
id_rsa_file: "/centos/.ssh/id_rsa"
passphrase: ""
password: "root"
nodes:
%{ for ip in compute ~}
  - ${ip} 
%{ endfor ~}
