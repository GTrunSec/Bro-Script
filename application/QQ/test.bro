@load base/frameworks/software
#@load base/misc/version.bro
#@load test1

export {
	redef enum Software::Type += {
		
		QQ_PC	
		QQ_Moblie,
		QQ,
	};
 
}
redef record Software::Info  += {
	QQ_num: string &optional &log;
};

event http_header(c: connection, is_orig: bool, name: string, value: string) &priority=2
	{
	if ( is_orig )
		{
		if ( name == "USER-AGENT" )
		    {
		      if (/uin/ in c$http$uri)
		      {
		      # local temp: table[count] of string;
                local temp=split_all(c$http$uri,/^\uin=/); 
                temp=split_all(temp[3],/\&/);
                local qq: Software::Info;
                qq = [$unparsed_version=value, $host=c$id$resp_h, $host_p=c$id$resp_p, $software_type=QQ_1];
                qq$QQ_num=temp[1];
                Software::found(c$id, qq);
            }   
      
		
		}
	else
		{
		if ( name == "QQ_Moblie" )
			Software::found(c$id, [$version=[$major=1], $host=c$id$resp_h, $host_p=c$id$resp_p, $software_type=QQ_Moblie]);
		else if ( name == "QQ_CLIENT" )
			Software::found(c$id, [$unparsed_version=value, $host=c$id$resp_h, $host_p=c$id$resp_p, $software_type=QQ_CLIENT]);
	
		}
	}
