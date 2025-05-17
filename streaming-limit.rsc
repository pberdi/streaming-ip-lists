
/system scheduler
add interval=24h name=update-streaming-list on-event="/tool fetch url="https://raw.githubusercontent.com/pberdi/streaming-ip-lists/main/netflix.txt" mode=http dst-path=netflix.txt
; /ip firewall address-list remove [find list=streaming]
; /ip firewall address-list add list=streaming address=52.46.0.0/18
; /ip firewall address-list add list=streaming address=52.89.224.0/19" start-time=startup

/ip firewall mangle
add chain=forward action=mark-connection new-connection-mark=streaming-conn passthrough=yes     dst-address-list=streaming

/queue tree
add name=streaming-limit parent=ether1 max-limit=2M packet-mark=streaming-conn
