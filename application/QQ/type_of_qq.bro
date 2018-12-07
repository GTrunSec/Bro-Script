#@load new-1
event http_all_headers(c: connection, is_orig: bool, hlist: mime_header_list)

{
   ##QQ_Num
  if (/uin=[0-9]/ in c$http$uri)
  {
  local qq_num: table[count] of string;
  qq_num=split_all(c$http$uri,/^\uin=/);
  qq_num=split_all(qq_num[3],/\&/);
  if (1 in qq_num)
    {
      print qq_num[1]; 
    }
  ##QQ_Version
  }
  if (/&r=/ in c$http$uri)
  {
    local qq_version: table[count] of string;
    qq_version=split_all(c$http$uri,/^\&r=/);
    if (3 in qq_version)
    {
        print qq_version[3];
    }
  }
  ##QQ_CLIENT-->HTTP::QQ_PC (Softare::type)
  if ( /\/pc\/qqclient/ in c$http$uri)
  {
   print c$http$uri;
   }
}
