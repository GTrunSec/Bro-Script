@load data
event http_request(c: connection, method: string, original_URI: string, unescaped_URI: string, version: string)  

{
    if (c$http$host in QQDOMAIN::domains)
    {
        print fmt("%s,(%s)",c$http$host,c$http$user_agent);
    }
  if (/vuin/ in c$http$uri)
  {
     # print c$http$uri;
      local v: string;
      print fmt("%s",c$http$uri);
      
      }
}