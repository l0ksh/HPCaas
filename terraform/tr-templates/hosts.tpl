[master]
%{ for ip in master ~}
${ip}
%{ endfor ~}

[compute]
%{ for ip in compute ~}
${ip}
%{ endfor ~}
