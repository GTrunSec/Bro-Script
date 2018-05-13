
@load data
event http_all_headers(c: connection, is_orig: bool, hlist: mime_header_list)

{

  if (/vuin/ in c$http$uri && c$http$host in QQDOMAIN::domains)
  {
  local temp: table[count] of string;
  temp=split_all(c$http$uri,/^\uin=/);
  temp=split_all(temp[3],/\&/);
  
  print fmt("host=%s, user_agent=%s,QQ=%s",c$http$host,c$http$user_agent,temp[1]);
  }
}
